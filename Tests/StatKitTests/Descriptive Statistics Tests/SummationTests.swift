#if !os(watchOS)

import XCTest
import StatKit

final class SummationTests: XCTestCase {
  func testPositiveSum() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedSum = sum(of: intArray, over: \.self)
    let expectedSum = 15
    
    XCTAssertEqual(calculatedSum, expectedSum)
  }
  
  func testNegativeSum() {
    let intArray = [1, -2, 3, -4, 5, -6]
    let calculatedSum = sum(of: intArray, over: \.self)
    let expectedSum = -3
    
    XCTAssertEqual(calculatedSum, expectedSum)
  }
}

#endif
