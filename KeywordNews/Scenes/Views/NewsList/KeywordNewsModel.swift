//
//  NewsListModel.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/08.
//

import RxSwift

struct KeywordNewsModel {
    
    let network = NewsNetwork()
    
    func searchNews(_ query: String) -> Single<Result<News, SearchError>> {
        return network.searchNews(query: query)
    }
    
    func getNewsValue(_ result: Result<News, SearchError>) -> News? {
        guard case .success(let value) = result else { return nil }
        
        return value
    }
    
    func getNewsError(_ result: Result<News, SearchError>) -> String? {
        guard case .failure(let error) = result else { return nil }
        
        return error.message
    }
    
    func getNewsListCellData(_ value: News?) -> [NewsListCellData] {
        guard let value = value else { return [] }
        
        return value.items
            .map {
                return NewsListCellData(
                    title: $0.title,
                    link: $0.link,
                    description: $0.description,
                    pubDate: $0.pubDate
                )
            }
    }
    
}
