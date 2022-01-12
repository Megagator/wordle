//
//  SaveManager.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/9/22.
//

import Foundation

class SaveManager: ObservableObject {
    static let shared = SaveManager()
    static let mocked = SaveManager(save: Mocks.gameSave)

    private let defaults = UserDefaults.standard
    private let saveKey: String = "gameSave"
    @Published private(set) var save: GameSave
    private var isMock = false
    
    private init() {
        if let gameSave = defaults.object(forKey: saveKey) as? Data {
            let decoder = JSONDecoder()
            if let decodedSave = try? decoder.decode(GameSave.self, from: gameSave) {
                save = decodedSave
            } else {
                save = GameSave(results: [])
            }
        } else {
            save = GameSave(results: [])
        }
    }
    
    // for mocks
    init(save: GameSave) {
        self.save = save
        self.isMock = true
    }
    
    func addGame(result: GameResult) {
        save.results.insert(result, at: 0)
        
        persist()
    }
    
    func updateGame(guesses: [Guess], didWin: Bool) {
        let gameNumber = WordsModel.todaysNumber()
        let newGame = GameResult(day: gameNumber, guesses: guesses, didWin: didWin)

        for i in save.results.indices {
            if save.results[i].day == gameNumber {
                save.results[i] = newGame
                persist()
                return
            }
        }
        
        // if not found, add it
        addGame(result: newGame)
    }
    
    func loadGame() -> GameResult? {
        let gameNumber = WordsModel.todaysNumber()

        for result in save.results {
            if result.day == gameNumber {
                return result
            }
        }
        
        return nil
    }
    
    func persist() {
        if isMock { return }

        let encoder = JSONEncoder()
        if let encodedSave = try? encoder.encode(save) {
            defaults.set(encodedSave, forKey: saveKey)
        }
    }
    
    func deleteSave() {
        save.results = []
        if isMock { return }

        let encoder = JSONEncoder()
        if let encodedSave = try? encoder.encode(save) {
            defaults.set(encodedSave, forKey: saveKey)
        }
    }
    
    deinit {
        persist()
    }
}

struct GameSave: Codable {
    var results: [GameResult]
}

struct GameResult: Codable {
    let day: Int
    let guesses: [Guess]
    let didWin: Bool
}
