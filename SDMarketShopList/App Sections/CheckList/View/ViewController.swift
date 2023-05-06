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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 130)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let button: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Inverter", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        myButton.backgroundColor = .black
        myButton.setTitleColor(.white, for: .normal)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 8
        
        return myButton
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lista de Compras"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = MyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .gray
        
        addComponents()
        bindButton()
        setupCollectionView()
        setupLayoutButton()
        setupLayoutTitle()
    }
    
    private func addComponents() {
        view.addSubview(collectionView)
        view.addSubview(button)
        view.addSubview(titleLabel)
    }
    
    private func setupCollectionView() {
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        setupLayoutCollectionView()
        registerCell()
        bindCollectionView()
        
        collectionView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                self?.itemSelected(item: indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchItems()
    }
    
    private func itemSelected(item: IndexPath) {
        self.viewModel.removeItem(item.row)
    }
    
    private func setupLayoutButton() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupLayoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            collectionView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupLayoutTitle() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    private func registerCell() {
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    }
    
    private func bindCollectionView() {
        viewModel.items.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: "MyCell",
                                              cellType: ProductCollectionViewCell.self)) {
                (row, element, cell) in
                cell.configure(with: .init(name: element, image: element))
        }.disposed(by: disposeBag)
    }
    
    private func bindButton() {
        button.rx.tap.asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [weak self] in
                self?.viewModel.didTapButton()
            }).disposed(by: disposeBag)
    }
}
