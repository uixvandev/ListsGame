//
//  GameListView.swift
//  ListsGame
//
//  Created by irfan wahendra on 09/03/25.
//

import SwiftUI

struct GameListView: View {
    @StateObject private var viewModel = ListGameViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading games...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text("Error: \(errorMessage)")
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Try Again") {
                            viewModel.fetchData()
                        }
                        .buttonStyle(.bordered)
                    }
                } else if viewModel.listGame.isEmpty {
                    VStack {
                        Image(systemName: "gamecontroller.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("No games available")
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(viewModel.listGame, id: \.id) { game in
                            GameRow(game: game)
                                .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.fetchData()
                    }
                }
            }
            .navigationTitle("Game")
            
        }
        .onAppear {
            if viewModel.listGame.isEmpty {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    GameListView()
}
