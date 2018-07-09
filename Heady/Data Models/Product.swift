//
//  Product.swift
//  Heady
//
//  Created by Saurabh Gupta on 09/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation

struct Product : Codable {
    
    let categories: [Category]?
    let rankings: [Ranking]?
    
    enum Codingkeys: String, CodingKey {
        case categories
        case rankings
    }
    
    struct Category: Codable {
        let id : Int?
        let name: String?
        let products: [Product]?
        let childCategories: String?
        
        enum Codingkeys: String, CodingKey {
            case id
            case name
            case products
            case childCategories = "child_categories"
        }
        
        struct Product: Codable {
            let id: Int?
            let name: String?
            let dateAdded: String?
            let variants: [Variant]?
            let tax: Tax?
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case variants
                case tax
                case dateAdded = "date_added"
            }
            
            struct Variant: Codable {
                let id: Int?
                let color: String?
                let size: Int?
                let price: Int?
            }
            
            struct Tax: Codable {
                let name: String?
                let value: Float?
            }
        }
    }
    
    
    struct Ranking: Codable {
        let ranking: String?
        let products: [Product]?
        
        enum CodingKeys: String, CodingKey {
            case ranking
            case products
        }
        
        struct Product: Codable {
            let id: Int?
            let viewCount: Int?
            let orderCount: Int?
            let shares: Int?
            
            enum CodingKeys: String, CodingKey {
                case id
                case shares
                case viewCount = "view_count"
                case orderCount = "order_count"
            }
        }
    }
}


