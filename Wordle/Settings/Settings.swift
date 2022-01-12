//
//  Settings.swift
//  Wordle
//
//  Created by Mike Reinhard on 1/11/22.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var guessingModel: GuessingModel
    @State var isWarningBeforeDelete = false

    var body: some View {
        VStack {
            List {
                Section(header:
                    Text("Settings")
                        .foregroundColor(.secondaryLabel)
                        .font(.system(size: 24, weight: .black, design: .default))
                        .padding(.bottom)
                ) {
                    Toggle("Hard Mode (coming soon)", isOn: .constant(false))
                        .disabled(true)
                    Spacer()
                    Button(action: { isWarningBeforeDelete = true }) {
                        HStack {
                            Text("Delete Save")
                            Spacer()
                            Image(systemName: "trash")
                        }
                    }
                    .foregroundColor(.red)
                }
            }
            .listStyle(.insetGrouped)
        }
        .confirmationDialog("Delete ALL save data?", isPresented: $isWarningBeforeDelete, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    SaveManager.shared.deleteSave()
                    guessingModel.reset()
                    
                    isWarningBeforeDelete = false
                }
                Button("Cancel", role: .cancel) {
                    isWarningBeforeDelete = false
                }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(GuessingModel())
            .preferredColorScheme(.dark)
    }
}
