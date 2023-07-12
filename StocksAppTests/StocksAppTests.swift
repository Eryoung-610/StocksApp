//
//  StocksAppTests.swift
//  StocksAppTests
//
//  Created by Eric Young on 7/10/23.
//

import Combine
import XCTest
@testable import StocksApp


enum fileName : String {
    case Stocks_empty
    case Stocks_malformed
    case Stocks_success
}

final class StocksAppTests: XCTestCase {
    
    var cancellables : Set <AnyCancellable> = []
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables = []
    }
    
    func test_fetchStocks_shouldPass() {
        let mockService = mockStocksService(fileName: .Stocks_success)
        let viewModel = StockViewModel(service : mockService)
        
        let exp = XCTestExpectation(description: "Fetch Stocks Success")
        
        viewModel.fetchStocks()
        
        viewModel.$state
            .sink { state in
                switch state {
                case .idle, .loading :
                    print("State: idle/loading")
                    break
                case .loaded:
                    if let stock = viewModel.processedStocks.first {
                        
                        XCTAssertEqual(stock.currentPriceTimestamp, "Apr 18, 2023 at 12:23:52 PM")
                        XCTAssertEqual(stock.ticker, "GSPC")
                        XCTAssertEqual(stock.name, "S&P 500")
                        XCTAssertEqual(stock.currency, "USD")
                        exp.fulfill()
                    } else {
                        XCTFail("Failed to unwrap stock")
                    }
                    
                case .error:
                    XCTFail()
                }
                
                if case .loaded = state {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [exp], timeout : 5.0)
        XCTAssertFalse(viewModel.processedStocks.isEmpty)
    }
    
    func test_fetchStocks_shouldFail() {
        let mockService = mockStocksService(fileName: .Stocks_malformed)
        let viewModel = StockViewModel(service : mockService)
        
        let exp = XCTestExpectation(description: "Fetch Stocks Fail")
        
        viewModel.fetchStocks()
        
        viewModel.$state
            .sink { completion in
                XCTFail("Fetch Stocks should not fail")
            } receiveValue: { state in
                switch state {
                case .idle, .loading :
                    break
                case .loaded :
                    XCTFail()
                case .error:
                    XCTAssertEqual(state, .error)
                    XCTAssertEqual(viewModel.processedStocks.count,0)
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
    }
    
    
    //    Check for Decoding error
    func test_fetchStocks_decoding_shouldFail() {
        let mockService = mockStocksService(fileName: .Stocks_malformed)
        let viewModel = StockViewModel(service: mockService)
        
        let exp = XCTestExpectation(description: "Fetch Stocks fail - Decoding")
        
        var receivedError : Error?
        
        viewModel.fetchStocks()
        
        viewModel.$processedStocks
            .sink( receiveCompletion: { completion in
                switch completion {
                case .failure(let error) :
                    receivedError = error
                    XCTAssertEqual(error.localizedDescription,StockServiceError.decodingError.description)
                case .finished :
                    break
                }
            }, receiveValue: { _ in
                XCTAssertTrue(viewModel.processedStocks.isEmpty)
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.$state
            .sink { state in
                if case .error = state {
                    if let error = receivedError as? StockServiceError, case .decodingError = error {
                        exp.fulfill()
                    }
                }
            }
            .store(in: &cancellables)
        
        wait(for: [exp], timeout:1.0)
    }
    
    func test_fetchStocks_isEmpty_shouldFail() {
        let mockService = mockStocksService(fileName: .Stocks_empty)
        let viewModel = StockViewModel(service : mockService)
        
        let exp = XCTestExpectation(description: "Fetch Stocks success is empty")
        
        viewModel.fetchStocks()
        
        viewModel.$state
            .sink { completion in
                XCTFail("Fetch Stocks should not fail")
            } receiveValue: { state in
                switch state {
                case .idle, .loading:
                    break
                case .loaded:
                    XCTAssertEqual(viewModel.processedStocks.count, 0)
                    XCTAssertEqual(state, .loaded)
                    exp.fulfill()
                case .error:
                    XCTFail()
                }
            }
            .store(in:&cancellables)
        wait(for:[exp], timeout:1.0)
    }
    
}

class mockStocksService : StocksServiceProtocol {
    
    let fileName : fileName
    
    init(fileName : fileName) {
        self.fileName = fileName
    }
    
    private func loadMockData(_ file : String) -> URL? {
        return Bundle(for: type(of:self)).url(forResource: file, withExtension: "json")
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchStocks() -> Future<[Stock], StockServiceError> {
        return Future { [weak self] promise in
            guard let self = self else {return}
            
            guard let url = self.loadMockData(self.fileName.rawValue) else {
                promise(.failure(.invalidURL))
                return
            }
            
            let data = try! Data(contentsOf: url)
            
            do {
                let decodedStocks = try JSONDecoder().decode(StockResponse.self, from: data)
                let stocks = decodedStocks.stocks
                promise(.success(stocks))
            } catch {
                promise(.failure(.decodingError))
            }
            
        }
    }
}
