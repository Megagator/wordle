//
//  SwiftUIView.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct HelpButton: View {
    @State var isOpen = false

    var body: some View {
        Button(action: {
            isOpen = true
        }, label: {
            Image(systemName: "questionmark.circle")
                .foregroundColor(.absent)
                .font(.system(size: 20))
                .imageScale(.large)
                .padding(.vertical)
                .padding(.trailing)
        })
        .sheet(isPresented: $isOpen) {
            Tutorial()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton()
    }
}
