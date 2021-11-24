//
//  Bike_CitizenTests.swift
//  Bike CitizenTests
//
//  Created by Emad Bayramy on 11/17/21.
//

import XCTest
@testable import Bike_Citizen

final class ProductsServiceTests: XCTestCase {
    
    var sut: ProductService?
    var productsJson: Data?
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "plaz", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.productsJson = data
            } catch {
                
            }
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_searchForPlaz() {
        
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = productsJson
        let mockRequestManager = RequestManagerMock(session: urlSessionMock, validator: MockResponseValidator())
        sut = ProductService(requestManager: mockRequestManager)
        let expectation = XCTestExpectation(description: "Async products test")
        var listOfPlaces: RequestCallback<SearchArrayModel>?
        
        // When
        sut?.searchFor(place: "plaz", completionHandler: { result in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let places):
                listOfPlaces = places
            case .failure:
                XCTFail()
            }
        })
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(listOfPlaces?.data?.count == 15)
    }
}


