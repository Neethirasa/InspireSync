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

struct sendQuoteView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var quote: String = ""
    let textLimit = 135 //Your limit
    @AppStorage("myDefaultString") var myString = ""
    
    @Binding var firstQuote: String
    @Binding var secondQuote: String
    
    
    
    
    var body: some View {
        
        
        ZStack{
            
            Color.washedBlack.ignoresSafeArea()
            
            
            VStack {
                    TextField("Enter your quote", text: $quote, axis: .vertical) // <1>, <2>
                    .lineLimit(4)
                    .padding()
                    .frame(width: 300 , height: 150)
                    .border(.secondary)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                    .onReceive(Just($quote)) { _ in limitText(textLimit) }
                
                Spacer().frame(height: 250)
                    }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .contentShape(Rectangle())
                   .onTapGesture {let keyWindow = UIApplication.shared.connectedScenes
                       .filter({$0.activationState == .foregroundActive})
                       .map({$0 as? UIWindowScene})
                       .compactMap({$0})
                       .first?.windows
                       .filter({$0.isKeyWindow}).first
                       keyWindow!.endEditing(true)
                   }
                   .onLongPressGesture(
                       pressing: { isPressed in if isPressed { self.endEditing() } },
                       perform: {})
            
            
            VStack{
                
                Spacer().frame(height: 650)
                
                HStack{
                    Button(role: .destructive){
                      dismiss()
                    }label: {
                    Text("Cancel")
                  }
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                    Spacer().frame(width: 190)
                    
                    
                    Button(){
                        myString = quote
                        WidgetCenter.shared.reloadAllTimelines()
                        
                        QuoteManager.shared.addQuotes(quote:quote)
                        //reloadViewHelper.reloadView()
                        
                        firstQuote = QuoteManager.shared.getFirstQuote()
                        secondQuote = QuoteManager.shared.getSecondQuote()
                        
                        
                        
                    }label: {
                    Text("Send")
                  }
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                    Spacer().frame(width: 0)
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



/*
#Preview {
    sendQuoteView()
}
*/
