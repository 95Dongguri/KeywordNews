//
//  NewsNetwork.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/04.
//

import RxSwift
import RxCocoa

class NewsNetwork {
    private let session: URLSession
    let api = NewsAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchNews(query: String) -> Single<Result<News, SearchError>> {
        guard let url = api.searchNews(query: query).url else { return .just(.failure(.invalidURL)) }
        
        // X-Naver-Client-Id:
        // X-Naver-Client-Secret: 
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("aCSCTRfEwDDwN5ykcZNk", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("CbXmy0WJYs", forHTTPHeaderField: "X-Naver-Client-Secret")
        
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
