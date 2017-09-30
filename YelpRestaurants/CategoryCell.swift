//
//  CategoryCell.swift
//  YelpRestaurants
//
//  Created by Adrian Young-Hoon on 9/28/17.
//  Copyright © 2017 AdrianYH. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "restCellID"
    
    var restaurantTypes: RestaurantsType? {
        didSet {
            if let name = restaurantTypes?.name {
                typeLabel.text = name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let typeLabel: UILabel = {
        let typeL = UILabel()
        typeL.text = "Restaurants"
        typeL.font = UIFont.systemFont(ofSize: 18)
        typeL.translatesAutoresizingMaskIntoConstraints = false
        return typeL
    }()
    
    let restaurantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let separatorView: UIView = {
        let separatorV = UIView()
        separatorV.backgroundColor = UIColor.black
        separatorV.translatesAutoresizingMaskIntoConstraints = false
        return separatorV
    }()
    
    func setUpViews() {
        backgroundColor = UIColor.clear
        
        addSubview(typeLabel)
        addSubview(restaurantsCollectionView)
        addSubview(separatorView)
        
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        
        restaurantsCollectionView.register(restaurantCell.self, forCellWithReuseIdentifier: cellID)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": typeLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": restaurantsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[typeLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": restaurantsCollectionView, "v1": separatorView, "typeLabel": typeLabel]))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = restaurantTypes?.businesses?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! restaurantCell
        cell.business = restaurantTypes?.businesses?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class restaurantCell: UICollectionViewCell {
    
    var business: Business? {
        didSet {
            if let name = business?.name {
                nameLabel.text = name
            }
            
            if let address = business?.address1 {
                addressLabel.text = address
                if let city = business?.city {
                    addressLabel.text = addressLabel.text! + ",\n" + city
                    if let state = business?.state {
                        addressLabel.text = addressLabel.text! + " " + state
                        if let zipcode = business?.zipCode {
                            addressLabel.text = addressLabel.text! + "\n" + zipcode
                        }
                    }
                }
            }
            if let imageUrl = business?.image_url {
                if let iData = NSData(contentsOf: imageUrl as URL) {
                    imageView.image = UIImage(data: iData as Data)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "o")
        imageV.contentMode = .scaleAspectFill
        imageV.layer.cornerRadius = 16
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    let nameLabel: UILabel = {
        let nameL = UILabel()
        nameL.text = "Bicerin Espresso Bar And High Tea"
        nameL.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameL.numberOfLines = 2
        return nameL
    }()
    
    let addressLabel: UILabel = {
        let addressL = UILabel()
        addressL.text = "37 Baldwin Street, \nToronto, ON \nM5T 1L1"
        addressL.font = UIFont.systemFont(ofSize: 12)
        addressL.numberOfLines = 3
        return addressL
    }()
    
    func setUpViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(addressLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        addressLabel.frame = CGRect(x: 0, y: frame.width + 42, width: frame.width, height: 60)
    }
}
