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
                
                Spacer().frame(width: 25)
                
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
                    Spacer().frame(height: 675)

                }
                
                
                HStack(){
                    Spacer()
                        .padding()
                    VStack(alignment: .leading){
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            
                        Spacer().frame(height: 675)
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
                    
                    Spacer().frame(height: 675)
                }
                Spacer().frame(width: 25)
                
                
            }
            
            VStack{
                
                Spacer().frame(height: 75)
                Button(action: { }, label: {
                  Text("+")
                    .frame(width: 300 , height: 150)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                })
                
                Spacer().frame(height: 40)
                
                Button(action: { }, label: {
                  Text("In the end, we will remember not the words of our enemies, but the silence of our friends. - Martin Luther King Jr.")
                    .frame(width: 300 , height: 150)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                })
                
                Spacer().frame(height: 40)
                
                Button(action: { }, label: {
                  Text("The only way to do great work is to love what you do. - Steve Jobs")
                    .frame(width: 300 , height: 150)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                })
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
