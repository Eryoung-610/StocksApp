//
//  StockResponse.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

import Foundation

struct Stock: Decodable {
    let ticker: String
    let name: String
    let currency: String
    let current_price_cents: Int
    let quantity: Int?
    let current_price_timestamp: Int
    
    enum CodingKeys: String, CodingKey {
        case ticker, name, currency, quantity
        case current_price_cents = "current_price_cents"
        case current_price_timestamp = "current_price_timestamp"
    }
}


struct StockResponse: Decodable {
    let stocks: [Stock]
}
