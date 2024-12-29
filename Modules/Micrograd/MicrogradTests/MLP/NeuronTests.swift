import XCTest
@testable import Micrograd

final class NeuronTests: XCTestCase {
    
    func testNeuron() throws {
        let weights = [0.25, 0.3, 0.5, 0.7].map { Value(data: $0) }
        let bias = Value(data: 0.12)
        let n = Neuron(weights: weights, bias: bias)
        let x = [0.5, 0.2, 1, 0.8].map { Value(data: $0) }
        let result = n.call(input: x)
        ValueTestsUtils.assertDouble(result.data, 0.877547674360184)
    }
    
    func testNeuron_parameters() throws {
        let weights = [0.25, 0.3, 0.5, 0.7].map { Value(data: $0) }
        let bias = Value(data: 0.12)
        let n = Neuron(weights: weights, bias: bias)
        let values = n.parameters()
        XCTAssert(values.map { $0.data } == [0.25, 0.3, 0.5, 0.7, 0.12])
    }
    
    func testNeuron_parameters_change() throws {
        let weights = [0.25, 0.3, 0.5, 0.7].map { Value(data: $0) }
        let bias = Value(data: 0.12)
        let n = Neuron(weights: weights, bias: bias)
        let values = n.parameters()
        XCTAssert(values.map { $0.data } == [0.25, 0.3, 0.5, 0.7, 0.12])
        ValueTestsUtils.assertDouble(values[0].gradient, 0.0)
        values[0].data = 0.001
        values[1].gradient = 0.5505
        XCTAssert(n.weights.map { $0.data } == [0.001, 0.3, 0.5, 0.7])
        XCTAssert(n.weights.map { $0.gradient } == [0.0, 0.5505, 0.0, 0.0])
    }
}
