//
//  GameRow.swift
//  ListsGame
//
//  Created by irfan wahendra on 09/03/25.
//

import SwiftUI

struct GameRow: View {
    @StateObject private var viewModel = ListGameViewModel()
    let game: GameResult
    
    var body: some View {
        NavigationLink(destination: DetailGameView(game: game)) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: game.backgroundImage)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(game.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    if let released = game.released {
                        Text("Released: \(formatDate(released))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Rating: \(game.rating, specifier: "%.1f")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        
                        HStack(spacing: 2) {
                            ForEach(0..<Int(game.rating), id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.caption2)
                            }
                            if game.rating.truncatingRemainder(dividingBy: 1) >= 0.5 {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                                    .font(.caption2)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    private func metacriticColor(score: Int) -> Color {
        switch score {
        case 0..<50:
            return .red
        case 50..<75:
            return .yellow
        default:
            return .green
        }
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
    
    return GameRow(game: sampleGame)
        .padding()
}
