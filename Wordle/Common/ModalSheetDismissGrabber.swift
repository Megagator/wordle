//
//  ModalSheetDismissGrabber.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/10/22.
//

import SwiftUI

struct ModalSheetDismissGrabber: View {
    var body: some View {
        Rectangle()
            .frame(width: 44, height: 7)
            .foregroundColor(.tertiaryLabel)
            .cornerRadius(10)
            .padding(.top)
    }
}

struct ModalSheetDismissGrabber_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheetDismissGrabber()
    }
}
