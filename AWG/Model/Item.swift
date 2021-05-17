//
//  Item.swift
//  AWG
//
//  Created by Влад Барченков on 14.05.2021.
//

import Foundation

struct Item: Decodable {
    var category: String
    var description: String
    var id: Int
    var image: String
    var price: Float
    var title: String
    
    enum CodinfKeys: String, CodingKey {
        case category, description, id, image, price, title
    }
    
}
