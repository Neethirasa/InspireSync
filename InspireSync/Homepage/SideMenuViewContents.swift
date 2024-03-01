//
//  SideMenuViewContents.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-02-26.
//

import SwiftUI



struct SideMenuViewContents: View {
    @Binding var presentSideMenu: Bool
    @State private var settingsView = false
    
    var body: some View {
        ZStack {
            Color.washedBlack.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer().frame(height: 50)
                List {
                    
                    Text("InspireSync")
                        .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                    
                    Button("Friends"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                    
                    Spacer().frame(height: 520)
                        .listRowBackground(Color.washedBlack)
                    
                    NavigationStack{
                        Button(action: {
                            settingsView.toggle()
                        }, label: {
                            Text("Settings")
                                .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                        })
                        .sheet(isPresented: $settingsView) {
                            SettingsView()
                        }
                    }
                    .listRowBackground(Color.washedBlack)
                    
                    
                    Button(role: .destructive){
                        
                    }label: {
                        Text("Log Out")
                            .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                    }
                    .listRowBackground(Color.washedBlack)
                    
                }
                
            }
            .frame(maxWidth: .infinity)
            .background(Color.washedBlack)
            .scrollContentBackground(.hidden)
        }
    }
    
    func SideMenuTopView() -> some View {
        VStack {
            /*
            HStack {
                Button(action: {
                    presentSideMenu.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                })
                .frame(width: 34, height: 34)
                Spacer()
            }
            */
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 40)
        .padding(.top, 40)
        .padding(.bottom, 30)
    }
}