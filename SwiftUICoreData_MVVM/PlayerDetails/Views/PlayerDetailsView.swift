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
  @State private var showingGameList = false

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
          .padding(.bottom, viewModel.object.gameList.isEmpty ? 60 : 20)
        if !viewModel.object.gameList.isEmpty {
          ZStack {
            ScrollView {
              ForEach(viewModel.object.gameList) { game in
                Text(game.title)
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 4)
              }
            }
          }
          .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 8))
          .compositingGroup()
          .shadow(color: .bluesClues.opacity(0.4), radius: 3, x: 3, y: 3)
          .padding()
        } else {
          VStack {
            Text("No Games for User")
              .padding(.bottom, 40)
          }
        }
        Spacer()
        Button {
          showingGameList = true
        } label: {
          Text(viewModel.object.gameList.isEmpty ? "Add Games" : "Edit Games")
            .bold()
            .foregroundColor(.textPrimary)
            .padding()
        }
        .buttonStyle(.shadedPill)
        .padding()
        HStack(spacing: 40) {
          Button {
            dismiss()
          } label: {
            Text("Cancel")
              .bold()
              .foregroundColor(.bluesClues)
          }
          Button {
            save(games: viewModel.object.gameList)
          } label: {
            Text("Save")
              .bold()
              .foregroundColor(.bluesClues)
          }
        }
      }
      .padding()
    }
    .sheet(isPresented: $showingGameList) {
      GameListSelectionView(for: viewModel.object, in: viewModel.context)
    }
  }
  
  private func save(games: [Game]) {
    viewModel.save(with: games)
    dismiss()
  }
  
  private func dismiss() {
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
