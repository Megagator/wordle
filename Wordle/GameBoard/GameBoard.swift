//
//  ContentView.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/3/22.
//

import SwiftUI

struct GameBoard: View {
    @EnvironmentObject var guessingModel: GuessingModel
    @State var isEndGame = false
    
    var body: some View {
        VStack {
            GameNav()
            Spacer()
            Grid()
            Spacer()
            ZStack {
                Keyboard()
                    .opacity(guessingModel.gameOver ? 0.25 : 1)
                ResultsButton(next: $isEndGame)
                    .opacity(guessingModel.gameOver ? 1 : 0)
            }
            Spacer()
        }
        .sheet(isPresented: $isEndGame) {
            EndGame()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard()
            .environmentObject(GuessingModel())
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.dark)
        GameBoard()
            .environmentObject(GuessingModel())
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.light)
    }
}
