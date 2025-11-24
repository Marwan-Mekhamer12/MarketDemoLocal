//
//  ManagerBrain.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 31/10/2025.
//

import Foundation

protocol ManagerBrainProtocol {
    
    func fetchData(_ completion: @escaping (Result<[Product], Error>) -> Void)
    
}
// The API is : https://fakestoreapi.com/products

final class ManagerBrain: ManagerBrainProtocol {
    
    func fetchData(_ completion: @escaping (Result<[Product], Error>) -> Void) {
        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
                print("✅ Loaded \(products.count) products")
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
}
