//
//  ViewController.swift
//  Calculator
//
//  Created by 정수진 on 5/9/25.
//


import UIKit

//연산의 종류를 열거형으로 표현
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case Percent
    case Toggle
}


//계산기 화면을 제어하는 클래스
class ViewController: UIViewController {
    
    //버튼과 레이블을 연결해주는 UI 컴포넌트(사용자와 앱이 상호작용할 수 있도록 구성된 화면 요소)
    //스택 다르면 연결에 제약이 생겨버림 -> 뷰 계층이 달라지기 때문에(부모가 달라지게 됨)
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
    
    //변수 설정
    var displayNumber: String = ""     //현재 입력 중인 숫자
    var firstNumber: String = ""       //첫 번째 피연산자
    var result: String = ""            //연산결과
    var isFirstInput: Bool = true      //입력이 첫 번째 입력 여부인지
    var expressionText: String = ""    //전체 수식(5+6+7)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI 초기 설정
        historyLabel.adjustsFontSizeToFitWidth = true
        //기본 폰트가 60pt라면 → 최대 18pt까지 줄어들 수 있음 (60 × 0.3)
        historyLabel.minimumScaleFactor = 0.3
        historyLabel.numberOfLines = 2
        historyLabel.lineBreakMode = .byTruncatingTail
        
        numberResultLabel.adjustsFontSizeToFitWidth = true
        numberResultLabel.minimumScaleFactor = 0.3
        numberResultLabel.numberOfLines = 1
        numberResultLabel.lineBreakMode = .byTruncatingTail
        
        //버튼 모양주기
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
        
        //numberValue=String
        if let numberValue = sender.title(for: .normal) {
            
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
    
    
    
    //초기화 버튼(모든 값 초기화)
    @IBAction func calClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstNumber = ""
        self.result = ""
        self.numberResultLabel.text = "0"
        self.historyLabel.text = ""
        
        acButton.setTitle("AC", for: .normal)
        isFirstInput = true
    }
    
    
    
