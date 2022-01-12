//
//  SummaryShare.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct SummaryShare: View {
    let result: GameResult?
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.colorSchemeContrast) var contrast

    func guessToEmoji() -> String {
        guard let result = result else { return "" }

        let absentSquare = colorScheme == .light ? "⬜" : "⬛"
        var guesses: [String] = []

        for g in result.guesses {
            if g.currentLetter == 0 {
                continue
            }

            var guess = ""
            for l in g.letters {
                switch l.state {
                case .NotGuessed, .Absent:
                    guess += absentSquare
                case .WrongPlacement:
                    guess += contrast == .increased ? "🟦" : "🟨"
                case .Correct:
                    guess += contrast == .increased ? "🟧" : "🟩"
                }
            }
            guesses.append(guess)
        }
        
        let header = "Wordle \(result.day) \(guesses.count)/6"
        guesses.insert("", at: 0)
        guesses.insert(header, at: 0)
        
        return guesses.joined(separator: "\n")
    }

    var body: some View {
        VStack {
            Text(guessToEmoji())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color.blue)
                )
            Button(action: {
                UIPasteboard.general.string = guessToEmoji()
            }, label: {
                Image(systemName: "doc.on.clipboard")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .foregroundColor(.blue)
                    .background(Color.secondarySystemBackground)
                    .cornerRadius(20)
            })
                .padding()
        }
    }
}

struct SummaryShare_Previews: PreviewProvider {
    static var previews: some View {
        SummaryShare(result: Mocks.gameWinIn4)
            .preferredColorScheme(.dark)
        SummaryShare(result: Mocks.gameSave.results[3])
    }
}
