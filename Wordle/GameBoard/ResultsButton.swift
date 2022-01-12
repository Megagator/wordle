//
//  NextButton.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct ResultsButton: View {
    @Binding var next: Bool

    var body: some View {
        Button {
            next = true
        } label: {
            Text("RESULTS")
                .padding()
                .padding(.horizontal)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(.whiteText)
                .background(Color.correct)
                .cornerRadius(100)
                .shadow(radius: 100)
                .padding()
        }
    }
}

struct ResultsButton_Previews: PreviewProvider {
    static var previews: some View {
        ResultsButton(next: .constant(true))
    }
}
