import XCTest
@testable import Micrograd

final class ValueTestsDiv: XCTestCase {
    
    func testValue_div() throws {
        let value1 = ValueTestsUtils.makeValue1()
        let value2 = ValueTestsUtils.makeValue2()
        
        let sum = value1 / value2

        ValueTestsUtils.assertDouble(sum.data, value1.data / value2.data)
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "\(value1.label) / \(value2.label)")
        ValueTestsUtils.assertString(sum.operation, "/")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.Constants.set12)
    }
    
    func testValue_div_double_right() throws {
        let value1 = ValueTestsUtils.makeValue1()
        let value2 = Value(data: 3.0)
        let sum = value1 / 3.0

        ValueTestsUtils.assertDouble(sum.data, value1.data / 3.0)
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "\(value1.label) / 3.000")
        ValueTestsUtils.assertString(sum.operation, "/")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.makeSet(from: [value1, value2]))
    }
    
    func testValue_div_double_left() throws {
        let value1 = ValueTestsUtils.makeValue1()
        let sum = 3.0 / value1
        let value2 = Value(data: 3.0)
        
        ValueTestsUtils.assertDouble(sum.data, 3.0 / value1.data)
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "3.000 / \(value1.label)")
        ValueTestsUtils.assertString(sum.operation ?? "", "/")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.makeSet(from: [value1, value2]))
    }
    
    func testValue_div_negative() throws {
        let value1 = ValueTestsUtils.makeValue1()
        let value3 = ValueTestsUtils.makeValue3()
        let sum = value1 / value3

        ValueTestsUtils.assertDouble(sum.data, value1.data / value3.data)
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "\(value1.label) / \(value3.label)")
        ValueTestsUtils.assertString(sum.operation, "/")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.Constants.set13)
    }
    
    func testValue_div_negative_double() throws {
        let value1 = ValueTestsUtils.makeValue1()
        
        let sum = value1 / (-5.2)
        let value2 = Value(data: -5.2)

        ValueTestsUtils.assertDouble(sum.data, value1.data / (-5.2))
        ValueTestsUtils.assertDouble(sum.gradient, 0.0)
        ValueTestsUtils.assertString(sum.label, "\(value1.label) / -5.200")
        ValueTestsUtils.assertString(sum.operation ?? "", "/")
        ValueTestsUtils.assertSet(sum.previous, ValueTestsUtils.makeSet(from: [value1, value2]))
    }
    
    func test_backpropagation_div() {
        let value1 = Value(data: 8)
        let value2 = Value(data: 2)
        let value3 = Value(data: 2)
        let value4 = Value(data: 1)

        let value5 = value1 / value2
        let value6 = value3 / value4
        let value7 = value5 / value6
        Value.start_backpropagation(value7)
        
        ValueTestsUtils.assertDouble(value1.gradient, 0.25)
        ValueTestsUtils.assertDouble(value2.gradient, -1.0)
        ValueTestsUtils.assertDouble(value3.gradient, -1.0)
        ValueTestsUtils.assertDouble(value4.gradient, 2.0)
        ValueTestsUtils.assertDouble(value5.gradient, 0.5)
        ValueTestsUtils.assertDouble(value6.gradient, -1.0)
        ValueTestsUtils.assertDouble(value7.gradient, 1.0)
    }
}
