import XCTest
@testable import Micrograd

final class ValueTests: XCTestCase {
    
    func testValue_create() throws {
        let value = ValueTests.makeValue1()
        
        XCTAssert(value.data == Constants.Value1.data, "data is not equal")
        XCTAssert(value.gradient == Constants.Value1.gradient, "gradient is not equal")
        XCTAssert(value.label == Constants.Value1.label, "label is not equal")
        XCTAssert(value.operation == Constants.Value1.operation, "operation is not equal")
        XCTAssert(value.previous == Constants.Value1.previous, "previous is not equal")
    }

    func testValue_add() throws {
        let value1 = ValueTests.makeValue1()
        let value2 = ValueTests.makeValue2()
        
        let sum = value1 + value2

        XCTAssert(sum.data == Constants.Value1.data + Constants.Value2.data, "Sum data is not equal")
        XCTAssert(sum.gradient == 0.0, "Sum gradient is not zero")
        XCTAssert(sum.label == "\(Constants.Value1.label) + \(Constants.Value2.label)", "Sum label is not equal")
        XCTAssert(sum.operation == "+")
        XCTAssert(sum.previous.subtracting([value1, value2]) == .init())
    }
}

extension ValueTests {
    
    enum Constants {
        enum Value1 {
            static let data: Double = 22.2
            static let gradient = 1.0
            static let label = "test"
            static let operation = ""
            static let previous: Set<Value> = .init()
        }
        
        enum Value2 {
            static let data: Double = 5.43
            static let gradient = 0.53
            static let label = "someLabel"
            static let operation = "+"
            static let previous: Set<Value> = .init()
        }
    }
    
    static func makeValue1() -> Value {
        return Value(
            data: Constants.Value1.data,
            gradient: Constants.Value1.gradient,
            label: Constants.Value1.label,
            operation: Constants.Value1.operation,
            previous: Constants.Value1.previous
        )
    }
    
    static func makeValue2() -> Value {
        return Value(
            data: Constants.Value2.data,
            gradient: Constants.Value2.gradient,
            label: Constants.Value2.label,
            operation: Constants.Value2.operation,
            previous: Constants.Value2.previous
        )
    }
}
