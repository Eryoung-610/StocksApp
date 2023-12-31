//
//  StockDataProcessor.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import Foundation

struct ProcessedStock : Identifiable {
    var id = UUID()
    let ticker: String
    let name: String
    let currency: String
    let currentPrice: Double
    let quantity: Int?
    let currentPriceTimestamp: String
    
    static let mock = ProcessedStock(
        ticker: "AAPL",
        name: "Apple Inc.",
        currency: "USD",
        currentPrice: 142.25,
        quantity: 10,
        currentPriceTimestamp: "2023-07-12 10:30:00"
    )
    
    var formattedCurrentPrice: String {
        return currentPrice.formatPriceToString()
    }
    
    var formattedTotalPrice: String {
        let totalPrice = currentPrice * Double(quantity ?? 0)
        return totalPrice.formatPriceToString()
    }

}

class StockDataProcessor {
    //    Formatting the date coming in from currentPriceTimestamp
    private let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    //    Clean up data including, removing special characters, converting current_price_cents to dollars, and timestamp
    func processStockData(_ stocks: [Stock]) -> [ProcessedStock] {
        
        let processedStocks = stocks.map { stock in
            
            // Clean up ticker by removing special characters
            let cleanedTicker = cleanTicker(stock.ticker)
            
            // Convert current_price_cents to dollars
            let currentPrice = Double(stock.current_price_cents) / 100.0
            
            // Convert current_price_timestamp to local date string
            let currentPriceTimestamp = convertUNIXTimestampToLocalDateString(stock.current_price_timestamp)
            
            
            return ProcessedStock(
                ticker: cleanedTicker,
                name: stock.name,
                currency: stock.currency,
                currentPrice: currentPrice,
                quantity: stock.quantity,
                currentPriceTimestamp: currentPriceTimestamp
            )
        }
        
        
        return processedStocks
    }
    
    //    Clean up ticker here
    private func cleanTicker(_ ticker: String) -> String {
        
        // Remove special characters from ticker
        let allowedCharacterSet = CharacterSet.alphanumerics
        let cleanedTicker = ticker.components(separatedBy: allowedCharacterSet.inverted).joined()
        
        return cleanedTicker
    }
    
    //    Convert to LocalDateString here
    private func convertUNIXTimestampToLocalDateString(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
}

extension Double {
    func formatPriceToString() -> String {
        let formatString = String(format: "$%.2f", self)
        let regex = try! NSRegularExpression(pattern: "(\\d)(?=(\\d{3})+(?!\\d))", options: [])
        let range = NSMakeRange(0, formatString.count)
        let commaSeparatedString = regex.stringByReplacingMatches(in: formatString, options: [], range: range, withTemplate: "$1,")
        return commaSeparatedString.replacingOccurrences(of: "\\.?0+$", with: "", options: .regularExpression)
    }
    
}
