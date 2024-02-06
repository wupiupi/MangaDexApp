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
    
    init(mangaInfo: [String: Any]) {
        id = mangaInfo["id"] as? String ?? ""
        type = mangaInfo["type"] as? String ?? ""
        attributes = MangaAttributes(
            mangaAttributes: mangaInfo["attributes"] as? [String: Any] ?? [:]
        )
        relationships = [Relationship](
            relationship: mangaInfo["relationships"] as? [String: Any] ?? [:]
        )
    }
    
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
    
    init(mangaAttributes: [String: Any]) {
        title = Language(language: mangaAttributes["en"] as? [String: Any] ?? [:])
        description = Language(language: mangaAttributes["en"] as? [String: Any] ?? [:])
        lastVolume = mangaAttributes["lastVolume"] as? String ?? ""
        lastChapter = mangaAttributes["lastChapter"] as? String ?? ""
        status = mangaAttributes["status"] as? String ?? ""
        year = mangaAttributes["year"] as? Int ?? 0
        contentRating = mangaAttributes["contentRating"] as? String ?? ""
    }
}

struct Language: Decodable {
    let en: String?
    
    init(language: [String: Any]) {
        en = language["en"] as? String ?? ""
    }
}

struct Relationship: Decodable {
    let id: String
    let type: String
    
    init(relationship: [String: Any]) {
        id = relationship["id"] as? String ?? ""
        type = relationship["type"] as? String ?? ""
    }
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
