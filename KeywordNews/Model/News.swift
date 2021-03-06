//
//  News.swift
//  KeywordNews
//
//  Created by κΉλν on 2022/07/04.
//

import Foundation

struct News: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
