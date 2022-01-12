//
//  WordleApp.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/3/22.
//

import SwiftUI

@main
struct WordleApp: App {
    let guessingModel = GuessingModel()

    var body: some Scene {
        WindowGroup {
            GameBoard()
                .environmentObject(guessingModel)
        }
    }
}
