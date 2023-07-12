//
//  StocksService.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

import Foundation
import Combine


protocol StocksServiceProtocol {
    func fetchStocks() -> Future <[Stock], StockServiceError>
}

enum StockServiceError : Error {
    case invalidURL
    case emptyResponse
    case malformed
    case outOfService
    case decodingError
    
    var description : String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .emptyResponse:
            return "Empty Response"
        case .malformed:
            return "Malformed Data"
        case .outOfService:
            return "Out of Service"
        case .decodingError:
            return "Decoding Error"
        }
        
    }
}

class StocksService : StocksServiceProtocol {
    var cancellable = Set<AnyCancellable>()
    let endpoint = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    
    func fetchStocks() -> Future<[Stock], StockServiceError> {
        return Future { promise in
            guard let url = URL(string: self.endpoint) else {
                promise(.failure(.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
//                Check for OOS
                if let error = error {
                    print("API request error:", error)
                    promise(.failure(.outOfService))
                    return
                }
                
//                Check for empty Response
                guard let data = data else {
                    print("Empty response")
                    promise(.failure(.emptyResponse))
                    return
                }
                
//                Check for malformed
                guard let httpRes = response as? HTTPURLResponse, 200...299 ~= httpRes.statusCode else {
                    promise(.failure(.malformed))
                    return
                }
                
                // Print the raw data
//                if let rawData = String(data: data, encoding: .utf8) {
//                    print("Raw Data:", rawData)
//                }
                
                // Perform decoding and handle the fetched stocks here
                do {
                    let decodedStocks = try JSONDecoder().decode(StockResponse.self, from: data)
                    let stocks = decodedStocks.stocks
                    promise(.success(stocks))
//                    print("Decoded Stocks : \(stocks)")
                } catch {
                    print("Decoding error:", error)
                    promise(.failure(.decodingError))
                }
//                Resume required to start the fetchStocks, otherwise it is in suspended state until we call it.
            }.resume()
        }
    }
}
