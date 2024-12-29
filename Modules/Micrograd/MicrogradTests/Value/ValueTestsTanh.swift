import XCTest
@testable import Micrograd

final class ValueTestsTanh: XCTestCase {
    
    func testValue_tanh() throws {
        let value1 = ValueTestsUtils.makeValue1()
        let sum = value1.tanh()

        ValueTestsUtils.assertDouble(sum.data, tanh(value1.data))
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "tanh(\(value1.label))")
        ValueTestsUtils.assertString(sum.operation, "tanh")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.Constants.set1)
    }
    
    func testValue_tanh_negative() throws {
        let value3 = ValueTestsUtils.makeValue3()
        let sum = value3.tanh()

        ValueTestsUtils.assertDouble(sum.data, tanh(value3.data))
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "tanh(\(value3.label))")
        ValueTestsUtils.assertString(sum.operation, "tanh")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.Constants.set3)
    }
    
    func test_backpropagation_tanh() {
        let value1 = Value(data: 0.3)
        let value2 = Value(data: 0.2)

        let value3 = value1 * value2
        let value4 = value3.tanh()
        Value.start_backpropagation(value4)
        
        ValueTestsUtils.assertDouble(value1.gradient, 0.19928172448148007)
        ValueTestsUtils.assertDouble(value2.gradient, 0.29892258672222005)
        ValueTestsUtils.assertDouble(value3.gradient, 0.99640862240740025)
        ValueTestsUtils.assertDouble(value4.gradient, 1.0)
    }
}
