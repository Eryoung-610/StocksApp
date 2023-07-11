//
//  StockViewModel.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

import Foundation
import Combine

class StockViewModel : ObservableObject {
    @Published var stocks = [Stock]()
    
    var service = StocksService()
    var cancellables = Set<AnyCancellable>()
    
    func fetchStocks() {
        service.fetchStocks()
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let err) :
                    print(err.localizedDescription)
                }
            } receiveValue : { stocks in
                self.stocks = stocks
            }
            .store(in: &cancellables)
    }
    
}
