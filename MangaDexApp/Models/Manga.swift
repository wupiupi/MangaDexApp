//
//  Manga.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import Foundation

// MARK: - Manga
struct MangaInfo {
    var id: String
    var type: String?
    var attributes: MangaAttributes
    var relationships: [Relationship]
    
    init(mangaData: [String: Any]) {
        id = mangaData["id"] as? String ?? ""
        type = mangaData["type"] as? String ?? ""
        
        let mangaAttributes = mangaData["attributes"] as? [String: Any] ?? [:]
        attributes = MangaAttributes(mangaAttributes: mangaAttributes)
        
        let mangaRelationships = mangaData["relationships"] as? [[String: Any]] ?? []
        relationships = mangaRelationships.map{ Relationship(mangaRelationships: $0) }
    }
    
    static func getMangas(with data: Any) -> [MangaInfo] {
        guard let mangaData = data as? [String: Any] else { return [] }
        guard let mangaInfos = mangaData["data"] as? [[String: Any]] else { return [] }
        
        return mangaInfos.map { MangaInfo(mangaData: $0) }
    }
        
    func getCoverID() -> String {
        relationships.filter { $0.type == "cover_art" }.first?.id ?? ""
    }
}

struct MangaAttributes {
    let title: Language
    let description: Language?
    let lastVolume: String?
    let lastChapter: String?
    let status: String?
    let year: Int?
    let contentRating: String?
    
    init(mangaAttributes: [String: Any]) {
        title = Language.getTitle(attributes: mangaAttributes)
        description = Language.getDescription(attributes: mangaAttributes)
        lastVolume = mangaAttributes["lastVolume"] as? String ?? ""
        lastChapter = mangaAttributes["lastChapter"] as? String ?? ""
        status = mangaAttributes["status"] as? String ?? ""
        year = mangaAttributes["year"] as? Int ?? 0
        contentRating = mangaAttributes["contentRating"] as? String ?? ""
    }
}

struct Language {
    let en: String?
    
    init(mangaLanguage: [String: Any]) {
        
        en = mangaLanguage["en"] as? String ?? ""
    }
    
    static func getTitle(attributes: [String: Any]) -> Language {
        let attributes = attributes["title"] as? [String: Any] ?? [:]
        return Language(mangaLanguage: attributes)
    }
    
    static func getDescription(attributes: [String: Any]) -> Language {
        let attributes = attributes["description"] as? [String: Any] ?? [:]
        return Language(mangaLanguage: attributes)
    }
}

struct Relationship {
    let id: String
    let type: String
    
    init(mangaRelationships: [String: Any]) {
        id = mangaRelationships["id"] as? String ?? ""
        type = mangaRelationships["type"] as? String ?? ""
    }
}

// MARK: - Cover
struct Cover {
    let fileName: String
    
    static func getFileName(value: Any) -> Cover {
        let dict = value as? [String: Any] ?? [:]
        let data = dict["data"] as? [String: Any] ?? [:]
        let attributes = data["attributes"] as? [String: Any] ?? [:]
        
        let fileName = attributes["fileName"] as? String

        return Cover(fileName: fileName ?? "")
    }
}
