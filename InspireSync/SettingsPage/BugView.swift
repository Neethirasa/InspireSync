//
//  BugView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-07.
//

import SwiftUI
import Combine

private enum Field: Int, Hashable {
  case yourTextField, yourOtherTextField
}

struct BugView: View {
    @FocusState private var focusedField: Field?
    @State private var suggestion: String = ""
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            //Color.washedBlack.edgesIgnoringSafeArea(.all)
            Color("WashedBlack").edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Enter your Email below")
                    .foregroundColor(.white)
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 18))
                
                TextField("Enter your email", text: $email, axis: .vertical)// <1>, <2>
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.05)
                    .focused($focusedField, equals: .yourOtherTextField)
                     .contentShape(RoundedRectangle(cornerRadius: 5))
                     .onTapGesture { focusedField = .yourOtherTextField }
                    .border(.secondary)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("customTeal"), lineWidth: 3))
                Spacer().frame(height: UIScreen.main.bounds.height * 0.5)
                
                    }
            
            
            VStack{
                Text("Enter your suggestion below")
                    .foregroundColor(.white)
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 18))
                
                TextField("Enter your suggestion", text: $suggestion, axis: .vertical)// <1>, <2>
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
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("customTeal"), lineWidth: 3))
                Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                
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
                    if (!suggestion.isEmpty && !email.isEmpty && !suggestion.trimmingCharacters(in: .whitespaces).isEmpty && !email.trimmingCharacters(in: .whitespaces).isEmpty) {
                        Button(){
                            dismiss()
                            
                        }label: {
                        Text("Send")
                      }
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                        //Spacer().frame(width: UIScreen.main.bounds.width * 0)
                    }
                }
            }
        }
        .background(Color("WashedBlack"))
        .scrollContentBackground(.hidden)
    }
}



#Preview {
    BugView()
}
