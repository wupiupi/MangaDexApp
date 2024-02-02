//
//  NetworkManager.swift
//  MangaDexApp
//
//  Created by Paul Makey on 2.02.24.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

enum Link {
    case mangaList
    case getManga
    
    var url: URL {
        switch self {
            case .mangaList: URL(string: "https://api.mangadex.org/manga")!
            case .getManga: URL(string: "https://api.mangadex.org/manga/f4fa3679-6918-4684-bcb6-377c9f336898")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let image = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            
            do {
                let networkData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(networkData))
                }
                
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    
    private init() {}
}
