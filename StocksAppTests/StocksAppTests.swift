//
//  StocksAppTests.swift
//  StocksAppTests
//
//  Created by Eric Young on 7/10/23.
//

import Combine
import XCTest
@testable import StocksApp


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

}
