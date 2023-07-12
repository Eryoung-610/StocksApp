//
//  StockViewModel.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

import Foundation
import Combine

enum StockViewState {
    case idle
    case loading
    case loaded
    case error
    
}

class StockViewModel: ObservableObject {
    @Published var processedStocks = [ProcessedStock]()
    @Published var state: StockViewState = .idle
    
    var service : StocksServiceProtocol
    var dataProcessor = StockDataProcessor()
    var cancellables = Set<AnyCancellable>()
    
    init(service : StocksServiceProtocol = StocksService()) {
        self.service = service
    }
    
    func fetchStocks() {
        
        state = .loading
        
        service.fetchStocks()
            .sink { completion in
                switch completion {
                case .finished:
                    self.state = .loaded
                    
                case .failure(let err):
                    self.state = .error
                    print(err.localizedDescription)
                }
            } receiveValue: { [weak self] stocks in
                guard let self = self else { return }
                
                // Process the stock data using StockDataProcessor
                let processedStocks = self.dataProcessor.processStockData(stocks)
                
                // Assign the processed stock data to the published property
                self.processedStocks = processedStocks
            }
            .store(in: &cancellables)
    }
}
