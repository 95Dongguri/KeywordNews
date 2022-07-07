//
//  NewsNetwork.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/04.
//

import RxSwift
import RxCocoa

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

class NewsNetwork {
    private let session: URLSession
    let api = NewsAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchNews(query: String) -> Single<Result<News, SearchError>> {
        guard let url = api.searchNews(query: query).url else { return .just(.failure(.invalidURL)) }
        
        // X-Naver-Client-Id: aCSCTRfEwDDwN5ykcZNk
        // X-Naver-Client-Secret: ftkIq6hsKf
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("aCSCTRfEwDDwN5ykcZNk", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("ftkIq6hsKf", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let newsData = try JSONDecoder().decode(News.self, from: data)
                    return .success(newsData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                return .just(.failure(.networkError))
            }
            .asSingle()
    }
}
