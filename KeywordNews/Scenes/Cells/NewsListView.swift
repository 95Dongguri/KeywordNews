//
//  NewsListView.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/05.
//

import RxSwift
import RxCocoa

class NewsListView: UITableView {
    
    let disposeBag = DisposeBag()
    
    let cellData = PublishSubject<[NewsListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: "NewsListCell", for: index) as! NewsListCell
                
                cell.setData(data)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func attribute() {
        backgroundColor = .white
        register(NewsListCell.self, forCellReuseIdentifier: "NewsListCell")
        separatorStyle = .singleLine
        rowHeight = 100
    }
}
