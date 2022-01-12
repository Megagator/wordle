//
//  Keyboard.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/6/22.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var guessingModel: GuessingModel

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: Constants.paddingBetweenKeyRows) {
                HStack(spacing: Constants.paddingBetweenKeys) {
                    Key(char: "q", maxWidth: geo.size.width)
                    Key(char: "w", maxWidth: geo.size.width)
                    Key(char: "e", maxWidth: geo.size.width)
                    Key(char: "r", maxWidth: geo.size.width)
                    Key(char: "t", maxWidth: geo.size.width)
                    Key(char: "y", maxWidth: geo.size.width)
                    Key(char: "u", maxWidth: geo.size.width)
                    Key(char: "i", maxWidth: geo.size.width)
                    Key(char: "o", maxWidth: geo.size.width)
                    Key(char: "p", maxWidth: geo.size.width)
                }
                HStack(spacing: Constants.paddingBetweenKeys) {
                    Key(char: "a", maxWidth: geo.size.width)
                    Key(char: "s", maxWidth: geo.size.width)
                    Key(char: "d", maxWidth: geo.size.width)
                    Key(char: "f", maxWidth: geo.size.width)
                    Key(char: "g", maxWidth: geo.size.width)
                    Key(char: "h", maxWidth: geo.size.width)
                    Key(char: "j", maxWidth: geo.size.width)
                    Key(char: "k", maxWidth: geo.size.width)
                    Key(char: "l", maxWidth: geo.size.width)
                }
                HStack(spacing: Constants.paddingBetweenKeys) {
                    OperationKey(op: .enter)
                    Key(char: "z", maxWidth: geo.size.width)
                    Key(char: "x", maxWidth: geo.size.width)
                    Key(char: "c", maxWidth: geo.size.width)
                    Key(char: "v", maxWidth: geo.size.width)
                    Key(char: "b", maxWidth: geo.size.width)
                    Key(char: "n", maxWidth: geo.size.width)
                    Key(char: "m", maxWidth: geo.size.width)
                    OperationKey(op: .delete)
                }
            }

        }
        .frame(maxHeight: 167)
        .padding(.horizontal, 8)
    }
}

struct Key: View {
    @EnvironmentObject var guessingModel: GuessingModel
    let char: Character
    let maxWidth: CGFloat
    
    func getKeyColor() -> Color {
        if let result = guessingModel.guessLog[char] {
            switch result {
            case .Correct:
                return Color.correct
            case .WrongPlacement:
                return Color.wrongPlacement
            case .NotGuessed:
                return Color.keyCap
            case .Absent:
                return Color.absent
            }
        }
        
        return Color.keyCap
    }

    func getKeyTextColor() -> Color {
        if let result = guessingModel.guessLog[char] {
            switch result {
            case .NotGuessed:
                return Color.keyText
            default:
                return Color.whiteText
            }
        }
        
        return Color.keyText
    }

    var body: some View {
        Button {
            guessingModel.addToGuess(char)
        } label: {
            // TODO: Explain these magic numbers
            KeyView(maxWidth: (maxWidth - (Constants.paddingBetweenKeys * 9)) / 10) {
                Text(String(char).uppercased())
                    .foregroundColor(getKeyTextColor())
            }
            .background(getKeyColor())
            .cornerRadius(5)
        }
    }
}

struct OperationKey: View {
    @EnvironmentObject var guessingModel: GuessingModel
    let op: KeyboardOperation
    
    func iconName() -> String {
        switch op {
        case .delete:
            return "delete.left"
        case .enter:
            return "arrow.up"
        }
    }
    
    var body: some View {
        Button {
            switch op {
            case .delete:
                guessingModel.removeFromGuess()
                break
            case .enter:
                guessingModel.guess()
                break
            }
        } label: {
            KeyView(maxWidth: .infinity) {
                Image(systemName: iconName())
            }
            .frame(height: 52)
            .foregroundColor(Color.keyText)
            .background(Color.keyCap)
            .cornerRadius(5)
        }
    }
}

struct KeyView<Content>: View where Content: View {
    let view: Content
    let maxWidth: CGFloat

    init(maxWidth: CGFloat, @ViewBuilder content: () -> Content) {
        self.view = content()
        self.maxWidth = maxWidth
    }

    var body: some View {
        view
            .padding(.vertical)
            .frame(maxWidth: maxWidth)
            .font(.system(size: 16, weight: .semibold, design: .default))
    }
}

enum KeyboardOperation {
    case delete
    case enter
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
            .environmentObject(GuessingModel())
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.dark)
    }
}
