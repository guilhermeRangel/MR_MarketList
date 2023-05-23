//
//  AlertViewController.swift
//  SDMarketShopList
//
//  Created by Guilherme Rangel on 22/05/23.
//

import Foundation
import UIKit

extension ViewController {
    func showConfirmationDialog(_ item: String? = "Confirmação", completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: item,
                                                message: "O item ja está no carrinho de compras?",
                                                preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Sim", style: .destructive) { _ in
            completion(true)
        }
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { _ in
            completion(false)
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
