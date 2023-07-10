//
//  StocksService.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

import Foundation
import Combine

class StocksService {
    var cancellable = Set<AnyCancellable>()
    let endpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    
    func fetchStocks() -> Future<[Stock], Error> {
        return Future { promise in
            guard let url = URL(string:self.endpoint) else {
                promise(.failure())
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url) { data, res, err in
                
                do {
                    let response = try JSONDecoder().decode(StockResponse.self, )
                }
            }
        }
    }
}
