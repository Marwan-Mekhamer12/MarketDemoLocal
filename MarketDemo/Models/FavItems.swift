//
//  FavItems.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 06/11/2025.
//

import Foundation

struct FavoriteItems {
    let image : String
    let name: String
}

class Favorite {
    
    static let shared = Favorite()
    
    init() {}
    
    var fav: [FavoriteItems] = []
}
