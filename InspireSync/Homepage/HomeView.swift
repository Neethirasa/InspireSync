//
//  HomeView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-15.
//

import SwiftUI
import WidgetKit
import Combine
/*
@MainActor
final class ProfileViewModel: ObservableObject{
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}
*/
@MainActor
final class HomeViewModel: ObservableObject{
    
    @Published var authProviders: [AuthProviderOption] = []
   // @Published private(set) var user: DBUser? = nil
    

    
    func signOut() throws{
        AuthenticationManager.shared.signOut()
    }
    /*
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
     */
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
    
    @State var presentSideMenu = false
    
    @State var appeared: Double = 0

    private let objectWillChange = PassthroughSubject<Void, Never>()
    
    @State private var counter = 0
    @State private var isTimerActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var homeUsername = " "
    @State private var animationAmount = 1.0
    
    var body: some View {
        
            
        ZStack {
            Color.washedBlack.edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.3), lineWidth: 2) // Semi-transparent stroke
                    .blur(radius: 4) // Blur effect
                    .offset(x: -2, y: -2) // Offset to create the glass effect
                    .mask(RoundedRectangle(cornerRadius: 10)) // Mask to limit blur effect
            
            VStack {
                
                Spacer().frame(height: UIScreen.main.bounds.height * 0.08)
                
                Button(action: {
                    showingQuote.toggle()
                    //reloadViewHelper.reloadView()
                }, label: {
                  Text("+")
                        .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.10)
                        .font(.custom(
                                "Futura-Medium",
                                fixedSize: 60))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                })/*
                .task {
                    try? await viewModel.loadCurrentUser()
                }*/
                .fullScreenCover(isPresented: $showingQuote, content: {
                    NavigationStack{
                        sendQuoteView(firstQuote: $firstQuote, secondQuote: $secondQuote)
                    }
                })
                
                Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                
                Button(action: {
                    myString = firstQuote
                    WidgetCenter.shared.reloadAllTimelines()
                }, label: {
                    Text(firstQuote)
                    .minimumScaleFactor(0.5)
                    .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.18)
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 18))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .lineLimit(4)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                    
                    
                })
                
                Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                
                Button(action: {
                    myString = secondQuote
                    WidgetCenter.shared.reloadAllTimelines()
                }, label: {
                    Text(secondQuote)
                    .minimumScaleFactor(0.5)
                    .frame(width: UIScreen.main.bounds.width * 0.76 , height: UIScreen.main.bounds.height * 0.18)
                    .font(.custom(
                            "Futura-Medium",
                            fixedSize: 18))
                    .foregroundColor(.white)
                    .cornerRadius(.infinity)
                    .lineLimit(4)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.customTeal, lineWidth: 5))
                })
                
                
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    VStack{
                        Spacer().frame(height: UIScreen.main.bounds.height * 0.05)
                        HStack {
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.25)

                                Button {
                                    presentSideMenu.toggle()
                                } label: {
                                    Image("menuIcon")
                                        .aspectRatio(contentMode: .fit)
                                        .font(.system(size: 10))
                                        .foregroundColor(.customTeal)
                                }
                                .padding()
                            HStack(alignment: .center){
                                Text("Welcome " + homeUsername)
                                    .font(.custom(
                                            "Futura-Medium",
                                            size: 25))
                                    .foregroundStyle(Color.white)
                                    .minimumScaleFactor(0.5)
                                    .frame(width:200, height: 80)
                                    .lineLimit(1)
                            .onReceive(timer) { _ in
                                        // Update the counter every second
                                        counter += 1
                                self.homeUsername = AuthenticationManager.shared.getDisplayName()
                                
                                if (!self.homeUsername.isEmpty && counter >= 10){
                                    isTimerActive = false
                                    timer.upstream.connect().cancel()
                                }
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                                .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
      
                            
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
                                .padding()
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.25)

                        }
                    }
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.washedBlack)
                    .zIndex(1)
                    .shadow(radius: 0.3)
                , alignment: .top)
            .background(Color.washedBlack.opacity(0.8))
            
            SideMenu()
        }
        
        .frame(maxWidth: .infinity)
        
    }
    
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideView(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuViewContents(presentSideMenu: $presentSideMenu)
                .frame(width: UIScreen.main.bounds.width * 0.5)
        }
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
                .previewDevice("iphone 13")
        }
        
    }
}
