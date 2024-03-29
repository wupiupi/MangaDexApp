//
//  Manga.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import Foundation

// MARK: - Manga
struct MangaList: Decodable {
    let data: [MangaInfo]
}

struct MangaInfo: Decodable {
    let id: String
    let type: String?
    let attributes: MangaAttributes
    let relationships: [Relationship]
    
    func getCoverID() -> String {
        relationships.filter { $0.type == "cover_art" }.first?.id ?? ""
    }
}

struct MangaAttributes: Decodable {
    let title: Language
    let description: Language?
    let lastVolume: String?
    let lastChapter: String?
    let status: String?
    let year: Int?
    let contentRating: String?
}

struct Language: Decodable {
    let en: String?
}

struct Relationship: Decodable {
    let id: String
    let type: String
}

// MARK: - Cover
struct Cover: Decodable {
    let data: CoverData
}

struct CoverData: Decodable {
    let attributes: CoverAttribute
}

struct CoverAttribute: Decodable {
    let fileName: String
}
