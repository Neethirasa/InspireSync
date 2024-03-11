//
//  sendQuoteView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-02-19.
//

import SwiftUI
import Combine
import WidgetKit

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

private enum Field: Int, Hashable {
  case yourTextField, yourOtherTextField
}


struct sendQuoteView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var quote: String = ""
    let textLimit = 135 //Your limit
    @AppStorage("myDefaultString") var myString = ""
    
    @Binding var firstQuote: String
    @Binding var secondQuote: String
    
    @FocusState private var isFocused: Bool
    
    @FocusState private var focusedField: Field?
    
    @State var isExpanded = false
    @State private var animationAmount = 1.0
    
    var quotesArray: [String] = ["In the midst of chaos, there is also opportunity.","Success is not final, failure is not fatal: It is the courage to continue that counts.", "The future belongs to those who believe in the beauty of their dreams.", "The only limit to our realization of tomorrow will be our doubts of today.","Believe you can and you're halfway there." ]
    
    
    var body: some View {
        
        
        
        ZStack{
            
            Color.washedBlack.ignoresSafeArea()
        
            VStack {
                VStack {
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                    Button(action: {
                        //print("Expandable button tapped!!!")
                        isExpanded.toggle()
                    }) {
                        HStack{
                            Text("Select Quotes")
                                .font(.custom("Futura-Medium", fixedSize: 16))
                                .foregroundColor(.white)
                            
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.45)
                            
                            Image("arrowDown")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 100).stroke(.customTeal, lineWidth: 5))
                    .cornerRadius(100)
                    
                    if isExpanded {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(0..<quotesArray.count,id: \.self) {
                                    MenuButtons(buttonImage: quotesArray[$0], quote: $quote)
                                }
                            }
                        }
                        .accentColor(Color.white)
                        .frame(height: 175)
                    }
                }
                .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
                
                VStack{
                    Text("Enter your quote below")
                        .foregroundColor(.white)
                        .font(.custom("Futura-Medium", fixedSize: 18))
                    
                    TextField("Enter your quote", text: $quote, axis: .vertical)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.2)
                        .focused($focusedField, equals: .yourTextField)
                        .contentShape(RoundedRectangle(cornerRadius: 5))
                        .onTapGesture { focusedField = .yourTextField }
                        .border(.secondary)
                        .font(.custom("Futura-Medium", fixedSize: 16))
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                        .onReceive(Just($quote)) { _ in limitText(textLimit) }
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.3)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Ensure constant height
                .contentShape(Rectangle())
                .onTapGesture {
                    let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                    keyWindow!.endEditing(true)
                }
                .onLongPressGesture(pressing: { isPressed in if isPressed { self.endEditing() } }, perform: {})
            }
            
            VStack{
                
                Spacer().frame(height: UIScreen.main.bounds.height * 0.7)
                
                HStack{
                    Button(role: .destructive){
                      dismiss()
                    }label: {
                    Text("Cancel")
                  }
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                Spacer().frame(width: UIScreen.main.bounds.width * 0.55)
                }

            }
            
            VStack{
                Spacer().frame(height: UIScreen.main.bounds.height * 0.7)
                HStack{
                    Spacer().frame(width: UIScreen.main.bounds.width * 0.4)
                    if !quote.isEmpty && !quote.trimmingCharacters(in: .whitespaces).isEmpty{
                        Button(){
                            myString = quote
                            WidgetCenter.shared.reloadAllTimelines()
                            
                            QuoteManager.shared.addQuotes(quote:quote)
                            //reloadViewHelper.reloadView()
                            
                            firstQuote = QuoteManager.shared.getFirstQuote()
                            secondQuote = QuoteManager.shared.getSecondQuote()
                            
                            dismiss()
                            
                        }label: {
                        Text("Add to Widget")
                      }
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                        //Spacer().frame(width: UIScreen.main.bounds.width * 0)
                    }
                }
            }
            
            
            
            
            
        }
        
        .background(.washedBlack)
        .scrollContentBackground(.hidden)
   
    }
    
    //Function to keep text length in limits
        func limitText(_ upper: Int) {
            if quote.count > upper {
                quote = String(quote.prefix(upper))
            }
        }
}




#Preview {
    sendQuoteView(firstQuote: .constant("Nive"), secondQuote: .constant("Dhanu"))
}
 

