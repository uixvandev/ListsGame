//
//  DetailGame.swift
//  ListsGame
//
//  Created by irfan wahendra on 09/03/25.
//

import SwiftUI

struct DetailGameView: View {
    
    let game: GameResult
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url:URL(string: game.backgroundImage)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height:250)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .clipped()
                    case .failure:
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    @unknown default:
                        EmptyView()
                    }
                }
                
            }
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let sampleGame = GameResult(
        id: 1,
        slug: "gta-v",
        name: "GTA V",
        released: "2015-08-20",
        tba: false,
        backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
        rating: 4.47,
        ratingTop: 5,
        ratings: [
            Rating(id: 1, title: "Exceptional", count: 1000, percent: 70.5),
            Rating(id: 2, title: "Recommended", count: 500, percent: 20.1)
        ],
        ratingsCount: 3857,
        reviewsTextCount: 78,
        added: 5000,
        addedByStatus: AddedByStatus(
            yet: 0,
            owned: 100,
            beaten: 50,
            toplay: 10,
            dropped: 5,
            playing: 20
        ),
        metacritic: 91,
        playtime: 72,
        suggestionsCount: 420,
        updated: "2025-03-07T13:59:13Z",
        esrbRating: EsrbRating(id: 4, slug: "mature", name: "Mature"),
        platforms: []
    )
    
    return DetailGameView(game: sampleGame)
        .padding()
}
