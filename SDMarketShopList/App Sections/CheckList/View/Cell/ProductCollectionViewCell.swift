//
//  ProductCollectionViewCell.swift
//  SDMarketShopList
//
//  Created by Guilherme Rangel on 05/05/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.tintColor = .yellow
//        label.backgroundColor = .black
        return label
    }()
    
    override var isSelected: Bool {
         didSet {
             if isSelected {
                 let selectedView = UIView()
                 selectedView.layer.cornerRadius = 20
                 selectedView.backgroundColor = UIColor(named: "Selected-green")
                 self.selectedBackgroundView = selectedView
             } else {
                 self.selectedBackgroundView = nil
             }
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        imageView.image = UIImage(named: product.image)
        
    }
}
