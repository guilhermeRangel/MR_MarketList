//
//  MyCollectionViewCell.swift
//  SDMarketShopList
//
//  Created by Guilherme Rangel on 05/05/23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(label)
        setupLayout()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupLayout() {
        label.textAlignment = .center
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
    }

    func configureText(with value: String) {
        label.text = value
    }
}
