//
//  NewsWebViewController.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/06.
//

import UIKit
import SnapKit
import Toast
import WebKit

class NewsWebViewController: UIViewController {

    let cellData: NewsListCellData
    
    let webView = WKWebView()
    
    init(cellData: NewsListCellData) {
        self.cellData = cellData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        attribute()
        layout()
    }
    
    private func attribute() {
        title = cellData.title.htmlToString
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "link"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func layout() {
        guard let linkURL = URL(string: cellData.link) else {
            navigationController?.popViewController(animated: true)
            return
        }

        view = webView

        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
}

private extension NewsWebViewController {
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = cellData.link
    }
}
