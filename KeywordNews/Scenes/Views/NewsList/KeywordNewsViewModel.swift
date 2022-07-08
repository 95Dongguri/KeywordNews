//
//  NewsListViewModel.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/08.
//

import RxSwift
import RxCocoa

struct KeywordNewsViewModel {
    
    let disposeBag = DisposeBag()
    
    let searchBarViewModel = SearchBarViewModel()
    let newsListViewModel = NewsListViewModel()
    
    init(_ model: KeywordNewsModel = KeywordNewsModel()) {
        let newsResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchNews)
            .share()
        
        let newsValue = newsResult
            .map(model.getNewsValue)
            .filter { $0 != nil }
        
        let newsError = newsResult
            .map(model.getNewsError)
            .filter { $0 != nil }
        
        let cellData = newsValue
            .map(model.getNewsListCellData)
        
        cellData
            .bind(to: newsListViewModel.newslistCellData)
            .disposed(by: disposeBag)
    }
}
