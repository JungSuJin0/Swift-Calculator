//
//  ViewController.swift
//  Calculator
//
//  Created by 정수진 on 5/9/25.
//


import UIKit

//열거형 연산 종류
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case Percent
    case Toggle
    case Unknown
}


//클래스는 설계도(틀)이기에 함수 내부가 아니라 밖에 정의하는게 맞음
//ViewController라는 화면이 생성될 때 먼저 메모리에 올라가야 할 정보들
class ViewController: UIViewController {
    
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var equlButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var numOneButton: UIButton!
    @IBOutlet weak var numTwoButton: UIButton!
    @IBOutlet weak var numThreeButton: UIButton!
    @IBOutlet weak var numFourButton: UIButton!
    @IBOutlet weak var numFiveButton: UIButton!
    @IBOutlet weak var numSixButton: UIButton!
    @IBOutlet weak var numSevenButton: UIButton!
    @IBOutlet weak var numEightButton: UIButton!
    @IBOutlet weak var numNineButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    
    //AC 버튼, C 버튼
    @IBOutlet weak var acButton: UIButton!
    
    //연산 결과에 대한 버튼
    @IBOutlet weak var numberResultLabel: UILabel!
    
    //입력에 대한 버튼
    @IBOutlet weak var historyLabel: UILabel!
    
    //타입 설정
    var displayNumber: String = ""
    var firstNumber: String = ""
    var secondNumber: String = ""
    var result: String = ""
    var currentOperation: Operation = .Unknown
    var isFirstInput: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        historyLabel.adjustsFontSizeToFitWidth = true
        //기본 폰트가 60pt라면 → 최대 18pt까지 줄어들 수 있음 (60 × 0.3)
        historyLabel.minimumScaleFactor = 0.3
        historyLabel.numberOfLines = 2
        historyLabel.lineBreakMode = .byTruncatingTail
        
        
        numberResultLabel.adjustsFontSizeToFitWidth = true
        //기본 폰트가 60pt라면 → 최대 18pt까지 줄어들 수 있음 (60 × 0.3)
        numberResultLabel.minimumScaleFactor = 0.3
        numberResultLabel.numberOfLines = 1
        numberResultLabel.lineBreakMode = .byTruncatingTail
        