    //. 버튼
    @IBAction func calDotButton(_ sender: UIButton) {
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
    
    
    //최종적으로 값이 넘어오는 부분
    //operation (메서드)함수에 .Divide 열거형 값을 전달하여 나누기 연산 수행을 준비 = 메서드 호출
    //공통적으로 self.operation(...)을 호출하여 해당 연산을 처리하도록 연결
    
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
    @IBAction func calEqualButton(_ sender: UIButton) { calculateFinalResult()
    }
    
    //% 버튼
    @IBAction func calPercentButton(_ sender: UIButton) { self.operation(.Percent)
    }
     
    //+/- 버튼
    @IBAction func toggleButton(_ sender: UIButton) { self.operation(.Toggle)
    }
    
    
    
    //Operation이 enum이 op로 사용
    //
    func symbolForOperation(_ op: Operation) -> String {
        switch op {
        case .Add: return "+"
        case .Subtract: return "-"
        case .Multiply: return "*"
        case .Divide: return "/"
        case .Percent, .Toggle:
            return ""
        }
    }
    
    
    //Operation 타입의 매개변수를 받아옴
    func operation(_ operation: Operation) {
        if operation == .Percent {
            //비어있으면 → firstNumber 사용
            //아니면 → 현재 입력된 숫자 사용
            if let currentValue = Double(displayNumber.isEmpty ? firstNumber : displayNumber) {
                let percentValue = currentValue * 0.01
                //불필요한 0이나 소수점 표현을 자동으로 줄여줌
                result = String(format: "%g", percentValue)
                displayNumber = result
                numberResultLabel.text = result
                historyLabel.text = result
            } else {
                result = "0"
                numberResultLabel.text = result
            }
            return
        }
        
        if operation == .Toggle {
            if let currentValue = Double(displayNumber.isEmpty ? firstNumber : displayNumber) {
                let toggledValue = currentValue * -1
                result = String(format: "%g", toggledValue)
                displayNumber = result
                numberResultLabel.text = result
                historyLabel.text = result
            } else {
                result = "0"
                numberResultLabel.text = result
            }
            return
        }
        
        
        // 사칙연산 처리
        // 연산자를 눌렀을떄 (입력된숫자)disnum와 클릭된 연산자를 express에 더해준다
        if !displayNumber.isEmpty {
            expressionText += displayNumber
            //전의 숫자 없애줌
            displayNumber = ""
        }
        
        //중복제거
        if let last = expressionText.last, "+-*/".contains(last) {
            expressionText.removeLast()
        }
        
        //수식더해줌
        //예) syboleFOrOperation(.Add) 호출이 되면서 "+" 문자열 반환
        expressionText += symbolForOperation(operation)
        displayNumber = ""
    }
    
    
    
    func calculateFinalResult() {
        //아직 입력 중인 숫자가 있다면 수식 뒤에 붙이기
        //사용자가 "5+3"을 입력하고 3이 displayNumber에 있다면 → "5+3" 완성
        if !displayNumber.isEmpty {
            expressionText += displayNumber
        }
        //사용자가 5+3햇어,, dis=3이 있고 expres=5+ 까지만 잇어
        
        
        //계산 가능한 형태로 연산자 바꿔주기
        let cleanExpression = expressionText
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        
        //cleanExpression 값이 evaluate으로 넘어가면서 계산된 결과값 value가 됨
        let value = evaluate(cleanExpression)
        
        //결과를 문자열로 바꾸고 레이블에 표시
        result = String(format: "%g", value)
        numberResultLabel.text = result
        
        //계산 이력 레이블에도 수식과 함께 표시하기====보여지는 수식
        historyLabel.text = expressionText + " = " + result
        
        //계산 끝났으니 수식 초기화하고, 결과를 다음 입력으로 준비
        expressionText = ""
        displayNumber = result
    }
    
    
    //연산자 우선순위 계산하는 함수
    //지역변수
    //expression = expressionText
    func evaluate(_ expression: String) -> Double {
        //위치선언 다른함수안에 넣을 순 없음 그 함수 안에서만 유효
        var index = expression.startIndex
        func parseExpression() -> Double {
            var value = parseTerm()
            while index < expression.endIndex {
                let char = expression[index]
                if char == "+" {
                    index = expression.index(after: index)
                    value += parseTerm()
                } else if char == "-" {
                    index = expression.index(after: index)
                    value -= parseTerm()
                } else {
                    break
                }
            }
            return value
        }
        func parseTerm() -> Double {
            var value = parseFactor()
            while index < expression.endIndex {
                let char = expression[index]
                if char == "*" {
                    //*위치 기준으로 다음 인덱스를 가져옴
                    index = expression.index(after: index)
                    value *= parseFactor()
                } else if char == "/" {
                    index = expression.index(after: index)
                    value /= parseFactor()
                } else {
                    break
                }
            }
            return value
        }
        func parseFactor() -> Double {
            //= start.index 같은의미
            //"12.5+3"
//            처음 index는 "1"을 가리킴
//            while 반복문이 "12.5"까지 읽음
//            +에서 멈춤
//            "12.5" 문자열 → Double로 변환 → 12.5 반환
//            parseFactor()는 수식에서 연속된 숫자와 소수점을 읽어 숫자 문자열을 추출한 뒤,
//            이를 Double 타입으로 변환하여 반환하는 함수입니다.
//            수식을 왼쪽부터 하나씩 분석해가며 숫자를 정확히 추출하는 핵심 파싱 함수로,
//            사칙연산의 각 항(피연산자)을 정확히 구분해주는 역할을 합니다.
            var start = index
            while index < expression.endIndex,
                  expression[index].isNumber || expression[index] == "." {
                index = expression.index(after: index)
            }
            let numberString = String(expression[start..<index])
            return Double(numberString) ?? 0
        }
        return parseExpression()
    }
}
