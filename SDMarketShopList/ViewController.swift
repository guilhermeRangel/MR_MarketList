//
//  ViewController.swift
//  SDMarketShopList
//
//  Created by Guilherme Rangel on 05/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let items = Observable.just([1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        setupCollectionView()
    }
    
    
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        setuoLayoutCollectionView()
        registerCell()
        bindCollectionView()
        collectionView.backgroundColor = .blue
    }
    private func setuoLayoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
    }
    
    private func registerCell() {
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    }
    
    private func bindCollectionView() {
        items.bind(to: collectionView.rx.items(cellIdentifier: "MyCell", cellType: MyCollectionViewCell.self)) { row, element, cell in
            cell.configureText(with: "\(element)")
            cell.backgroundColor = .red
        }.disposed(by: disposeBag)
    }
}