        //버튼 모양주기,,,,
        zeroButton.layer.cornerRadius = 39
        dotButton.layer.cornerRadius = 40
        equlButton.layer.cornerRadius = 40
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        minusButton.layer.cornerRadius = minusButton.frame.height / 2
        multiply.layer.cornerRadius = multiply.frame.height / 2
        divideButton.layer.cornerRadius = divideButton.frame.height / 2
        acButton.layer.cornerRadius = acButton.frame.height / 2
        toggleButton.layer.cornerRadius = toggleButton.frame.height / 2
        percentButton.layer.cornerRadius = percentButton.frame.height / 2
        numOneButton.layer.cornerRadius = numOneButton.frame.height / 2
        numTwoButton.layer.cornerRadius = numTwoButton.frame.height / 2
        numThreeButton.layer.cornerRadius = numThreeButton.frame.height / 2
        numFourButton.layer.cornerRadius = numFourButton.frame.height / 2
        numFiveButton.layer.cornerRadius = numFiveButton.frame.height / 2
        numSixButton.layer.cornerRadius = numSixButton.frame.height / 2
        numSevenButton.layer.cornerRadius = numSevenButton.frame.height / 2
        numEightButton.layer.cornerRadius = numEightButton.frame.height / 2
        numNineButton.layer.cornerRadius = numNineButton.frame.height / 2
        
    }
    
    
    //1~9까지 버튼
    @IBAction func CalNumberButton(_ sender: UIButton) {
        //guard let numberValue = sender.title(for: .highlighted) else { return }
        
        if let numberValue = sender.title(for: .highlighted) {
            
            //    if self.displayNumber.count < 9 {
            //01, 02 x
            if self.displayNumber == "0" {
                self.displayNumber = numberValue
            } else {
                self.displayNumber += numberValue
            }
            self.numberResultLabel.text = self.displayNumber
            
            
            if isFirstInput {
                acButton.setTitle("C", for: .normal)
                isFirstInput = false
            }
        }
    }
    // }
    
    
    //초기화 버튼(모든 값 초기화)
    @IBAction func calClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstNumber = ""
        self.secondNumber = ""
        self.result = ""
        self.currentOperation = .Unknown
        self.numberResultLabel.text = "0"
        self.historyLabel.text = ""
        
        //func setTitle(_ title: String?, for state: UIControl.State) 함수원형
        acButton.setTitle("AC", for: .normal)
        isFirstInput = true
    }
    
    
    
    //. 버튼
    @IBAction func calDotButton(_ sender: UIButton) {
        //        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
        //            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
        //            self.numberResultLabel.text = self.displayNumber
        //        }
        if self.displayNumber.count < 8 && !self.displayNumber.contains("."){
            if self.displayNumber.isEmpty {
                self.displayNumber += "0."
            } else {
                self.displayNumber += "."
            }
            self.numberResultLabel.text = self.displayNumber
            
            if isFirstInput {
                acButton.setTitle("C", for: .normal)
                isFirstInput = false
            }
        }
    }
    
    
    //나누기 버튼
    @IBAction func calDivideButton(_ sender: UIButton) {self.operation(.Divide)
    }
    
    //곱하기 버튼
    @IBAction func calMultiplyButton(_ sender: UIButton) {self.operation(.Multiply)
    }
    
    //빼기 버튼
    @IBAction func calMinusButton(_ sender: UIButton) {self.operation(.Subtract)
    }
    
    //더하기 버튼
    @IBAction func calPlusButton(_ sender: UIButton) {self.operation(.Add)
    }
    
    //결과값 버튼
    @IBAction func calEqualButton(_ sender: UIButton) { self.operation(self.currentOperation)
    }
    
    @IBAction func calPercentButton(_ sender: UIButton) {
        self.operation(.Percent)
    }
    
    @IBAction func toggleButton(_ sender: UIButton) {
        self.operation(.Toggle)
    }

    
    
    //단항연산
    //"%g" 는 필요에 따라 소수점 또는 지수 형식으로 숫자를 간단하게 출력
    func operation(_ operation: Operation){
        
        if operation == .Percent {
            if let currentValue = Double(self.displayNumber.isEmpty ? self.firstNumber : self.displayNumber) {
                let percentValue = currentValue * 0.01
                self.result = String(format: "%g", percentValue)
                self.displayNumber = self.result
                self.numberResultLabel.text = self.result
                self.historyLabel.text = self.result
                
            } else {
                self.result = "0"
                self.numberResultLabel.text = self.result
            }
            return
        } else if operation == .Toggle {
            if let currentValue = Double(self.displayNumber.isEmpty ? self.firstNumber : self.displayNumber) {
                let percentValue = currentValue * -1
                self.result = String(format: "%g", percentValue)
                self.displayNumber = self.result
                self.numberResultLabel.text = self.result
                self.historyLabel.text = self.result
                
            } else {
                self.result = "0"
                self.numberResultLabel.text = self.result
            }
            return
        }
        
        
        
        //사칙연산
        if self.currentOperation != .Unknown {
            if !self.displayNumber.isEmpty {
                self.secondNumber = self.displayNumber
                self.displayNumber = ""
                
                
                guard let firstOperand = Double(self.firstNumber) else { return }
                guard let secondOperand = Double(self.secondNumber) else { return }
                
                
                
                switch self.currentOperation {
                    
                    
                    //"\(firstOperand - secondOperand)" = 부동소수점 오차 그대로 다 출력됨
                case .Add :
                    self.result = String(format: "%g", firstOperand + secondOperand)
                    self.historyLabel.text = "\(self.firstNumber) + \(secondNumber) = \(result)"
                    
                case .Subtract :
                    self.result = String(format: "%g", firstOperand - secondOperand)
                    self.historyLabel.text = "\(self.firstNumber) - \(secondNumber) = \(result)"
                    
                case .Divide:
                    if secondOperand == 0 {
                        self.result = "Error"
                    } else {
                        self.result = String(format: "%g", firstOperand / secondOperand)
                    }
                    self.historyLabel.text = "\(self.firstNumber) ÷ \(secondNumber) = \(result)"
                    
                case .Multiply:
                    self.result = String(format: "%g", firstOperand * secondOperand)
                    self.historyLabel.text = "\(self.firstNumber) × \(secondNumber) = \(result)"
                    
                default:
                    break
                }
                
                if let result = Double(self.result) {
                    self.result = String(format: "%g", result)
                }
                
                self.firstNumber = self.result
                self.numberResultLabel.text = self.result
                
                    
                
            }
            self.currentOperation = operation
            
        } else {
            self.firstNumber = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
            
        }
    }
}
    
