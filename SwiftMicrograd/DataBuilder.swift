import Foundation
import Micrograd

class DataBuilder {
    
    static func buildData() -> Value {
        let x_train: [[Value]] = (0..<Params.train_dataset_size).map { _ in
            [Value.makeRandomValueTrain(), Value.makeRandomValueTrain()]
        }
        
        let y_train: [Value] = x_train.map { x_i in
            x_i[0] + x_i[1]
        }
        
        let x_test = (0..<Params.test_dataset_size).map { _ in
            [Value.makeRandomValueTrain(), Value.makeRandomValueTrain()]
        }
        
        let y_test: [Value] = x_test.map { x_i in
            x_i[0] + x_i[1]
        }
        
        let mlp = MLP(layersWithSize: Params.layers)
        
        var dW: [Value] = .init(repeating: Value(data: 0.0), count: mlp.parameters().count)

        for _ in 0..<Params.train_iterations {
            var y_predicted: [Value] = []
            for j in 0..<Params.train_dataset_size {
                    let prediction = mlp.call(input: x_train[j])[0]
                    y_predicted.append(prediction)
            }
            let loss = SquareLoss.calculate_loss(y_pred: y_predicted, y_val: y_train)
            print(loss.data)
            mlp.zeroParameters()
            Value.start_backpropagation(loss)
            let parameters = mlp.parameters()
            for (index, param) in parameters.enumerated() {
                let nQ = Params.learningRate * param.gradient
                let a = 0.3
                dW[index] = a * dW[index] - nQ
                param.data = param.data + dW[index].data
            }
        }
        
        var y_predicted_validation: [Value] = []
        for i in 0..<Params.test_dataset_size {
            let prediction = mlp.call(input: x_test[i])
            y_predicted_validation.append(prediction[0])
            let real_y = y_test[i]
            print("For input: \(x_test[i][0].pretty) + \(x_test[i][1].pretty) = \(real_y.pretty)")
            print("Predicted: \(prediction[0].pretty), loss: \(SquareLoss.calculate_loss(y_pred: prediction, y_val: [real_y]).pretty)")
        }
        print("Total SquareLoss Validation: \(SquareLoss.calculate_loss(y_pred: y_predicted_validation, y_val: y_test).pretty)")
        print(mlp.parameters().map { $0.pretty })
        return Value(data: 0)
    }
    
    static func loadModel() -> Value {
        let mlp = MLP(layersWithSize: Params.layers)
        let params = ["1.1422", "1.1396", "1.1026", "1.2179", "1.2175", "-1.2146", "-0.3863", "-0.3857", "-0.7105", "-1.0621", "-1.0633", "1.0191", "-1.0336", "-1.0324", "-1.0553", "-0.5184", "-0.5183", "0.4518", "-0.3406", "-0.3406", "-0.3410", "-0.3406", "0.2163", "-0.9644", "-0.9640", "-0.9650", "-0.9642", "1.2175", "-0.5738", "-0.5746", "-0.5737", "-0.5742", "-0.8541", "-0.4691", "-0.4696", "-0.4691", "-0.4693", "-0.6035", "0.6760", "0.6771", "0.6762", "0.6761", "-0.0018"].map { Value(data: Double($0)!) }
        mlp.setParameters(parameters: params)
        
        let x_test = (0..<1000).map { _ in
            [Value(data: Double(Value.makeRandomValueTrain().data.toStringRounded(scale: 3))!),
             Value(data: Double(Value.makeRandomValueTrain().data.toStringRounded(scale: 3))!)
            ]
        }
        
        let y_test: [Value] = x_test.map { x_i in
            x_i[0] + x_i[1]
        }
        
        var y_predicted_validation: [Value] = []
        for i in 0..<1000 {
            let prediction = mlp.call(input: [
                x_test[i][0],
                x_test[i][1]
            ])[0]
            print("\(x_test[i][0].data) + \(x_test[i][1].data) = \(prediction.data.toStringRounded(scale: 3)), and real answer is : \((x_test[i][0].data + x_test[i][1].data).toStringRounded(scale: 3))")
            y_predicted_validation.append(prediction)
        }
        print("Total SquareLoss Validation: \(SquareLoss.calculate_loss(y_pred: y_predicted_validation, y_val: y_test).pretty)")
        return Value(data: 0)
    }
}

extension DataBuilder {
    
    enum Params {
        static let train_dataset_size: Int = 192
        static let test_dataset_size: Int = 30
        static let train_iterations: Int = 6000
        static let layers: [Int] = [2, 4, 4, 1]
        static let learningRate: Double = 0.0025
    }
}
