//
//  TempHomeView.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-03-25.
//

import SwiftUI
import WidgetKit
import Combine
import BackgroundTasks

@MainActor
final class TempHomeViewModel: ObservableObject {
    @Published var authProviders: [AuthProviderOption] = []
    // @Published private(set) var user: DBUser? = nil

    func signOut() throws {
        AuthenticationManager.shared.signOut()
    }
}

struct TempHomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingQuote = false
    @AppStorage("myDefaultString") var myString = ""
    @State private var firstQuote = QuoteManager.shared.getFirstQuote()
    @State private var secondQuote = QuoteManager.shared.getSecondQuote()
    @State private var thirdQuote = QuoteManager.shared.getThirdQuote()
    @State private var presentSideMenu = false
    @State private var showingAlert = false
    @State private var homeUsername = " "
    @State private var isTimerActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.washedBlack.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack {
                    addContent
                        .overlay(topBar, alignment: .top)
                    
                    mainContent
                    .background(Color.washedBlack.opacity(0.8))
                }
                .fullScreenCover(isPresented: $showingQuote, content: {
                    NavigationStack{
                        sendQuoteView(firstQuote: $firstQuote, secondQuote: $secondQuote)
                    }
                })
            }
            
            
            

            SideMenu()
        }
    }

    private var mainContent: some View {
        VStack(spacing: 20) {
            quoteButton(firstQuote, quote: $firstQuote)
                .padding(.vertical,5)
            quoteButton(secondQuote, quote: $secondQuote)
                .padding(.vertical,5)
            quoteButton(thirdQuote, quote: $thirdQuote)
                .padding(.vertical,5)
        }
        .padding(.horizontal,20)
    }
    
    private var addContent: some View {
        VStack(spacing: 0) {
            addButton("+", quote: $firstQuote)
                .padding(.vertical,20)
        }
        .padding(.horizontal,20)
        .padding(.top, 60)

    }

    private func addButton(_ add: String, quote: Binding<String>) -> some View {
        Button(action: {
            myString = quote.wrappedValue
            WidgetCenter.shared.reloadAllTimelines()
            showingQuote.toggle()
        }) {
            Text(add)
                .frame(maxWidth: .infinity, minHeight: 125)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.customTeal, lineWidth: 5))
                .font(.custom("Futura-Medium", size: add == "+" ? 60 : 18))
                .foregroundColor(.white)
                .lineLimit(4)
        }
        
    }
    
    private func quoteButton(_ title: String, quote: Binding<String>) -> some View {
        Button(action: {
            myString = quote.wrappedValue
            WidgetCenter.shared.reloadAllTimelines()
            showingAlert = true
        }) {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 200)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.customTeal, lineWidth: 5))
                .font(.custom("Futura-Medium", size: title == "+" ? 60 : 18))
                .foregroundColor(.white)
                .lineLimit(4)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Widget Updated"), dismissButton: .default(Text("OK")))
        }
    }

    private var topBar: some View {
        HStack {
            Button(action: { presentSideMenu.toggle() }) {
                Image("menuIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .padding()

            Spacer()

            Text("Welcome \(homeUsername)")
                .font(.custom("Futura-Medium", size: 25))
                .foregroundColor(.white)
                .onReceive(timer) { _ in
                    
                    self.homeUsername = AuthenticationManager.shared.getDisplayName()
                }

            Spacer()

            Button(action: { /* navigate to settings or profile */ }) {
                Image("profilepic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 60)
        .background(Color.washedBlack)
    }

    @ViewBuilder
    private func SideMenu() -> some View {
        SideView(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuViewContents(presentSideMenu: $presentSideMenu)
                .frame(width: 250)
        }
    }
}

struct TempHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TempHomeView().previewDevice("iPhone 13")
        }
    }
}


#Preview {
    TempHomeView()
}
