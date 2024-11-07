//
//  EarthquakeViewModelTests.swift
//  earthquakeTests
//
//  Created by Zhou on 2024/11/7.
//

import XCTest
@testable import earthquake

class EarthquakeViewModelTests: XCTestCase {
    func testFetchEarthquakes() {
        let viewModel = EarthquakeViewModel()
        let expectation = self.expectation(description: "Fetch earthquakes")
        
        viewModel.fetchEarthquakes {
            XCTAssertTrue(viewModel.numberOfEarthquakes() > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

