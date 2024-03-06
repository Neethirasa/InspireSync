//
//  ProfileView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-15.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @State private var username: String = ""
    @Binding var nullUsername: Bool
    @State private var showSignInView: Bool = false
    
    let textLimit = 10 //Your limit
    var body: some View {
        ZStack{
            Color.washedBlack.ignoresSafeArea()
            VStack{
                VStack{
                    Text("Create an Account")
                        .foregroundStyle(.white)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 40))
                        .padding()
                }
                Spacer().frame(height:UIScreen.main.bounds.height * 0.05)
                
                VStack{
                    HStack{
                        Text("Username")
                            .foregroundStyle(.white)
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                        Spacer().frame(width: UIScreen.main.bounds.width * 0.45)
                    }
                    
                    TextField("Enter your username", text: $username) // <1>, <2>
                    .frame(width: UIScreen.main.bounds.width * 0.6 , height: UIScreen.main.bounds.height * 0.02)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2))
                    .onReceive(Just($username)) { _ in limitText(textLimit)
                    
                    AuthenticationManager.shared.updateDisplayName(displayName: username)
                }
                    
                }
                
                Spacer().frame(height: 30)
                VStack{
                    Button(){
                        if !username.isEmpty{
                            nullUsername = false
                        }
                        
                    }label: {
                    Text("Create Account")
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                            .foregroundColor(.white)
                            .padding()
                  }
                    .background(.customTeal)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 2))
                    .cornerRadius(10)
                }
                
            }
            
            
        }
        .background(.washedBlack)
        .scrollContentBackground(.hidden)
    
    }
    
    //Function to keep text length in limits
        func limitText(_ upper: Int) {
            if username.count > upper {
                username = String(username.prefix(upper))
            }
        }
}

#Preview {
    ProfileView(nullUsername: .constant(false))
}
