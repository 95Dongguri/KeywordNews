//
//  NewsListViewModel.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/08.
//

import RxSwift
import RxCocoa

struct NewsListViewModel {
    
    let newslistCellData = PublishSubject<[NewsListCellData]>()
    let cellData: Driver<[NewsListCellData]>
    
    init() {
        self.cellData = newslistCellData
            .asDriver(onErrorJustReturn: [])
    }
}
