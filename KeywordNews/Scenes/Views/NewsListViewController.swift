//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/04.
//

import RxCocoa
import RxSwift
import SnapKit


class NewsListViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let listView = NewsListView()
    let searchBar = SearchBar()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        let newsResult = searchBar.shouldLoadResult
            .flatMapLatest {
                NewsNetwork().searchNews(query: $0)
            }
            .share()
        
        let newsValue = newsResult
            .map { data -> News? in
                guard case .success(let value) = data else { return nil }
                
                return value
            }
            .filter { $0 != nil }
        
        let newsError = newsResult
            .map { data -> String? in
                guard case .failure(let error) = data else { return nil }
                
                return error.message
            }
            .filter { $0 != nil }
        
        let cellData = newsValue
            .map { news -> [NewsListCellData] in
                guard let news = news else { return [] }
                
                return news.items
                    .map {
                        return NewsListCellData(
                            title: $0.title,
                            link: $0.link,
                            description: $0.description,
                            pubDate: $0.pubDate
                        )
                    }
            }
            .bind(to: listView.cellData)
            .disposed(by: disposeBag)
        
        listView.rx.modelSelected(NewsListCellData.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                let vc = NewsWebViewController(cellData: data)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "Keyworkd News"
        view.backgroundColor = .white
    }
    
    private func layout() {
        [searchBar, listView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
