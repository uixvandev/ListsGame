//
//  APIService.swift
//  ListsGame
//
//  Created by irfan wahendra on 09/03/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private let apiKey = "c0eeab739243494d9067ec6a26287e10"
    
    private init() {}
    
    func fetchGameList() async throws -> GameResponse {
        var components = URLComponents(string: "https://api.rawg.io/api/games")
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            ]
        
        guard let url = components?.url else {
            print("😡 ERROR: Could not create URL")
            throw URLError(.badURL)
        }
        
        print("We Are Accessing \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        
        let game = try JSONDecoder().decode(GameResponse.self, from: data)
        return game
    }
}
