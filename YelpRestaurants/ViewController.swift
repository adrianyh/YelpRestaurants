//
//  ViewController.swift
//  YelpRestaurants
//
//  Created by Adrian Young-Hoon on 9/28/17.
//  Copyright © 2017 AdrianYH. All rights reserved.
//

import UIKit

class RestaurantsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellID = "cellID"
    
    var restaurantBusinesses: [Business]?
    var restaurantTypes: [RestaurantsType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        // Yelp Fusion API
//        RestaurantsType.fetchBusinesses()
//        restaurantTypes = RestaurantsType.fetchSimpleRestaurantType()
        
        
        // Sample Datasource
        restaurantTypes = RestaurantsType.sampleRestaurantsTypes()

        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = restaurantTypes?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        
        cell.restaurantTypes = restaurantTypes?[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 285)
    }
}

