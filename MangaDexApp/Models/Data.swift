//
//  Book.swift
//  MangaDexApp
//
//  Created by Paul Makey on 29.01.24.
//

import Foundation

// На самом деле, обычно книгу по манге называют тайтлом, но я решил, что не
// стоит так называть модельку, ибо не уверен, что там можно. К тому же,
// манга является своего рода книгами (на подобие американских комиксов) :)

struct Book: Decodable {
    let data: [BookInfo]
}

struct BookInfo: Decodable {
    let type: String
//    let title: String // there is the place where the error occured
}
