//
//  StateNotification.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/6/22.
//

import SwiftUI

struct LogoNotification: View {
    @EnvironmentObject var guessingModel: GuessingModel
    @State var rotation = Angle(degrees: 0.0)
    let rotationOffset = Angle(degrees: 90.0)
    
    func makeStateStatus(state: GameState) -> String {
        switch state {
        case .Begin:
            return "Begin"
        case .NotEnoughLetters:
            return "Not enough letters"
        case .NotInDictionary:
            return "Not in word list"
        case .GoodGuess:
            return "Good guess..."
        case .Correct:
            return "Correct!"
        case .Failed:
            return "The word was \"\(WordsModel.todaysWord())\""
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Wordle")
                    .font(.system(size: 40, weight: .black, design: .default))
                    .foregroundColor(.label)
                    .background(Color.systemBackground)
                Text("#\(WordsModel.todaysNumber())")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundColor(.secondaryLabel)
            }
                .rotation3DEffect(rotation, axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 0, perspective: 0.5)
            Text(makeStateStatus(state: guessingModel.gameState))
                .padding()
                .background(Color.label)
                .font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(.secondarySystemBackground)
                .cornerRadius(8)
                .opacity(1)
                .rotation3DEffect(rotation - rotationOffset, axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 0, perspective: -0.5)
        }
        .onReceive(guessingModel.$gameState) { state in
            showState()
        }
        .onTapGesture {
            showState()
        }
    }
    
    @State var hideNotificationWorkItem: DispatchWorkItem?
    func showState() {
        if guessingModel.gameState == .Begin {
            return
        }

        withAnimation {
            rotation = rotationOffset
        }

        hideNotificationWorkItem?.cancel()
        if guessingModel.gameState != .Failed {
            hideNotificationWorkItem = DispatchWorkItem {
                hideState()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: hideNotificationWorkItem!)
        }
    }
    
    func hideState() {
        withAnimation {
            rotation = Angle(degrees: 0.0)
        }
    }
}

struct StateNotification_Previews: PreviewProvider {
    static var previews: some View {
        LogoNotification()
            .environmentObject(GuessingModel())
    }
}
