//
//  ContentView.swift
//  Calculator
//
//  Created by 이나연 on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State private var prevNumber: Double = 0
    @State private var operatorSign: String? = nil
    @State private var nextNumber: Double = 0
    @State private var shouldResetTotalNumber: Bool = false
    
    enum ButtonType : String{
        case one, two, three, four, five, six, seven, eight, nine, zero
        case plus, minus, multiple, divide, equal, dot
        case clear, slash, percent, imoji
        
        var buttonDisplayName :  String{
            switch self{
                case .one : return "1"
                case .two : return "2"
                case .three : return "3"
                case .four : return "4"
                case .five : return "5"
                case .six : return "6"
                case .seven: return "7"
                case .eight : return "8"
                case .nine : return "9"
                case .zero : return "0"
                case .plus: return "+"
                case .minus: return "-"
                case .multiple: return "X"
                case .divide : return "÷"
                case .equal : return "="
                case .dot : return "."
                case .clear : return "C"
                case .slash : return "/"
                case .percent : return "%"
                case .imoji : return "🧮"
            }
        }
        
        var buttonBackgroundColor : Color{
            switch self{
            case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot, .imoji :
                return Color("NumberButton")
            case .clear, .slash, .percent : return Color.gray
            case .plus, .minus, .multiple, .divide, .equal : return Color.orange
            }
        }
        
        var buttonForegroundColor : Color{
            switch self{
            case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot, .plus, .minus, .multiple, .divide, .equal, .imoji  :
                return Color.white
            case .clear, .slash, .percent :
                return Color.black
            }
        }
    }
    
    
    private let buttonData: [[ButtonType]] = [
        [.clear, .slash, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.imoji, .zero, .dot, .equal]
    ]
    
    private func calculateNumber(){
        var result: Double = 0
        switch operatorSign {
            case "+":
                result = prevNumber + nextNumber
            case "-":
                result = prevNumber - nextNumber
            case "X":
                result = prevNumber * nextNumber
            case "÷":
                result = prevNumber / nextNumber
            default:
                return
            }
            
            // 정수인지 확인 후 변환
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                totalNumber = String(Int(result))
            } else {
                totalNumber = String(result)
            }
            
        operatorSign = nil
    }
   

    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .foregroundColor(.white)
                        .font(.system(size: 73))
                }
                
                ForEach(buttonData, id : \.self){ line in
                    HStack{
                        ForEach(line, id : \.self){ value in
                            Button {
                                if value.buttonDisplayName == "C"{
                                    totalNumber = "0"
                                    shouldResetTotalNumber = false
                                }
                                else if value == .plus || value == .minus || value == .multiple || value == .divide{
                                    operatorSign = value.buttonDisplayName
                                    prevNumber =  Double(totalNumber) ?? 0
                                    shouldResetTotalNumber = false
                                }
                                else if value.buttonDisplayName == "="{
                                    nextNumber = Double(totalNumber) ?? 0
                                    calculateNumber()
                                    shouldResetTotalNumber = true
                                }
                                else if value == .dot {
                                    if !totalNumber.contains(".") {
                                        totalNumber += "."
                                    }
                                }
                                else if totalNumber == "0" {
                                    totalNumber = value.buttonDisplayName
                                }
                                else {
                                    if operatorSign != nil || shouldResetTotalNumber {
                                        totalNumber = value.buttonDisplayName
                                    }
                                    else {
                                        totalNumber += value.buttonDisplayName
                                    }
                                }
                            } label: {
                                Text(value.buttonDisplayName)
                                    .frame(width: 80, height: 80)
                                    .background(value.buttonBackgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(value.buttonForegroundColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }
                }
               
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
