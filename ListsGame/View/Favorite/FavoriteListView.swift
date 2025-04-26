//
//  FavoriteListView.swift
//  ListsGame
//
//  Created by irfan wahendra on 26/04/25.
//

import SwiftUI
import CoreData

struct FavoriteListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SavedGameEntity.name, ascending: true)],
        animation: .default
    )
    private var savedGames: FetchedResults<SavedGameEntity>

    var body: some View {
        NavigationStack {
            List {
                ForEach(savedGames) { game in
                    NavigationLink(destination: FavoriteGameDetailView(game: game)) {
                        HStack {
                            if let url = URL(string: game.backgroundImage ?? "") {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                }
                            }

                            VStack(alignment: .leading) {
                                Text(game.name ?? "Unknown Game")
                                    .font(.headline)
                                if let released = game.released {
                                    Text("Released: \(released)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteGames)
            }
            .navigationTitle("Favorites ❤️")
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func deleteGames(offsets: IndexSet) {
        withAnimation {
            offsets.map { savedGames[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete game: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    FavoriteListView()
}
