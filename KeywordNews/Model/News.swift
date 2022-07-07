//
//  News.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/04.
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
