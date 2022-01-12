//
//  StatisticsOverView.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/9/22.
//

import SwiftUI

struct StatisticsOverView: View {
    let statsModel: StatsModel

    var body: some View {
        VStack {
            StatsView(stats: statsModel)
                .padding(.bottom)
                .padding(.bottom)
            GuessDistributionView(guessStats: statsModel.guessDistrib(), totalWins: statsModel.gamesWon())
        }
    }
}

struct StatisticsOverView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsOverView(statsModel: Mocks.statsModel)
    }
}
