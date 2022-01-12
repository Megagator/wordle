//
//  EndGame.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/8/22.
//

import SwiftUI

struct EndGame: View {
    let saveManager: SaveManager
    
    init(saveManager: SaveManager = .shared) {
        self.saveManager = saveManager
    }

    var body: some View {
        VStack {
            ModalSheetDismissGrabber()
            Spacer()
            StatisticsOverView(statsModel: StatsModel(save: saveManager.save))
                .layoutPriority(1)
            Divider()
                .padding()
                .padding()
            HStack(alignment: .top) {
                Spacer()
                NextWordle()
                Spacer()
                SummaryShare(result: saveManager.loadGame())
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame(saveManager: .mocked)
            .environmentObject(GuessingModel())
    }
}
