import XCTest
@testable import Micrograd

final class ValueTestsExp: XCTestCase {
    
    func testValue_exp() throws {
        let value1 = ValueTestsUtils.makeValue1()
        let sum = value1.exponent()

        ValueTestsUtils.assertDouble(sum.data, exp(value1.data))
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "exp(\(value1.label))")
        ValueTestsUtils.assertString(sum.operation, "exp")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.Constants.set1)
    }
    
    func testValue_exp_negative() throws {
        let value3 = ValueTestsUtils.makeValue3()
        let sum = value3.exponent()

        ValueTestsUtils.assertDouble(sum.data, exp(value3.data))
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "exp(\(value3.label))")
        ValueTestsUtils.assertString(sum.operation, "exp")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.Constants.set3)
    }
    
    func test_backpropagation_exp() {
        let value1 = Value(data: 0.3)
        let value2 = Value(data: 0.2)

        let value3 = value1 * value2
        let value4 = value3.exponent()
        Value.start_backpropagation(value4)
        
        ValueTestsUtils.assertDouble(value1.gradient, 0.21236730930907194)
        ValueTestsUtils.assertDouble(value2.gradient, 0.31855096396360788)
        ValueTestsUtils.assertDouble(value3.gradient, 1.0618365465453596)
        ValueTestsUtils.assertDouble(value4.gradient, 1.0)
    }
}
