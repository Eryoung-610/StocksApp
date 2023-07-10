//
//  StockResponse.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

import Foundation

struct Stock : Codable {
    let ticker : String
    let name : String
    let currency : String
    let currentPriceCents : Int
    let quantity : Int?
    let currentPriceTimeStamp : Int
    
    enum CodingKeys : String, CodingKey {
        case ticker, name, currency, quantity
        case currentPriceCents = "current_price_cents"
        case currentPriceTimeStamp = "current_price_timestamp"
    }
}

struct StockResponse : Codable {
    let stocks : [Stock]
}
