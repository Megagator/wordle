//
//  EndGame.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/8/22.
//

import SwiftUI

struct NextWordle: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var guessingModel: GuessingModel

    @State var time = WordsModel.timeUntilNextWord()
//    @State var time = (0,0,15)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    var body: some View {
        if time.0 == 0 && time.1 == 0 && time.2 == 0 {
            Button {
                guessingModel.reset()
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("NEXT")
                    .padding()
                    .padding(.horizontal)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.whiteText)
                    .background(Color.correct)
                    .cornerRadius(100)
                    .shadow(radius: 100)
                    .padding()
            }
        } else {
            VStack {
                Text("NEXT WORDLE")
                    .font(.system(size: 22, weight: .black, design: .default))
                    .padding(.bottom, 8)
                Text("\(time.0):\(String(format: "%02d", time.1)):\(String(format: "%02d", time.2))")
                    .font(.system(size: 28, weight: .regular, design: .monospaced))
            }
            .onReceive(timer) { date in
                decrementTime()
            }
        }
    }
    
    func decrementTime() {
        time.2 -= 1
        
        if time.2 < 0 {
            time.2 = 59
            time.1 -= 1
        }
        if time.1 < 0 {
            time.1 = 59
            time.0 -= 1
        }
    }
}

struct NextWordle_Previews: PreviewProvider {
    static var previews: some View {
        NextWordle()
    }
}
