//
//  GameNavView.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct GameNav: View {
    var body: some View {
        HStack(alignment: .center) {
            HelpButton()
            Spacer()
            LogoNotification()
            Spacer()
            SettingsButton()
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

struct GameNavView_Previews: PreviewProvider {
    static var previews: some View {
        GameNav()
            .environmentObject(GuessingModel())
    }
}
