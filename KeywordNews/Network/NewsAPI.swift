//
//  NewsAPI.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/08.
//

import Foundation

struct NewsAPI {
    // https://openapi.naver.com/v1/search/news.xml?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=date
    
    static let scheme = "https"
    static let host = "openapi.naver.com"
    static let path = "/v1/search/news.json"
    
    func searchNews(query: String) -> URLComponents {
        var components = URLComponents()
        
        components.scheme = NewsAPI.scheme
        components.host = NewsAPI.host
        components.path = NewsAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "100"),
            URLQueryItem(name: "start", value: "1"),
            URLQueryItem(name: "sort", value: "date")
        ]
        
        return components
    }
}
