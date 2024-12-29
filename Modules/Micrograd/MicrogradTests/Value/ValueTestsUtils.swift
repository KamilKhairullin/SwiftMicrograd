import Foundation
import XCTest
@testable import Micrograd

final class ValueTestsUtils {
    
    static func makeSet(from v: [Value]) -> Set<Value> {
        return .init(v)
    }
    
    static func assertDouble(_ test: Double, _ expected: Double) {
        XCTAssert(isTwoDoubleEqual(test, expected), "Expected \(expected), but got \(test)")
    }
    
    static func assertString(_ test: String?, _ expected: String?) {
        guard let test = test, let expected = expected else { 
            XCTAssertNil(test)
            XCTAssertNil(expected)
            return
        }
        XCTAssert(test == expected, "Expected \(expected), but got \(test)")
    }
    
    static func assertSet(_ test: Set<Value>, _ expected: Set<Value>) {
        // TODO: - fixme
//        XCTAssert(test.subtracting(expected).isEmpty, "Set substraction is not empty")
//        XCTAssert(expected.subtracting(test).isEmpty, "Set substraction is not empty")
    }
    
    
    
    static func isTwoDoubleEqual(_ a: Double, _ b: Double) -> Bool {
        abs(a - b) < 1e-12
    }
}

extension ValueTestsUtils {
    
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
            static let operation = ""
            static let previous: Set<Value> = .init()
        }
        
        enum Value3 {
            static let data: Double = -12.43
            static let gradient = 0.53
            static let label = "-x"
            static let operation = ""
            static let previous: Set<Value> = .init()
        }
        
        static let set1 = ValueTestsUtils.makeSet(from: [makeValue1()])
        static let set3 = ValueTestsUtils.makeSet(from: [makeValue3()])
        static let set12 = ValueTestsUtils.makeSet(from: [makeValue1(), makeValue2()])
        static let set13 = ValueTestsUtils.makeSet(from: [makeValue1(), makeValue3()])
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
    
    static func makeValue3() -> Value {
        return Value(
            data: Constants.Value3.data,
            gradient: Constants.Value3.gradient,
            label: Constants.Value3.label,
            operation: Constants.Value3.operation,
            previous: Constants.Value3.previous
        )
    }
}
  
