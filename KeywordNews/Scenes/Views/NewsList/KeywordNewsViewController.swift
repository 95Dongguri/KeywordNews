//
//  KeywordNewsViewController.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/04.
//

import RxCocoa
import RxSwift
import SnapKit

class KeywordNewsViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let listView = NewsListView()
    let searchBar = SearchBar()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: KeywordNewsViewModel) {
        listView.bind(viewModel.newsListViewModel)
        searchBar.bind(viewModel.searchBarViewModel)
        
        listView.rx.modelSelected(NewsListCellData.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: showNewsWeb)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "Keyword News"
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

private extension KeywordNewsViewController {
    func showNewsWeb(_ data: NewsListCellData) {
        let vc = NewsWebViewController(cellData: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
