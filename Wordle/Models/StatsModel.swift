//
//  Stats.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/9/22.
//

import Foundation

class StatsModel {
    private let save: GameSave
    
    init(save: GameSave) {
        self.save = save
    }
    
    func gamesPlayed() -> Int {
        return save.results.count
    }
    
    func gamesWon() -> Int {
        var wins = 0
        for result in save.results {
            if result.didWin {
                wins += 1
            }
        }
        
        return wins
    }
    
    func winPercentage() -> Int {
        let decimal = Double(gamesWon()) / Double(gamesPlayed())
        let percentage = decimal * 100
        return Int(round(percentage))
    }
    
    func streaks() -> WinStreaks {
        var currentStreak = 0
        var maxStreak = 0
        var lastDay = 0
        
        for result in save.results {
            // if it was a win and a consequtive day
            if result.didWin && lastDay == result.day - 1 {
                currentStreak += 1
            } else if result.didWin {
                currentStreak = 1
            } else {
                if currentStreak > maxStreak {
                    maxStreak = currentStreak
                }
                currentStreak = 0
            }
            
            lastDay = result.day
        }
        
        if currentStreak > maxStreak {
            maxStreak = currentStreak
        }
        
        return WinStreaks(maxStreak: maxStreak, currentStreak: currentStreak)
    }
    
    func guessDistrib() -> [Int:Int] {
        var guesses: [Int:Int] = [:]
        
        for i in 1...6 {
            guesses[i] = 0
        }

        for result in save.results {
            if result.didWin {
                var guessCount = 0
                for g in result.guesses {
                    if g.currentLetter > 0 {
                        guessCount += 1
                    }
                }

                // clamp range to not force unwrap a nil
                guessCount = min(max(1, guessCount), 6)
                guesses[guessCount]! += 1
            }
        }
        
        return guesses
    }
}

struct WinStreaks {
    let maxStreak: Int
    let currentStreak: Int
}
