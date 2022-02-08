//
//  PlayerDetailsView.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import SwiftUI

struct PlayerDetailsView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @State private var viewModel: PlayerDetailsViewModel

  init(player: Player? = nil) {
    let manager = CoreDataManager.shared
    _viewModel = State(wrappedValue: PlayerDetailsViewModel(dataManager: manager, player: player))
  }
  
  var body: some View {
    ZStack {
      PrimaryBackgroundView()
      VStack(spacing: 4) {
        Text("Name")
          .foregroundColor(.bluesClues)
          .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Player Name", text: $viewModel.object.name)
          .textFieldStyle(.roundedBorder)
        Text("Rank \(viewModel.object.rank)")
          .padding()
          .padding(.bottom, 100)
        Button {
          save()
        } label: {
          Text("Save")
            .bold()
            .foregroundColor(.bluesClues)
        }
      }
      .padding()
    }
  }
  
  private func save() {
    viewModel.persist()
    presentationMode.wrappedValue.dismiss()
  }
  
}

extension PlayerDetailsView {
  
  /// Mock init for use with Previews
  /// - Parameter playerName: add
  fileprivate init(playerName: String) {
    let vm = PlayerDetailsViewModel.mockViewModel(params: playerName)
    _viewModel = State(wrappedValue: vm)
  }
  
}

struct PlayerDetailsView_Previews: PreviewProvider {

  static var previews: some View {
    return PlayerDetailsView(playerName: "WeebyWaifu")
  }
  
}
