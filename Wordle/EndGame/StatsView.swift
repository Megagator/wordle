//
//  StatsView.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/9/22.
//

import SwiftUI

struct StatsView: View {
    let stats: StatsModel

    var body: some View {
        VStack {
            Text("STATISTICS")
                .font(.system(size: 18, weight: .black, design: .default))
                .foregroundColor(.secondaryLabel)
                .padding(.bottom, 8)
            HStack(alignment: .top, spacing: 16) {
                StatView(label: "played", value: stats.gamesPlayed())
                StatView(label: "win %", value: stats.winPercentage())
                StatView(label: "current streak", value: stats.streaks().currentStreak)
                StatView(label: "max streak", value: stats.streaks().maxStreak)
            }
        }
    }
}

struct StatView: View {
    let label: String
    let value: Int
    
    var body: some View {
        VStack(alignment: .center) {
            Text(String(value))
                .font(.system(size: 32, weight: .black, design: .default))
            Text(label)
                .font(.system(size: 16, weight: .regular, design: .default))
                .frame(maxWidth: 60)
                .multilineTextAlignment(.center)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(stats: StatsModel(save: Mocks.gameSave))
    }
}
