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
                    Text("Create your Username")
                        .foregroundStyle(.white)
                        .font(.system(size: 25, weight: .heavy))
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 30))
                        .padding()
                }
                
                VStack{
                    TextField("Enter your username", text: $username) // <1>, <2>
                    .frame(width: 200 , height: 40)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                    .onReceive(Just($username)) { _ in limitText(textLimit)
                }
                    
                }
                
                Spacer().frame(height: 30)
                VStack{
                    Button(){
                        if !username.isEmpty{
                            nullUsername = false
                        }
                        NavigationStack{
                            //SettingsView(showSignInView: $showSignInView)
                            HomeView(showSignInView: $showSignInView)
                        }
                        
                    }label: {
                    Text("Submit")
                  }
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
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
