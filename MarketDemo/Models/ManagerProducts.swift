//
//  ManagerProducts.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 31/10/2025.
//

import Foundation


struct Product: Codable {
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
