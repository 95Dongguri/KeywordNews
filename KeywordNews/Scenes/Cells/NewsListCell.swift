//
//  NewsListCell.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/05.
//

import UIKit
import SnapKit

class NewsListCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        accessoryType = .disclosureIndicator
        
        titleLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
        
        descriptionLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        dateLabel.font = .systemFont(ofSize: 12.0, weight: .medium)
        dateLabel.textColor = .secondaryLabel
        
        [titleLabel, descriptionLabel, dateLabel].forEach {
            addSubview($0)
        }
        
        let inset: CGFloat = 16.0
        let verticalSpacing: CGFloat = 4.0
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(48.0)
            $0.top.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
            $0.bottom.equalToSuperview().inset(inset)
        }
    }
    
    func setData(_ data: NewsListCellData) {
        titleLabel.text = data.title.htmlToString
        descriptionLabel.text = data.description.htmlToString
        dateLabel.text = data.pubDate
    }
}

