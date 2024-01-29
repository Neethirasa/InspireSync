//
//  HomeView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-15.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject{
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func  loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders(){
            authProviders = providers
        }
    }
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
}


struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var settingsView = false
    @State private var menuView = false
    @Binding var showSignInView: Bool
    
    
    var body: some View {
            
        
        ZStack{
            
            Color.washedBlack.ignoresSafeArea()
            
            HStack{
                
                

                VStack(alignment: .leading){
                    NavigationLink(destination: SettingsView(showSignInView: $showSignInView)) {
                        Button(action: {
                            menuView.toggle()
                        }, label: {
                            Image("menuIcon")
                                .font(.system(size: 40))
                                .foregroundColor(.customTeal)
                            
                            
                            
                        })
                        .sheet(isPresented: $menuView) {
                            MenuView()
                        }
                    }
                    Spacer()

                }
                
                
                HStack(){
                    Spacer()
                        .padding()
                    VStack(alignment: .leading){
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            
                        Spacer()
                    }
                }
                
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        NavigationLink(destination: SettingsView(showSignInView: $showSignInView)) {
                            
                        Button(action: {
                            settingsView.toggle()
                            
                                
                            
                        }, label: {
                            Image(systemName: "person.crop.circle.dashed")
                                .font(.system(size: 40))
                                .foregroundColor(.customTeal)
                                

                        })
                        .sheet(isPresented: $settingsView) {
                            SettingsView(showSignInView: $showSignInView)
                        }
                                   
                                   }
                        
                    }
                    
                    Spacer()

                }
                
                Spacer()
                
                
                
            }
            
        }
        
        /*
            HStack{
                

                Spacer()
                .safeAreaInset(edge: VerticalEdge.bottom, content: {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.crop.circle.dashed")
                            .font(.system(size: 50))
                            .foregroundColor(.customTeal)
                            .padding(.leading)

                    })
                })
                .onAppear{
                    viewModel.loadAuthProviders()
                }
                .navigationBarTitle("Homepage")
                     //your view
                            
            }
        */
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(showSignInView: .constant(false))
        }
    }
}
