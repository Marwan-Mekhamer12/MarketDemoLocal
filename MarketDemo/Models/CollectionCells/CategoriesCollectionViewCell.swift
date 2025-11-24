//
//  CategoriesCollectionViewCell.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 31/10/2025.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var urlImg: UIImageView!
    @IBOutlet weak var CategoryLabel: UILabel!
    
    
    
    func setUp(_ items: Product) {
        CategoryLabel.text = items.category
        urlImg.image = nil
        urlImg.layer.cornerRadius = 18
        if let imagecache = ImageCache.shared.object(forKey: items.image as NSString) {
            self.urlImg.image = imagecache
            return
        }
        
        if let url = URL(string: items.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    print("❌ Error Load: \(error)")
                }
                
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.setObject(image, forKey: items.image as NSString)
                    DispatchQueue.main.async {
                        self?.urlImg.image = image
                    }
                }
            }
            .resume()
        }
    }
    
    func Configure(category: String, isSelected: Bool) {
        CategoryLabel.text = category
        
        if isSelected {
            contentView.backgroundColor = .systemYellow
            CategoryLabel.textColor = .white
        } else {
            contentView.backgroundColor = .systemGray5
            CategoryLabel.textColor = .systemGray
        }
    }
}
