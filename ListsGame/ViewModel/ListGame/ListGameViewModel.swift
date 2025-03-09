//
//  ListGameViewModel.swift
//  ListsGame
//
//  Created by irfan wahendra on 09/03/25.
//

import Foundation

@MainActor
class ListGameViewModel: ObservableObject {
    @Published var listGame: [GameResult] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchData() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await APIService.shared.fetchGameList()
                self.listGame = response.results
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                print("Error fetching games: \(error)")
            }
        }
    }
}
