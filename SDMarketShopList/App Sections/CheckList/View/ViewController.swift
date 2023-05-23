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
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        myButton.backgroundColor = .black
        myButton.setTitleColor(.white, for: .normal)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 8
        myButton.setTitle("Remover Item", for: .normal)
        
        return myButton
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = MyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        bindButton()
        setupCollectionView()
        setupLayoutButton()
        setupLayoutTitle()
        bindTitleLabel()
        setupObservableItem()
        self.view.backgroundColor = .lightGray
        bindButtonAvailability()
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
            .subscribe(onNext: {[ weak self ] indexPath in
                self?.viewModel.updateSelectedIndexPath(indexPath)
                
                
            })
            .disposed(by: disposeBag)
        viewModel.fetchItems()
    }
    private func setupObservableItem () {
        viewModel.selectedIndexPath
            .subscribe(onNext: {[weak self] indexPath in
                self?.changeTitle()
            }).disposed(by: disposeBag)
    }
    
    private func itemSelected() {
        self.viewModel.removeItem()
        
    }
    
    private func changeTitle() {
        self.viewModel.setTitle()
    }
    
    func bindTitleLabel() {
        viewModel.title
            .asDriver(onErrorJustReturn: "")
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    private func registerCell() {
        collectionView.register(ProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: "MyCell")
        
    }
    
    
    private func bindCollectionView() {
        viewModel.items.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: "MyCell",
                                              cellType: ProductCollectionViewCell.self)) {
                (row, element, cell) in
                cell.configure(with: .init(name: element, image: element))
                cell.backgroundColor = .white
                cell.layer.cornerRadius = 20
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 2
                
                
            }.disposed(by: disposeBag)
    }
    
    private func bindButton() {
        button.rx.tap.asDriver()
            .throttle(.seconds(2))
            .drive(onNext: { [weak self] in
                self?.showConfirmationDialog(self?.titleLabel.text, completion: { confirmed in
                    if confirmed {
                        self?.viewModel.didTapButton()
                    }
                })
            }).disposed(by: disposeBag)
    }
    
    private func bindButtonAvailability() {
        viewModel.selectedIndexPath
            .map { [weak self] indexPath in
                guard let self = self else { return false }
                let lastRowIndex = self.viewModel.items.value.count - 1
                return indexPath.row == lastRowIndex
            }
            .bind(to: button.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

extension ViewController {
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupLayoutTitle() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
