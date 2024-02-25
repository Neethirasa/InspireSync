//
//  HomeView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-15.
//

import SwiftUI
import WidgetKit

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
    //@Binding var showSignInView: Bool
    @State private var showingQuote = false
    @AppStorage("myDefaultString") var myString = ""
    @ObservedObject var reloadViewHelper = ReloadViewHelper()
    
    @State private var showSignInView = false
    
    @State private var firstQuote = QuoteManager.shared.getFirstQuote()
    @State private var secondQuote = QuoteManager.shared.getSecondQuote()
    
    var body: some View {
            
        
        ZStack{
                        
            Color.washedBlack.ignoresSafeArea()
            
            HStack{
                
                Spacer().frame(width: 25)
                /*
                VStack(alignment: .leading){
                    
                    NavigationStack{
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
                    Spacer().frame(height: 700)

                }
                */
                
                /*
                HStack(){
                    Spacer()
                        .padding()
                    VStack(alignment: .leading){
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            
                        Spacer().frame(height: 700)
                    }
                    
                    
                }
                 */
                
                /*
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        NavigationStack{
                            Button(action: {
                                settingsView.toggle()
                            }, label: {
                                Image(systemName: "person.crop.circle.dashed")
                                    .font(.system(size: 40))
                                    .foregroundColor(.customTeal)
                            })
                            .sheet(isPresented: $settingsView) {
                                SettingsView()
                            }
                        }
                    }
                    
                    Spacer().frame(height: 700)
                }
                Spacer().frame(width: 25)
                */
                
                
            }
            
            VStack{
                
                Spacer().frame(height: 75)
                
                
                Button(action: {
                    showingQuote.toggle()
                    //reloadViewHelper.reloadView()
                }, label: {
                  Text("+")
                    .frame(width: 300 , height: 150)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                })
                .sheet(isPresented: $showingQuote) {
                    sendQuoteView(firstQuote: $firstQuote, secondQuote: $secondQuote)
                        }
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    myString = firstQuote
                    WidgetCenter.shared.reloadAllTimelines()
                }, label: {
                    Text(firstQuote)
                    .frame(width: 300 , height: 150)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                    
                    
                })
                
                Spacer().frame(height: 40)
                
                Button(action: { 
                    myString = secondQuote
                    WidgetCenter.shared.reloadAllTimelines()
                }, label: {
                    Text(secondQuote)
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

func helpMe (){
    
}

class ReloadViewHelper: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
