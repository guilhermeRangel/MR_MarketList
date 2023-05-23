//
//  MyViewModel.swift
//  SDMarketShopList
//
//  Created by Guilherme Rangel on 05/05/23.
//

import RxSwift
import RxCocoa

protocol DataViewModelProtocol {
    func didTapButton()
    func removeItem()
}

class MyViewModel: DataViewModelProtocol {
    let itemsArray: BehaviorRelay<[String]> = BehaviorRelay(value: [])
 
    
    let items: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let title: BehaviorRelay<String> = BehaviorRelay(value: "Lista de Compras")
    
    private let selectedIndexPathRelay = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
    
    var selectedIndexPath: Observable<IndexPath> {
        return selectedIndexPathRelay.asObservable()
    }
    
    
    func updateSelectedIndexPath(_ indexPath: IndexPath) {
        selectedIndexPathRelay.accept(indexPath)
    }
    init() {
        fetchItems()
    }
    func fetchItems() {
           let initialItems = ["maionese", "ketchup-tomate", "atum", "sardinha", "pepino",
                               "mostarda", "palmito", "maionese", "ketchup-tomate", "atum",
                               "sardinha", "pepino", "mostarda", "palmito", "empty-car"]
           itemsArray.accept(initialItems)
           items.accept(initialItems)
       }
    
    func didTapButton() {
        self.removeItem()
    }
    
    func removeItem() {
        var _items = self.items.value
        _items.remove(at: selectedIndexPathRelay.value.row)
        self.items.accept(_items)
        setFirstPositionRelay()
    }
    
    func setFirstPositionRelay() {
        updateSelectedIndexPath(IndexPath(row: 0, section: 0))
    }
    
    func setTitle() {
        self.title.accept(self.items.value[selectedIndexPathRelay.value.row].uppercased())
    }
    
}
