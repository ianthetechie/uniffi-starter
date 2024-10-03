@testable import Foobar
import XCTest

final class MyLibraryTests: XCTestCase {
    let calculator = SafeCalculator()

    func testAddition() throws {
        let res = try calculator.add(lhs: 2, rhs: 2)
        XCTAssertEqual(res.value, 4)

        let res2 = try calculator.chainAdd(rhs: 7)
        XCTAssertEqual(res2.value, 11)
    }

    func testMultiplication() throws {
        let res = try calculator.mul(lhs: 2, rhs: 4)
        XCTAssertEqual(res.value, 8)

        let res2 = try calculator.chainMul(rhs: 3)
        XCTAssertEqual(res2.value, 24)
    }
}
