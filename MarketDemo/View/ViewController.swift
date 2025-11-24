//
//  ViewController.swift
//  MarketDemo
//
//  Created by Marwan Mekhamer on 31/10/2025.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ShopSmartImg: UIImageView!
    @IBOutlet weak var CategoryCollection: UICollectionView!  // for Categories
    @IBOutlet weak var HomeCollectionView: UICollectionView! // for Home CollectionView
    
    var viewmodel = ViewModel()
    
    private var selectIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startopen()
        viewmodel.LoadProducts()
        setupCombine()
        
    }
    
    func startopen(){
        ShopSmartImg.layer.cornerRadius = 28
        CategoryCollection.layer.cornerRadius = 28
        CategoryCollection.delegate = self
        CategoryCollection.dataSource = self
        HomeCollectionView.delegate = self
        HomeCollectionView.dataSource = self
    }
    
    func setupCombine() {
        viewmodel.$arrProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.CategoryCollection.reloadData()
                self?.HomeCollectionView.reloadData()
            }
            .store(in: &viewmodel.CancelLabel)
    }
    
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.arrProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let items = viewmodel.IndexProducts(at: indexPath.row)
        
        if collectionView == CategoryCollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! CategoriesCollectionViewCell
            cell.layer.cornerRadius = 28
            cell.setUp(items)
            let index = (indexPath.row == selectIndex)
            cell.Configure(category: items.category, isSelected: index)
            return cell
            
        } else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "homecollection", for: indexPath) as! HomeCollection
            cell2.setUp(Items: items)
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // This will be called when user taps a cell
        print("Selected category at index: \(indexPath.row)")
        
        selectIndex = indexPath.row
        collectionView.reloadData()
    }
}

