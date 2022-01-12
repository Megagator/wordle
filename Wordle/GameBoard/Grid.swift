//
//  Grid.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/3/22.
//

import SwiftUI

struct Grid: View {
    @EnvironmentObject var guessingModel: GuessingModel

    var body: some View {
        VStack(spacing: 3) {
            ForEach(guessingModel.guesses) {
                GuessRow(guess: $0)
            }
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
            .environmentObject(GuessingModel())
    }
}
