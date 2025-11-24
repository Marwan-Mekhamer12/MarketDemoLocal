//
//  ViewModel.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 31/10/2025.
//

import Foundation
import Combine

protocol ViewModelProtocol {
    func LoadProducts()
    func IndexProducts(at index: Int) -> Product
}

final class ViewModel: ViewModelProtocol {
    
    @Published var arrProducts = [Product]()
    @Published var isLoad: Bool = false
    @Published var error: String?
    var CancelLabel = Set<AnyCancellable>()
    
    private let manager: ManagerBrainProtocol
    
    init(manager: ManagerBrainProtocol = ManagerBrain()) {
        self.manager = manager
    }
    
    func IndexProducts(at index: Int) -> Product {
        return arrProducts[index]
    }
    
    func LoadProducts() {
        isLoad = true
        manager.fetchData { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoad = false
                switch result {
                case .success(let products):
                    self?.arrProducts = products
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
