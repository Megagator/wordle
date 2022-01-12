//
//  GuessDistributionView.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/9/22.
//

import SwiftUI

struct GuessDistributionView: View {
    let guessStats: [Int:Int]
    let totalWins: Int

    var body: some View {
        VStack {
            Text("GUESS DISTRIBUTION")
                .font(.system(size: 18, weight: .black, design: .default))
                .foregroundColor(.secondaryLabel)
                .padding(.bottom, 8)
            VStack(spacing: 4) {
                ForEach(1...6, id: \.self ) {
                    DistribRow(label: $0, value: guessStats[$0]!, total: totalWins)
                }
            }
        }
    }
}

struct DistribRow: View {
    let label: Int
    let value: Int
    let total: Int
    let minimumRowWidth: CGFloat = 24
    
    func getWidth(_ containerWidth: CGFloat) -> CGFloat {
        // don't divide by zero
        if total == 0 {
            return minimumRowWidth
        }

        return max((containerWidth * CGFloat(Double(value) / Double(total))), minimumRowWidth)
    }

    var body: some View {
        HStack(alignment: .center) {
            Text(String(label))
                .font(.system(size: 14, weight: .regular, design: .monospaced))
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text(String(value))
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .foregroundColor(.whiteText)
                        .padding(.trailing, 7)
                }
                .frame(width: getWidth(geo.size.width), height: 24, alignment: .trailing)
                    .background(Color.absent)
            }
            .frame(width: 300, height: 24)
        }
//        .border(.black, width: 2)
    }
}

struct GuessDistributionView_Previews: PreviewProvider {
    static var previews: some View {
        GuessDistributionView(guessStats: Mocks.statsModel.guessDistrib(), totalWins: Mocks.statsModel.gamesWon())
    }
}
