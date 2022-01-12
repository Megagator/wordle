//
//  Mocks.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/9/22.
//

import Foundation

class Mocks {
    static let guess = Guess(word: "holly", against: "boast")
    static let sixGuesses: [Guess] = [guess, guess, guess, guess, guess, guess]

    static let gameSave = GameSave(results: [
        GameResult(day: 24, guesses: sixGuesses, didWin: true),
        GameResult(day: 25, guesses: sixGuesses, didWin: true),
        GameResult(day: 26, guesses: sixGuesses, didWin: true),
        GameResult(day: 27, guesses: sixGuesses, didWin: false),
        GameResult(day: 28, guesses: sixGuesses, didWin: true),
        GameResult(day: 29, guesses: sixGuesses, didWin: true),
        GameResult(day: 30, guesses: sixGuesses, didWin: true),
        GameResult(day: 35, guesses: sixGuesses, didWin: true),
    ])
    
    static let gameWinIn4 = GameResult(day: 69, guesses: [
        Guess(word: "teary", against: "drink"),
        Guess(word: "crows", against: "drink"),
        Guess(word: "unlid", against: "drink"),
        Guess(word: "drink", against: "drink")
    ], didWin: true)
    
    static let statsModel = StatsModel(save: gameSave)
}
