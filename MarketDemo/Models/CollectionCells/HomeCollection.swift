//
//  HomeCollection.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 03/11/2025.
//

import UIKit

class HomeCollection: UICollectionViewCell {
    
    
    @IBOutlet weak var urlimage: UIImageView!
    @IBOutlet weak var favouriteImage: UIButton!
    
    private var isFav = false
    
    func setUp(Items: Product) {
        
        urlimage.image = nil
        isFav = false
        if let imagecache = ImageCache.shared.object(forKey: Items.image as NSString) {
            urlimage.image = imagecache
            return
        }
        
        if let url = URL(string: Items.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    print("❌ Error to load image: \(error)")
                }
                
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.setObject(image, forKey: Items.image as NSString)
                    DispatchQueue.main.async {
                        self?.urlimage.image = image
                    }
                }
            }
            .resume()
        }
            
    }
    
}
