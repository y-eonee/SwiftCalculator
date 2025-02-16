//
//  ContentView.swift
//  Calculator
//
//  Created by 이나연 on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    
    enum ButtonType : String{
        case one, two, three, four, five, six, seven, eight, nine, zero
        case plus, minus, multiple, divide, equal, dot
        case clear, slash, percent
        
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
                case .divide : return "/"
                case .equal : return "="
                case .dot : return "."
                case .clear : return ""
                case .slash : return "/"
                case .percent : return "%"
            }
        }
        
        var buttonBackgroundColor : Color{
            switch self{
                case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot : return Color("NumberButton")
                case .clear, .slash, .percent : return Color.gray
                case .plus, .minus, .multiple, .divide, .equal : return Color.orange
            }
        }
        
        var buttonForegroundColor : Color{
            switch self{
                case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot, .plus, .minus, .multiple, .divide, .equal  : return Color.white
                case .clear, .slash, .percent : return Color.black
            }
        }
    }
    
    
    private let buttonData: [[ButtonType]] = [
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .zero, .dot, .equal]
    ]
    
   

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
                HStack{
                    Button {
                        totalNumber = "0"
                    } label: {
                        Text("C")
                            .frame(width: 80, height: 80)
                            .background(.gray)
                            .cornerRadius(40)
                            .foregroundColor(Color("NumberButton"))
                            .font(.system(size: 33))
                    }

                    Button {
                        
                    } label: {
                        Text("/")
                            .frame(width: 80, height: 80)
                            .background(.gray)
                            .cornerRadius(40)
                            .foregroundColor(Color("NumberButton"))
                            .font(.system(size: 33))
                    }

                    
                    Button {
                        
                    } label: {
                        Text("%")
                            .frame(width: 80, height: 80)
                            .background(.gray)
                            .cornerRadius(40)
                            .foregroundColor(Color("NumberButton"))
                            .font(.system(size: 33))
                    }
                    Button {
                        
                    } label: {
                        Text("÷")
                            .frame(width: 80, height: 80)
                            .background(.orange)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .font(.system(size: 33))
                    }
                }
                
                ForEach(buttonData, id : \.self){ line in
                    HStack{
                        ForEach(line, id : \.self){ value in
                            Button {
                                if totalNumber == "0"{
                                    totalNumber = value.buttonDisplayName
                                }
                                else {
                                    totalNumber += value.buttonDisplayName
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
