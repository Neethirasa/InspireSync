//
//  MenuView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-16.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        ZStack{
            Color.washedBlack.ignoresSafeArea()
            
            HStack{
                
                VStack{
                    Text("Menu")
                        .font(.system(size: 30, weight: .heavy))
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 30))
                        .foregroundStyle(.white)
                    Spacer()
                }
            }
            
            VStack{
                Spacer()
                List {
                    
                    Button("Help"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    
                    Button("About Us"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))

                }
                
            }
            
        }
        .background(.washedBlack)
        .scrollContentBackground(.hidden)
        
    }
}

#Preview {
    MenuView()
}
