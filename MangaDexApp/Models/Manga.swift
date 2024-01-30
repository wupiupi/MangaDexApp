//
//  Manga.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import Foundation

struct Manga: Decodable {
    let data: [MangaInfo]
}

struct MangaInfo: Decodable {
    let id: String
    let type: String
    let attributes: Attribute
}

struct Attribute: Decodable {
    let title: Language
    let description: Language? // прописал как опционал, 
                               // так как иногда в JSON оно имело значение {}
    let year: Int?
}

struct Language: Decodable {
    let en: String?
}
