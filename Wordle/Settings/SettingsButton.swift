//
//  SettingsButton.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct SettingsButton: View {
    @State var isOpen = false

    var body: some View {
        Button(action: {
            isOpen = true
        }, label: {
            Image(systemName: "gearshape")
                .foregroundColor(.absent)
                .font(.system(size: 20))
                .imageScale(.large)
                .padding(.vertical)
                .padding(.leading)
        })
        .sheet(isPresented: $isOpen) {
            Settings()
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
    }
}
