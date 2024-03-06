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

    
    var body: some View {
        
        
        ZStack{
            
            Color.washedBlack.ignoresSafeArea()
            
            
            VStack {
                    TextField("Enter your quote", text: $quote, axis: .vertical) // <1>, <2>
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.2)
                    .focused($focusedField, equals: .yourTextField)
                     .contentShape(RoundedRectangle(cornerRadius: 5))
                     .onTapGesture { focusedField = .yourTextField }
                    .border(.secondary)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                    .onReceive(Just($quote)) { _ in limitText(textLimit) }
                Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
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
                    Spacer().frame(width: UIScreen.main.bounds.width * 0.3)
                    
                    
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
                    Spacer().frame(width: UIScreen.main.bounds.width * 0)
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
 

