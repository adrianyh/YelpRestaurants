//
//  RestaurantsModels.swift
//  YelpRestaurants
//
//  Created by Adrian Young-Hoon on 9/29/17.
//  Copyright © 2017 AdrianYH. All rights reserved.
//

import UIKit

class RestaurantsType: NSObject {
    var name: String?
    var businesses: [Business]?
    
    static func fetchSimpleRestaurantType() -> [RestaurantsType] {
        let restaurantType = RestaurantsType()
        restaurantType.name = "Restaurants ABC"
        //var restaurantBusinesses = [Business]()
        /*
        if let data = UserDefaults.standard.object(forKey: "business") as? NSData {
            let unarc = NSKeyedUnarchiver(forReadingWith: data as Data)
            unarc.setClass(Business.self, forClassName: "Business")
            let restaurantBusinesses = unarc.decodeObject(forKey: "business")
            restaurantType.businesses = restaurantBusinesses as? [Business]
        }
        */
        if let data = UserDefaults.standard.object(forKey: "business") as? NSData {
            let restaurantBusinesses = NSKeyedUnarchiver.unarchiveObject(with: data as Data)
            restaurantType.businesses = restaurantBusinesses as? [Business]
        }
        
        let favouritesType = RestaurantsType()
        favouritesType.name = "My Favourite Restaurants"
        var favouriteBusinesses = [Business]()
        let timmysBiz = Business()
        timmysBiz.name = "Tim Horton's"
        timmysBiz.image_url = NSURL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/uPnh71wAQ8RM09KVO5ttLg/o.jpg")
        //        timmysBiz.address1 = "900 Dufferin Street"
        //        timmysBiz.city = "Toronto"
        //        timmysBiz.state = "ON"
        //        timmysBiz.zipCode = "M6H 4B1"
        favouriteBusinesses.append(timmysBiz)
        
        favouritesType.businesses = favouriteBusinesses

        return [restaurantType, favouritesType]
    }
    
    static func fetchRestaurantType() -> [RestaurantsType] {
        let restaurantType = RestaurantsType()
        restaurantType.name = "Restaurants"
        var restaurantBusinesses = [Business]()
        
        
/*
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=restaurants&location=toronto&limit=10")
        let accessToken = "QausTD7J8RQK76WUuazxZ6oAqWbFOnPR7y-0WbiJlpt575mJ_vyv-Xp76XxzcmGNYxo8OI735gbvlemqEopAwXANKk5254Fu9SXBFKfUndS-HOJ3GiF5SfxCqVzOWXYx"
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
//        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data else { return }
//            let dataString = String(data: data, encoding: .utf8)
            do {
                let json = try(JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
                for dict in json["businesses"] as! [[String: Any]] {
                    let restaurantBiz = Business()
                    restaurantBiz.id = dict["id"] as? String ?? ""
                    restaurantBiz.name = dict["name"] as? String ?? ""
                    restaurantBiz.image_url = dict["image_url"] as? NSURL
                    restaurantBusinesses.append(restaurantBiz)
                }
                print(restaurantBusinesses[0].id)
                restaurantType.businesses = restaurantBusinesses
                print(restaurantType.businesses?.count)
            }
            catch let err {
                print(err)
            }
        })
        task.resume()
*/
        let favouritesType = RestaurantsType()
        favouritesType.name = "My Favourite Restaurants"
        
        var favouriteBusinesses = [Business]()
        
        let timmysBiz = Business()
        timmysBiz.name = "Tim Horton's"
        timmysBiz.image_url = NSURL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/uPnh71wAQ8RM09KVO5ttLg/o.jpg")
        //        timmysBiz.address1 = "900 Dufferin Street"
        //        timmysBiz.city = "Toronto"
        //        timmysBiz.state = "ON"
        //        timmysBiz.zipCode = "M6H 4B1"
        favouriteBusinesses.append(timmysBiz)
        
        favouritesType.businesses = favouriteBusinesses

        return [restaurantType, favouritesType]

    }
    
