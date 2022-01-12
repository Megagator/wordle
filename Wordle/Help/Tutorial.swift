//
//  Tutorial.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct Tutorial: View {
    let guessCorrect = Guess(word: "weary", against: "w1234")
    let guessMisplaced = Guess(word: "pilot", against: "l1234")
    let guessUnused = Guess(word: "vague", against: "12345")

    var body: some View {
        VStack {
            ModalSheetDismissGrabber()
            Spacer()
            
            ScrollView {
                Text("HOW TO PLAY")
                    .font(.system(size: 24, weight: .black, design: .default))
                    .foregroundColor(.label)
                    .padding()
                VStack(alignment: .leading) {
                    Text("Guess the WORDLE in 6 tries.")
                        .padding(.bottom)
                    Text("After each guess, the color of the tiles will change to show how close your guess was to the word.")
    //                Divider()
    //                    .padding()
                }
                    .font(.system(size: 16))
                    .padding()
     
                VStack(alignment: .leading) {
                    GuessRow(guess: guessCorrect)
//                        .scaleEffect(0.75, anchor: .leading)
                    Text("The letter **W** is in the word and in the correct spot.")
                        .padding(.bottom)
                    GuessRow(guess: guessMisplaced)
//                        .scaleEffect(0.75, anchor: .leading)
                    Text("The letter **L** is in the word but in the wrong spot.")
                        .padding(.bottom)
                    GuessRow(guess: guessUnused)
//                        .scaleEffect(0.75, anchor: .leading)
                    Text("None of these letters are used in the correct word")
                    Divider()
                        .padding()
                    Text("A new **WORDLE** will be available each day!")
                }
                    .font(.system(size: 16))
                    .padding()


                Spacer()
            }
        }
    }
}

struct Tutorial_Previews: PreviewProvider {
    static var previews: some View {
        Tutorial()
            .previewDevice("iPhone 13")
            .preferredColorScheme(.dark)
            
        Tutorial()
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.light)
    }
}
