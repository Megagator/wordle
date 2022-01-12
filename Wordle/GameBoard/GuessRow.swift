//
//  GuessRow.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/3/22.
//

import SwiftUI

struct GuessRow: View {
    let guess: Guess
    var body: some View {
        HStack(spacing: 3) {
            ForEach(guess.letters) {
                GuessView(letter: $0)
            }
        }
    }
}

struct GuessView: View {
    @Environment(\.colorScheme) var colorScheme
    let letter: Letter
    
    func makeStateColor(state: GuessResult, isBorder: Bool = false) -> Color {
        switch state {
        case .NotGuessed:
            return isBorder ? Color.border : Color.clear
        case .WrongPlacement:
            return Color.wrongPlacement
        case .Absent:
            return Color.absent
        case .Correct:
            return Color.correct
        }
    }
    
    func makeStateTextColor(state: GuessResult) -> Color {
        switch state {
        case .NotGuessed:
            return colorScheme == .light ? Color.black :  Color.whiteText
        default:
            return Color.whiteText
        }
    }

    var body: some View {
        Text(letter.string.uppercased())
            .frame(width: 32)
            .font(.system(size: 28, weight: .heavy, design: .default))
            .foregroundColor(makeStateTextColor(state: letter.state))
            .padding()
            .background(makeStateColor(state: letter.state))
            .border(makeStateColor(state: letter.state, isBorder: true), width: 2)
//            .animation(.easeInOut.delay(0.25 * Double(letter.id)))
            .transition(.opacity)
            
    }
}

struct GuessRow_Previews: PreviewProvider {
    static var previews: some View {
        GuessRow(guess: Mocks.guess)
            .environmentObject(GuessingModel())
            .preferredColorScheme(.dark)
        GuessRow(guess: Guess(word: "Hoh"))
            .environmentObject(GuessingModel())
            .preferredColorScheme(.dark)
        GuessRow(guess: Guess(word: "Hoh"))
            .environmentObject(GuessingModel())
            .preferredColorScheme(.light)
        GuessRow(guess: Mocks.guess)
            .environmentObject(GuessingModel())
            .preferredColorScheme(.light)
    }
}
