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
    func removeItem(_ item: Int)
}

class MyViewModel: DataViewModelProtocol {
    
    let items: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    func fetchItems() {
        let itemsArray = ["maionese", "ketchup-tomate","atum", "sardinha","pepino","mostarda","palmito","maionese", "ketchup-tomate","atum", "sardinha","pepino","mostarda","palmito"]
        items.accept(itemsArray)
    }
    
    func didTapButton() {
        self.items.accept(items.value.reversed())
    }
    
    func removeItem(_ item: Int) {
        var _items = self.items.value
        _items.remove(at: item)
        self.items.accept(_items)
    }
}