    static func fetchBusinesses() {
        var restaurantBusinesses = [Business]()
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=restaurants&location=toronto&limit=10")
        let accessToken = "QausTD7J8RQK76WUuazxZ6oAqWbFOnPR7y-0WbiJlpt575mJ_vyv-Xp76XxzcmGNYxo8OI735gbvlemqEopAwXANKk5254Fu9SXBFKfUndS-HOJ3GiF5SfxCqVzOWXYx"
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data else { return }
            //            let dataString = String(data: data, encoding: .utf8)
            do {
                let json = try(JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
                
                for dict in json["businesses"] as! [[String: Any]] {
                    let restaurantBiz = Business()
                    restaurantBiz.id = dict["id"] as? String ?? ""
                    restaurantBiz.name = dict["name"] as? String ?? ""
                    restaurantBiz.image_url = dict["image_url"] as? NSURL
                    restaurantBusinesses.append(restaurantBiz)
                }
                //UserDefaults.standard.set(restaurantBusinesses, forKey: "AllBiz")
                UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: Business()), forKey: "business")

//                print(restaurantBusinesses[0].id)
//                restaurantType.businesses = restaurantBusinesses
//                print(restaurantType.businesses?.count)
                
            }
            catch let err {
                print(err)
            }
        }
        task.resume()
        
    }
    
    static func fetchRestaurantBiz(_ completionHandler: @escaping ([Business]) -> ()) {
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=restaurants&location=toronto&limit=10")
        let accessToken = "QausTD7J8RQK76WUuazxZ6oAqWbFOnPR7y-0WbiJlpt575mJ_vyv-Xp76XxzcmGNYxo8OI735gbvlemqEopAwXANKk5254Fu9SXBFKfUndS-HOJ3GiF5SfxCqVzOWXYx"
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                //let json = try(JSONSerialization.data(withJSONObject: data!, options: []))
                
                let json = try(JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
                //let biz = json["businesses"] as! [[String: Any]]
                
//                print(json["businesses"])
                
                var restaurantBusinesses = [Business]()
                for dict in json["businesses"] as! [[String: Any]] {
                    let restaurantBiz = Business()
                    restaurantBiz.id = dict["id"] as? String ?? ""
                    restaurantBiz.name = dict["name"] as? String ?? ""
                    restaurantBiz.image_url = dict["image_url"] as? NSURL
                    restaurantBusinesses.append(restaurantBiz)
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(restaurantBusinesses)
                })
                
 
            }
            catch let err {
                print(err)
            }
        })
        task.resume()
        
    }
    
    static func sampleRestaurantsTypes() -> [RestaurantsType] {
        let restaurantType = RestaurantsType()
        restaurantType.name = "Restaurants"
        
        var businesses = [Business]()
        
        //Bicerin Espresso Bar And High Tea
        let bicerinBiz = Business()
        bicerinBiz.name = "Bicerin Espresso Bar And High Tea"
        bicerinBiz.image_url = NSURL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/bgr6RYe99SGMXnCiREDJtw/o.jpg")
        bicerinBiz.address1 = "37 Baldwin Street"
        bicerinBiz.city = "Toronto"
        bicerinBiz.state = "ON"
        bicerinBiz.zipCode = "M5T 1L1"
        businesses.append(bicerinBiz)
        //
        let labBiz = Business()
        labBiz.name = "The Coffee Lab"
        labBiz.image_url = NSURL(string: "https://s3-media2.fl.yelpcdn.com/bphoto/v8gADkduvzO0CzBRpbd1Vw/o.jpg")
        labBiz.address1 = "333 Bloor Street W"
        labBiz.city = "Toronto"
        labBiz.state = "ON"
        labBiz.zipCode = "M5S 1W7"
        businesses.append(labBiz)
        //
        let fahrenheitBiz = Business()
        fahrenheitBiz.name = "The Coffee Lab"
        fahrenheitBiz.image_url = NSURL(string: "https://s3-media2.fl.yelpcdn.com/bphoto/Yetdfr-UpaKYIJT80DjOLQ/o.jpg")
        fahrenheitBiz.address1 = "120 Lombard Avenue"
        fahrenheitBiz.city = "Toronto"
        fahrenheitBiz.state = "ON"
        fahrenheitBiz.zipCode = "M5A 4J6"
        businesses.append(fahrenheitBiz)
        
        restaurantType.businesses = businesses
        
        
        let favouritesType = RestaurantsType()
        favouritesType.name = "My Favourite Restaurants"
        
        var favouriteBusinesses = [Business]()
        
        let timmysBiz = Business()
        timmysBiz.name = "Tim Horton's"
        timmysBiz.image_url = NSURL(string: "https://s3-media4.fl.yelpcdn.com/bphoto/uPnh71wAQ8RM09KVO5ttLg/o.jpg")
        timmysBiz.address1 = "900 Dufferin Street"
        timmysBiz.city = "Toronto"
        timmysBiz.state = "ON"
        timmysBiz.zipCode = "M6H 4B1"
        favouriteBusinesses.append(timmysBiz)
        
        favouritesType.businesses = favouriteBusinesses
        
        return [restaurantType, favouritesType]
    }
}

class Business: NSObject {
    var id: String?
    var image_url: NSURL?
    var name: String?
    
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var state: String?
    var country: String?
    var zipCode: String?
    var phone: String?
    var rating: NSNumber?
    var price: String?
    var reviewCount: NSNumber?
    var categoryTitle: String?
    
    /*
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        image_url = aDecoder.decodeObject(forKey: "image_url") as? NSURL
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image_url, forKey: "image_url")
    }*/
}
