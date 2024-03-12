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
    @State private var showSignInView = false
    
    @StateObject private var viewModel = SettingsViewModel()
    
    
    var body: some View {
        ZStack {
            Color.washedBlack.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer().frame(height: UIScreen.main.bounds.height * 0.055)
                List {
                    
                    HStack{
                        Text("InspireSync")
                            .font(.custom(
                                "Futura-Medium",
                                fixedSize: 20))
                            .foregroundColor(.white)

                    }
                    .listRowBackground(Color.washedBlack)
                    
                    
                    VStack(alignment: .leading, spacing: 0){
                    }
                    .listRowBackground(Color.washedBlack)
                    .frame(height: UIScreen.main.bounds.height * 0.002)
                    .frame(width: UIScreen.main.bounds.width * 10)
                   // .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#696969"))
                    /*
                    Button("Friends"){
                        
                    }.listRowBackground(Color.washedBlack)
                        .font(.custom(
                            "Futura-Medium",
                            fixedSize: 20))
                        .foregroundColor(.white)
                    */
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.55)
                        .listRowBackground(Color.washedBlack)
                    
                    VStack(alignment: .leading, spacing: 0){
                    }
                    .listRowBackground(Color.washedBlack)
                    .frame(height: UIScreen.main.bounds.height * 0.002)
                    .frame(width: UIScreen.main.bounds.width * 10)
                    .background(Color(hex: "#696969"))
                    
                    NavigationStack{
                        Button(action: {
                            settingsView.toggle()
                        }, label: {
                            Text("Settings")
                                .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                                .foregroundColor(.white)
                        })
                        .fullScreenCover(isPresented: $settingsView, content: {
                            NavigationStack{
                                SettingsScreen()
                            }
                        })
                    }
                    .listRowBackground(Color.washedBlack)
                    
                    
                    VStack{
                        Button(role: .destructive){
                            Task{
                                do{
                                    //settingsView.toggle()
                                    showSignInView = true
                                    try viewModel.signOut()
                                    
                                    // Present the RootView
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                        let window = windowScene.windows.first {
                                                    window.rootViewController = UIHostingController(rootView: RootView())
                                                }
                                    
                                    
                                }catch{
                                    print(error)
                                }
                            }
                        }label: {
                            Text("Log Out")
                                .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 20))
                        }
                        
                    }
                    .listRowBackground(Color.washedBlack)
                    
                }
             
                
                
            }
            .scrollDisabled(true)
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

struct SideMenuViewContents_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
