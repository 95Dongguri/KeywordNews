//
//  SearchBarViewModel.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/08.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    
    let queryText = PublishRelay<String?>()
    let searchButtonTapped = PublishRelay<Void>()
    let shouldLoadResult: Observable<String>
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
