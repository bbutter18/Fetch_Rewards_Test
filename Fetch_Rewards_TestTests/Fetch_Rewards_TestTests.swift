//
//  Fetch_Rewards_TestTests.swift
//  Fetch_Rewards_TestTests
//
//  Created by Blastoise on 1/20/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import XCTest
@testable import Fetch_Rewards_Test

class Fetch_Rewards_TestTests: XCTestCase {
    
    let apiClient = APIClient()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchCategories() {
        let expectedResult = expectation(description: "Categories object")
        var categoryObject: Categories?
        var responseError: Error?
        let urlRequest = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        apiClient.fetchJSON(with: urlRequest) { (response: Result<Categories, Error>) in
            switch response {
            case .success(let response):
                categoryObject = response
                expectedResult.fulfill()
            case .failure(let error):
                responseError = error
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertNotNil(categoryObject)
        
    }

    func testFetchMeals() {
        let expectedResult = expectation(description: "Meals object")
        var categoryObject: Meals?
        var responseError: Error?
        let urlRequest = "https://www.themealdb.com/api/json/v1/1/filter.php?c=seafood"
        
        apiClient.fetchJSON(with: urlRequest) { (response: Result<Meals, Error>) in
            switch response {
            case .success(let response):
                categoryObject = response
                expectedResult.fulfill()
            case .failure(let error):
                responseError = error
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertNotNil(categoryObject)
        
    }
    
    func testFetchMealItems() {
        let expectedResult = expectation(description: "Meal Items object")
        var categoryObject: MealItems?
        var responseError: Error?
        let urlRequest = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=53050"
        
        apiClient.fetchJSON(with: urlRequest) { (response: Result<MealItems, Error>) in
            switch response {
            case .success(let response):
                categoryObject = response
                expectedResult.fulfill()
            case .failure(let error):
                responseError = error
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertNotNil(categoryObject)
        
    }
    
}
