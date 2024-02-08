//
//  NetworkManager.swift
//  MangaDexApp
//
//  Created by Paul Makey on 2.02.24.
//

import Foundation
import Alamofire

// MARK: - Enumerations
enum Link {
    case mangaList
    case getManga
    
    var url: URL {
        switch self {
            case .mangaList: URL(string: "https://api.mangadex.org/manga?limit=50")!
            case .getManga: URL(string: "https://api.mangadex.org/manga/f4fa3679-6918-4684-bcb6-377c9f336898")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    // MARK: - Initializers
    private init() {}
    
    func fetchData(from url: URL, completion: @escaping(Result<[MangaInfo], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { responseData in
                switch responseData.result {
                    case .success(let value):
                        let mangaInfo = MangaInfo.getMangas(with: value)
                        completion(.success(mangaInfo))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func fetchCoverID(from url: String, completion: @escaping(Result<String, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { responseData in
                switch responseData.result {
                    case .success(let cover):
                        let cover = Cover.getFileName(value: cover)
                        completion(.success(cover.fileName))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
}
