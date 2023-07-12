//
//  StocksAppTests.swift
//  StocksAppTests
//
//  Created by Eric Young on 7/10/23.
//

import Combine
import XCTest
@testable import StocksApp

// Goals - Test Fetch Call?
// Get res
// Cover Malformed, OOS, Empty, Decode Errors

enum fileName : String {
    case stocks_decoding
    case stocks_empty
    case stocks_malformed
    case stocks_success
    
}

final class StocksAppTests: XCTestCase {
    
    var cancellables : Set <AnyCancellable> = []
    
    var viewModel : StockViewModel!
    
    override func setUpWithError() throws {
        viewModel = StockViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables = []
    }
    
//    CHeck for malformed data. If we find it, we return malformed msg.
    func test_checkForMalformed_shouldPass() {
        
    }
    
    
    func test_checkForMalformed_shouldFail() {
        
    }
    
    func test_checkForOOS_shouldPass() {
        
    }
    
    func test_checkForOOS_shouldFail() {
        
    }
    
    func test_checkForEmpty_shouldPass() {
        
    }
    
    func test_checkForEmpty_shouldFail() {
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
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
}
