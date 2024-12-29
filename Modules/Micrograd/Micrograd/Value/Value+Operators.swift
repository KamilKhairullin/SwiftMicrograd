import Foundation

infix operator +: AdditionPrecedence

public extension Value {

    static func + (lhs: Value, rhs: Value) -> Value {
        let out = Value(
            data: lhs.data + rhs.data,
            gradient: 0.0,
            label: "\(lhs.label) + \(rhs.label)",
            operation: "+",
            previous: [lhs, rhs]
        )
        out.backward = {
            lhs.gradient += 1.0 * out.gradient
            rhs.gradient += 1.0 * out.gradient
        }
        return out
    }
//    
//    static func + (lhs: Value, rhs: Double) -> Value {
//        let rhsValue = Value(
//            data: rhs,
//            gradient: 0.0,
//            label: "\(rhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhs + rhsValue
//    }
//    
//    static func + (lhs: Double, rhs: Value) -> Value {
//        let lhsValue = Value(
//            data: lhs,
//            gradient: 0.0,
//            label: "\(lhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhsValue + rhs
//    }
}

infix operator *: MultiplicationPrecedence

public extension Value {
    
    static func * (lhs: Value, rhs: Value) -> Value {
        let out = Value(
            data: lhs.data * rhs.data,
            gradient: 0.0,
            label: "\(lhs.label) * \(rhs.label)",
            operation: "*",
            previous: [lhs, rhs]
        )
        out.backward = {
            lhs.gradient += rhs.data * out.gradient
            rhs.gradient += lhs.data * out.gradient
        }
        return out
    }
    
    static func * (lhs: Value, rhs: Double) -> Value {
        let rhsValue = Value(
            data: rhs,
            gradient: 0.0,
            label: "\(rhs.toStringRounded(scale: 3))",
            operation: nil,
            previous: .init()
        )
        return lhs * rhsValue
    }
    
    static func * (lhs: Double, rhs: Value) -> Value {
        let lhsValue = Value(
            data: lhs,
            gradient: 0.0,
            label: "\(lhs.toStringRounded(scale: 3))",
            operation: nil,
            previous: .init()
        )
        return lhsValue * rhs
    }
}
    
infix operator -: AdditionPrecedence

public extension Value {

    static func - (lhs: Value, rhs: Value) -> Value {
//        let out = Value(
//            data: lhs.data - rhs.data,
//            gradient: 0.0,
//            label: "\(lhs.label) - \(rhs.label)",
//            operation: "-",
//            previous: [lhs, rhs]
//        )
//        out.backward = {
//            lhs.gradient += 1.0 * out.gradient
//            rhs.gradient += 1.0 * out.gradient
//        }
        let minusRhs = (-1) * rhs
        return lhs + minusRhs
    }
//    
//    static func - (lhs: Value, rhs: Double) -> Value {
//        let rhsValue = Value(
//            data: rhs,
//            gradient: 0.0,
//            label: "\(rhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhs - rhsValue
//    }
//    
//    static func - (lhs: Double, rhs: Value) -> Value {
//        let lhsValue = Value(
//            data: lhs,
//            gradient: 0.0,
//            label: "\(lhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhsValue - rhs
//    }
}

infix operator /: MultiplicationPrecedence

public extension Value {

//    static func / (lhs: Value, rhs: Value) -> Value {
//        let rhs_powered = rhs ^^ (-1)
//        let out = lhs * rhs_powered
//        out.label = "\(lhs.label) / \(rhs.label)"
//        out.operation = "/"
//        return out
//    }
//    
//    static func / (lhs: Value, rhs: Double) -> Value {
//        let rhsValue = Value(
//            data: rhs,
//            gradient: 0.0,
//            label: "\(rhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhs / rhsValue
//    }
//    
//    static func / (lhs: Double, rhs: Value) -> Value {
//        let lhsValue = Value(
//            data: lhs,
//            gradient: 0.0,
//            label: "\(lhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhsValue / rhs
//    }
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }

infix operator ^^ : PowerPrecedence

public extension Value {

//    static func ^^ (lhs: Value, rhs: Value) -> Value {
//        let out = Value(
//            data: pow(lhs.data,rhs.data),
//            gradient: 0.0,
//            label: "\(lhs.label) ^ \(rhs.label)",
//            operation: "^",
//            previous: [lhs, rhs]
//        )
//        out.backward = {
//            lhs.gradient += rhs.data * pow(lhs.data, rhs.data - 1) * out.gradient
//        }
//        return out
//    }
//    
//    static func ^^ (lhs: Value, rhs: Double) -> Value {
//        let rhsValue = Value(
//            data: rhs,
//            gradient: 0.0,
//            label: "\(rhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhs ^^ rhsValue
//    }
//    
//    static func ^^ (lhs: Double, rhs: Value) -> Value {
//        let lhsValue = Value(
//            data: lhs,
//            gradient: 0.0,
//            label: "\(lhs.toStringRounded(scale: 3))",
//            operation: nil,
//            previous: .init()
//        )
//        return lhsValue ^^ rhs
//    }
}


public extension Value {

//    func tanh() -> Value {
//        let exp = (2 * self).exponent()
//        let out = (exp - 1) / (exp + 1)
//        out.label = "tanh(\(self.label))"
//        out.operation = "tanh"
//        return out
//    }
//    
//    func tanh() -> Value {
//        let out = Value(
//            data: Darwin.tanh(self.data),
//            gradient: 0.0,
//            label: "tanh(\(self.label))",
//            operation: "tanh",
//            previous: [self]
//        )
//        out.backward = {
//            self.gradient += (1 - out.data * out.data) * out.gradient
//        }
//        return out
//    }
        
    func tanh() -> Value {
        let n = self.data
        let e = exp((2 * n))
        let out = (e - 1) / (e + 1)
        let value = Value(
            data: out,
            gradient: 0.0,
            label: "tanh(\(self.label))",
            operation: "tanh",
            previous: [self]
        )
        value.backward = {
            self.gradient += (1 - out * out) * value.gradient
        }
        return value
    }
  
    
    func exponent() -> Value {
        let out = Value(
            data: exp(self.data),
            gradient: 0.0,
            label: "exp(\(self.label))",
            operation: "exp",
            previous: [self]
        )
        out.backward = {
            self.gradient += out.data * out.gradient
        }
        return out
    }
}
