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

  init(manager: CoreDataManager, player: Player? = nil) {
    _viewModel = State(wrappedValue: PlayerDetailsViewModel(dataManager: manager, player: player))
  }
  
  var body: some View {
    ZStack {
      PrimaryBackgroundView()
      VStack(spacing: 4) {
        Text("Name")
          .foregroundColor(.bluesClues)
          .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Player Name", text: $viewModel.model.name)
          .textFieldStyle(.roundedBorder)
        Text("Rank \(viewModel.model.rank)")
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

struct PlayerDetailsView_Previews: PreviewProvider {

  static var previews: some View {
    return PlayerDetailsView(manager: CoreDataManager.empty,
                             player: Player.example(context: CoreDataManager.empty.container.viewContext))
  }
  
}
