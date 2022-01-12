//
//  GuessingModel.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/3/22.
//

import Foundation
import SwiftUI

class GuessingModel: ObservableObject {
    @Published private(set) var guesses: [Guess]
    @Published private(set) var guessLog: [Character: GuessResult]
    @Published private(set) var gameState: GameState {
        didSet {
            withAnimation {
                gameOver = gameState == .Failed || gameState == .Correct                
            }
            
            if gameOver {
                saveGame()
            }
        }
    }
    @Published var gameOver: Bool
    
    var currentGuess: Int
    
    init() {
        currentGuess = 0
        guessLog = [:]
        gameState = .Begin
        gameOver = false
        guesses = []

        if let result = SaveManager.shared.loadGame() {
            guesses = result.guesses

            // replay the guesses
            for g in self.guesses {
                if g.currentLetter == 5 {
                    self.guess()
                }
            }
            
        } else {
            // new game
            for i in 1...6 {
                guesses.append(Guess(id: i))
            }
        }
    }
    
    func reset() {
        currentGuess = 0
        guessLog = [:]
        gameState = .Begin
        gameOver = false
        guesses = []

        for i in 1...6 {
            guesses.append(Guess(id: i))
        }
    }
    
    func saveGame() {
        SaveManager.shared.updateGame(
            guesses: guesses,
            didWin: gameState == .Correct
        )
    }
    
    func addToGuess(_ c: Character) {
        if gameState == .Correct || gameState == .Failed {
            return
        }
        guesses[currentGuess].add(c)
    }
    
    func removeFromGuess() {
        if gameState == .Correct || gameState == .Failed {
            return
        }
        guesses[currentGuess].remove()
    }
    
    func guess() {
        if gameState == .Correct || gameState == .Failed {
            return
        }
        
        gameState = guesses[currentGuess].submit()
        
        if gameState == .Correct || gameState == .GoodGuess {
            withAnimation {
                updateGuessLog(guess: guesses[currentGuess])
            }
        }
        
        if gameState == .GoodGuess {
            currentGuess += 1
        }

        if currentGuess > 5 {
            gameState = .Failed
        }
        
        saveGame()
    }
    
    func updateGuessLog(guess: Guess) {
        for l in guess.letters {
            if let c = l.char {
                if let state = guessLog[c] {
                    if state != .Correct {
                        guessLog[c] = l.state
                    }
                } else {
                    guessLog[c] = l.state
                }
            }
        }
    }
}

struct Guess: Identifiable, Codable {
    let id: Int
    private(set) var letters: [Letter]
    private(set) var currentLetter = 0
    
    init(id: Int) {
        self.id = id
        letters = []
        for i in 1...5 {
            letters.append(Letter(id: i))
        }
    }
    
    init(word: String, against correctWord: String? = nil) {
        self.id = Int.random(in: 1..<999999)
        letters = []
        var i = 0
        for c in word {
            letters.append(Letter(id: i, c))
            i += 1
        }
        while i < 5 {
            letters.append(Letter(id: i))
            i += 1
        }

        if let correctWord = correctWord {
            gradeLetters(against: correctWord)
        }
    }
    
    mutating func add(_ c: Character) {
        if currentLetter < letters.count {
            letters[currentLetter].char = c
            currentLetter += 1
        }
    }
    
    mutating func remove() {
        if currentLetter > 0 {
            currentLetter -= 1
            letters[currentLetter].char = nil
        }
    }
    
    mutating func submit() -> GameState {
        if currentLetter != 5 {
            return .NotEnoughLetters
        }
        
        var word = ""
        for l in letters {
            if let c = l.char {
                word.append(c)
            }
        }
        
        if WordsModel.checkGuess(guess: word) {
            gradeLetters()
            if word == WordsModel.todaysWord() {
                return .Correct
            }
            return .GoodGuess
        } else {
            return .NotInDictionary
        }
    }
    
    mutating func gradeLetters(against word: String = WordsModel.todaysWord()) {
        var correctWord = word

        var misplacedes: [Character: Int] = [:]
        var i = 0
        while i < letters.count {
            if letters[i].state == .Correct {
                i += 1
                continue
            }

            let letterIndex = correctWord.index(correctWord.startIndex, offsetBy: i)
            let correctLetter = correctWord[letterIndex]
            let guessedLetter = letters[i].char!

            if correctLetter == guessedLetter {
                letters[i].state = .Correct
                // eliminate match and start over to eliminate any prior wrong-placement guesses
                correctWord.replaceSubrange(letterIndex...letterIndex, with: "*")
                i = 0
                misplacedes = [:]
            } else if correctWord.contains(guessedLetter) &&
                    (misplacedes[guessedLetter] ?? 0) < countOf(letter: guessedLetter, in: correctWord)
            {
                // track the number of misplaced letters so we don't report multiple misses for the same correct letter
                misplacedes[guessedLetter] = (misplacedes[guessedLetter] ?? 0) + 1
                letters[i].state = .WrongPlacement
                i += 1
            } else {
                letters[i].state = .Absent
                i += 1
            }
        }
    }
    
    func countOf(letter: Character, in word: String) -> Int {
        var count = 0
        for c in word {
            if c == letter {
                count += 1
            }
        }
        return count
    }
}

enum GameState {
    case Begin
    case NotEnoughLetters
    case NotInDictionary
    case GoodGuess
    case Correct
    case Failed
}

struct Letter: Identifiable, Codable {
    let id: Int
    var char: Character?
    var state = GuessResult.NotGuessed
    
    init(id: Int, _ c: Character? = nil) {
        self.id = id
        char = c
    }
    
    var string: String {
        String(self.char ?? " ")
    }
}

enum GuessResult: Codable {
    case NotGuessed
    case Absent
    case WrongPlacement
    case Correct
}

extension Character: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)

        self = Character(string)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(self))
    }
}
