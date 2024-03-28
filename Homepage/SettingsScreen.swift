// Install URLImage: https://github.com/dmytro-anokhin/url-image
import MessageUI
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct SettingsScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var settingsView = false
    @State private var showSignInView = false
    @State private var showDeleteView = false
    
    @StateObject private var viewModel = SettingsViewModel()
    @State private var deleteUserView = false
    let authUsername = AuthenticationManager.shared.getDisplayName()
    
    @State var isShowingBugView = false
    @State var isShowingPrivacyView = false
    @State var isShowingTermsService = false
    @State var isCustomWidget = false
    
    
    @State private var navigationActive = false // Track the activation state
    
    
    private func presentingViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            // Get the window scene
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                return nil
            }
            return rootViewController
        } else {
            // Fallback for older iOS versions
            guard let window = UIApplication.shared.keyWindow,
                  let rootViewController = window.rootViewController else {
                return nil
            }
            return rootViewController
        }
    }

    
    var body: some View {
        
        if getDeviceType() == .iPad {
            VStack(alignment: .leading, spacing: 0){
                ScrollView(){
                    VStack(alignment: .leading, spacing: 0) {
                        Group{
                            HStack(spacing: 0){
                                
                            }
                            .navigationBarBackButtonHidden(true)
                            .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                Button {
                                                    //print("Settings")
                                                    // 2
                                                    dismiss()

                                                } label: {
                                                    HStack {
                                                        Image(systemName: "chevron.backward")
                                                            .foregroundColor(.white)
                                                        Text("Settings")
                                                            .foregroundColor(.white)
                                                            .font(.custom(
                                                                    "Futura-Medium",
                                                                    fixedSize: 20))
                                                    }
                                                }
                                            }
                                        }
                            
                            Spacer().frame(height: UIScreen.main.bounds.height * 0.08)
                            
                            
                            HStack(spacing: 0){
                                
                                Text("My Account")
                                .foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 16))
                                //.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.55)
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.01)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom,11)
                            .padding(.horizontal,5)
                            
                            VStack {
                                Spacer() // Push everything to the middle

                                HStack {
                                    Spacer().frame(width: UIScreen.main.bounds.width * 0.15) // Center horizontally
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            Text("Username")
                                                .foregroundColor(Color(hex: "#FFFFFF"))
                                                .font(.custom("Futura-Medium", fixedSize: 14))
                                            Spacer() // Push the text to the left and the username to the right
                                            Text(authUsername) //take quotes off
                                                .foregroundColor(Color.gray)
                                                .font(.custom("Futura-Medium", fixedSize: 14))
                                                .italic()
                                        }
                                        .padding(.bottom, 3)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                    .frame(height: UIScreen.main.bounds.height * 0.035)
                                    .frame(width: UIScreen.main.bounds.width * 0.6, alignment: .leading) // Smaller width
                                    .background(Color(hex: "#333333"))
                                    .cornerRadius(5)

                                    Spacer() // Center horizontally
                                }

                                Spacer() // Push everything to the middle
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("WashedBlack")) // Or any other background color for the outer view
                            .padding()

                            HStack(spacing: 0){
                                Image(systemName: "paintpalette")
                                    .foregroundColor(.white)
                                    
                                Text(" Customize")
                                .foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 16))
                                //.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.535)
                            }
                            .frame(height: 18)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom,11)
                            .padding(.horizontal,5)
                        }
                        Group{
                            VStack {
                                Spacer() // Push everything to the middle

                                HStack {
                                    Spacer().frame(width: UIScreen.main.bounds.width * 0.15) // Center horizontally
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            NavigationStack {
                                                Button(action: {
                                                    isCustomWidget.toggle()
                                                }, label: {
                                                    HStack {
                                                        Text("Customize your Widget")
                                                            .foregroundColor(Color(hex: "#FFFFFF"))
                                                            .font(.custom("Futura-Medium", fixedSize: 14))
                                                        Spacer() // Push the text to the left and the username to the right
                                                        Image("arrow")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 25, height: 25)
                                                            .contrast(15)
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                .sheet(isPresented: $isCustomWidget) {
                                                    WidgetCustom()
                                                }
                                            }
                        
                                        }
                                        .padding(.bottom, 3)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                    .frame(height: UIScreen.main.bounds.height * 0.035)
                                    .frame(width: UIScreen.main.bounds.width * 0.6, alignment: .leading) // Smaller width
                                    .background(Color(hex: "#333333"))
                                    .cornerRadius(5)

                                    Spacer() // Center horizontally
                                }

                                Spacer() // Push everything to the middle
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("WashedBlack")) // Or any other background color for the outer view
                            .padding()
                            
                            HStack(spacing: 0){
                                Image("sendfeedback")
                                    
                                Text("Send Feedback")
                                .foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 16))
                                //.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.49)
                            }
                            .frame(height: 18)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom,11)
                            .padding(.horizontal,5)
                        }
                        Group{
                            
                            VStack {
                                Spacer() // Push everything to the middle

                                HStack {
                                    Spacer().frame(width: UIScreen.main.bounds.width * 0.15) // Center horizontally
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            
                                            NavigationStack {
                                                Button(action: {
                                                    isShowingBugView.toggle()
                                                }, label: {
                                                    HStack {
                                                        Text("I spotted a bug")
                                                            .foregroundColor(Color(hex: "#FFFFFF"))
                                                            .font(.custom("Futura-Medium", fixedSize: 14))
                                                        Spacer() // Push the text to the left and the username to the right
                                                        Image("arrow")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 25, height: 25)
                                                            .contrast(15)
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                .sheet(isPresented: $isShowingBugView) {
                                                    BugView()
                                                }
                                            }
                        
                                        }
                                        .padding(.bottom, 3)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                    .frame(height: UIScreen.main.bounds.height * 0.035)
                                    .frame(width: UIScreen.main.bounds.width * 0.6, alignment: .leading) // Smaller width
                                    .background(Color(hex: "#333333"))
                                    .cornerRadius(5)

                                    Spacer() // Center horizontally
                                }

                                Spacer() // Push everything to the middle
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("WashedBlack")) // Or any other background color for the outer view
                            .padding()
                            //end
                            VStack {
                                Spacer() // Push everything to the middle

                                HStack {
                                    Spacer().frame(width: UIScreen.main.bounds.width * 0.15) // Center horizontally
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 0) {
                                            
                                            NavigationStack {
                                                Button(action: {
                                                    isShowingBugView.toggle()
                                                }, label: {
                                                    HStack {
                                                        Text("I have a Suggestion")
                                                            .foregroundColor(Color(hex: "#FFFFFF"))
                                                            .font(.custom("Futura-Medium", fixedSize: 14))
                                                        Spacer() // Push the text to the left and the username to the right
                                                        Image("arrow")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 25, height: 25)
                                                            .contrast(15)
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                .sheet(isPresented: $isShowingBugView) {
                                                    BugView()
                                                }
                                            }
                        
                                        }
                                        .padding(.bottom, 3)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                    .frame(height: UIScreen.main.bounds.height * 0.035)
                                    .frame(width: UIScreen.main.bounds.width * 0.6, alignment: .leading) // Smaller width
                                    .background(Color(hex: "#333333"))
                                    .cornerRadius(5)

                                    Spacer() // Center horizontally
                                }

                                Spacer() // Push everything to the middle
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("WashedBlack")) // Or any other background color for the outer view
                            .padding()

                            HStack(spacing: 0){
                                Image("help")
                                
                                
                                Text("Help")
                                .foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 16))
                                //.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.59)
                                
                                
                            }
                            .frame(height: 18)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom,11)
                            .padding(.horizontal,5)
            
                        }
                        
                        VStack {
                            Spacer() // Push everything to the middle

                            HStack {
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.15) // Center horizontally
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack(spacing: 0) {
                                        
                                        NavigationStack {
                                            Button(action: {
                                                isShowingPrivacyView.toggle()
                                            }, label: {
                                                HStack {
                                                    Text("Privacy Policy")
                                                        .foregroundColor(Color(hex: "#FFFFFF"))
                                                        .font(.custom("Futura-Medium", fixedSize: 14))
                                                    Spacer() // Push the text to the left and the username to the right
                                                    Image("arrow")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 25, height: 25)
                                                        .contrast(15)
                                                    
                                                }
                                                
                                                
                                            })
                                            .sheet(isPresented: $isShowingPrivacyView) {
                                                PrivacyView(url: URL(string: "https://docs.google.com/document/d/e/2PACX-1vQCfVq7kFa2DR49OehK2p44ZXCaB2VSwJHqiiBVMoveY3eEm_yPB512pJHC4iONCd01f33O-g_-HiaD/pub")!)

                                            }
                                        }
                    
                                    }
                                    .padding(.bottom, 3)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 5)
                                .frame(height: UIScreen.main.bounds.height * 0.035)
                                .frame(width: UIScreen.main.bounds.width * 0.6, alignment: .leading) // Smaller width
                                .background(Color(hex: "#333333"))
                                .cornerRadius(5)

                                Spacer() // Center horizontally
                            }

                            Spacer() // Push everything to the middle
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("WashedBlack")) // Or any other background color for the outer view
                        .padding()
                        
                        VStack {
                            Spacer() // Push everything to the middle

                            HStack {
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.15) // Center horizontally
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack(spacing: 0) {
                                        
                                        NavigationStack {
                                            Button(action: {
                                                isShowingTermsService.toggle()
                                            }, label: {
                                                HStack {
                                                    Text("Terms of Service")
                                                        .foregroundColor(Color(hex: "#FFFFFF"))
                                                        .font(.custom("Futura-Medium", fixedSize: 14))
                                                    Spacer() // Push the text to the left and the username to the right
                                                    Image("arrow")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 25, height: 25)
                                                        .contrast(15)
                                                    
                                                }
                                                
                                                
                                            })
                                            .sheet(isPresented: $isShowingTermsService) {
                                                TermsServiceView(url: URL(string: "https://docs.google.com/document/d/e/2PACX-1vQCfVq7kFa2DR49OehK2p44ZXCaB2VSwJHqiiBVMoveY3eEm_yPB512pJHC4iONCd01f33O-g_-HiaD/pub")!)

                                            }
                                        }
                    
                                    }
                                    .padding(.bottom, 3)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 5)
                                .frame(height: UIScreen.main.bounds.height * 0.035)
                                .frame(width: UIScreen.main.bounds.width * 0.6, alignment: .leading) // Smaller width
                                .background(Color(hex: "#333333"))
                                .cornerRadius(5)

                                Spacer() // Center horizontally
                            }

                            Spacer() // Push everything to the middle
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("WashedBlack")) // Or any other background color for the outer view
                        .padding()
          
                        Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
                                .listRowBackground(Color.washedBlack)
                            
                        
                        HStack(spacing: 0){
                            
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.4)
                   
                            NavigationStack {
                                Button(role: .destructive) {
                                    Task {
                                        // This block doesn't throw any errors
                                        showDeleteView.toggle()
                                    }
                                } label: {
                                    Text("Delete Account")
                                        .font(.custom("Futura-Medium", fixedSize: 18))
                                }
                            }
                            .fullScreenCover(isPresented: $showDeleteView) {
                                NavigationStack {
                                    DeleteUserView(showDeleteView: $showDeleteView)
                                }
                            }

                            
                            
                        }
                        
                    }
                    .padding(.top,19)
                    //.padding(.bottom,596)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(Color(hex: "#212121"))
                
                
            }
            .padding(.top,0.1)
            .padding(.bottom,0.1)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color(hex: "#FFFFFF"))
                   } else if getDeviceType() == .iPhone {
                       
                       VStack(alignment: .leading, spacing: 0){
                           ScrollView(){
                               VStack(alignment: .leading, spacing: 0) {
                                   Group{
                                       HStack(spacing: 0){
                                           
                                       }
                                       .navigationBarBackButtonHidden(true)
                                       .toolbar {
                                                       ToolbarItem(placement: .navigationBarLeading) {
                                                           Button {
                                                               //print("Settings")
                                                               // 2
                                                               dismiss()

                                                           } label: {
                                                               HStack {
                                                                   Image(systemName: "chevron.backward")
                                                                       .foregroundColor(.white)
                                                                   Text("Settings")
                                                                       .foregroundColor(.white)
                                                                       .font(.custom(
                                                                               "Futura-Medium",
                                                                               fixedSize: 20))
                                                               }
                                                           }
                                                       }
                                                   }
                                       
                                       Spacer().frame(height: UIScreen.main.bounds.height * 0.08)
                                       
                                       
                                       HStack(spacing: 0){
                                           
                                           Text("My Account")
                                           .foregroundColor(Color(hex: "#FFFFFF"))
                                           .font(.custom(
                                                   "Futura-Medium",
                                                   fixedSize: 16))
                                           //.frame(maxWidth: .infinity)
                                           Spacer().frame(width: UIScreen.main.bounds.width * 0.57)
                                       }
                                       .frame(height: UIScreen.main.bounds.height * 0.01)
                                       .frame(maxWidth: .infinity)
                                       .padding(.bottom,11)
                                       .padding(.horizontal,5)
                                       
                                       VStack(alignment: .leading, spacing: 0){
                                           
                                           
                                           HStack(spacing: 0){
                                               Text("Username")
                                               .foregroundColor(Color(hex: "#FFFFFF"))
                                               .font(.custom(
                                                       "Futura-Medium",
                                                       fixedSize: 14))
                                               .frame(width: UIScreen.main.bounds.width * 0.80,alignment: .leading)
                                               //Spacer().frame(width: UIScreen.main.bounds.width * 0.51)
                                               .overlay(alignment: .trailing) {
                                                   Text(authUsername)//take quotes off
                                                       .foregroundColor(Color.gray)
                                                       .font(.custom("Futura-Medium",fixedSize: 14))
                                                       .italic()
                                                   }
                                               
                       
                                           }
                                           .padding(.bottom,3)
                                           
                                       }
                                       .padding(.vertical,10)
                                       .padding(.horizontal,5)
                                       .frame(height: UIScreen.main.bounds.height * 0.035)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .background(Color(hex: "#333333"))
                                       .cornerRadius(5)
                                       .padding(.bottom,44)
                                       .padding(.horizontal,UIScreen.main.bounds.width * 0.1)
                                       
                                       HStack(spacing: 0){
                                           Image(systemName: "paintpalette")
                                               .foregroundColor(.white)
                                               
                                           Text(" Customize")
                                           .foregroundColor(Color(hex: "#FFFFFF"))
                                           .font(.custom(
                                                   "Futura-Medium",
                                                   fixedSize: 16))
                                           //.frame(maxWidth: .infinity)
                                           Spacer().frame(width: UIScreen.main.bounds.width * 0.535)
                                       }
                                       .frame(height: 18)
                                       .frame(maxWidth: .infinity)
                                       .padding(.bottom,11)
                                       .padding(.horizontal,5)
                                   }
                                   Group{
                                       VStack(alignment: .leading, spacing: 0){
                                           HStack(spacing: 0){
                                               
                                               NavigationStack{
                                                   Button(action: {
                                                       isCustomWidget.toggle()
                                                   }, label: {
                                                       Text("Customize your Widget")
                                                       .foregroundColor(Color(hex: "#FFFFFF"))
                                                       .font(.custom(
                                                               "Futura-Medium",
                                                               fixedSize: 14))
                                                       .frame(width: UIScreen.main.bounds.width * 0.71,alignment: .leading)
                                                       //.padding(.trailing,4)
                                                       //Spacer().frame(width: UIScreen.main.bounds.width * 0.3439)
                                                       Image("arrow")
                                                           .resizable()
                                                           .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
                                                           .contrast(15)
                                                   })
                                                   .sheet(isPresented: $isCustomWidget ) {
                                                       WidgetCustom()
                                                           }
                                                   
                                               }
                                           }
                                           .frame(height: 15)
                                           .frame(maxWidth: .infinity)
                                       }
                                       
                                       .padding(.vertical,7)
                                       .padding(.horizontal,5)
                                       .frame(height: UIScreen.main.bounds.height * 0.035)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .background(Color(hex: "#333333"))
                                       .cornerRadius(5)
                                       .padding(.bottom,44)
                                       .padding(.horizontal,UIScreen.main.bounds.width * 0.1)
                                       
                                       HStack(spacing: 0){
                                           Image("sendfeedback")
                                               
                                           Text("Send Feedback")
                                           .foregroundColor(Color(hex: "#FFFFFF"))
                                           .font(.custom(
                                                   "Futura-Medium",
                                                   fixedSize: 16))
                                           //.frame(maxWidth: .infinity)
                                           Spacer().frame(width: UIScreen.main.bounds.width * 0.46)
                                       }
                                       .frame(height: 18)
                                       .frame(maxWidth: .infinity)
                                       .padding(.bottom,11)
                                       .padding(.horizontal,5)
                                   }
                                   Group{
                                       VStack(alignment: .leading, spacing: 0){
                                           HStack(spacing: 0){
                                               
                                               
                                               NavigationStack{
                                                   Button(action: {
                                                       isShowingBugView.toggle()
                                                   }, label: {
                                                       Text("I spotted a bug")
                                                       .foregroundColor(Color(hex: "#FFFFFF"))
                                                       .font(.custom(
                                                               "Futura-Medium",
                                                               fixedSize: 14))
                                                    .frame(width: UIScreen.main.bounds.width * 0.71,alignment: .leading)
                                                      // Spacer().frame(width: UIScreen.main.bounds.width * 0.47)
                                                       Image("arrow")
                                                           .resizable()
                                                           .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
                                                           .contrast(15)
                                                           
                                                   })
                                                   .sheet(isPresented: $isShowingBugView ) {
                                                       BugView()
                                                           }
                                                   
                                               }
                                       
                                           }
                                           .frame(height: 14)
                                           .frame(maxWidth: .infinity)
                                           .padding(.bottom,9)
                                           VStack(alignment: .leading, spacing: 0){
                                           }
                                           .frame(height: UIScreen.main.bounds.height * 0.001)
                                           .frame(maxWidth: .infinity, alignment: .leading)
                                           .background(Color(hex: "#696969"))
                                           .padding(.bottom,6)
                                           HStack(spacing: 0){
                                               
                                               NavigationStack{
                                                   Button(action: {
                                                       isShowingBugView.toggle()
                                                   }, label: {
                                                       Text("I have a suggestion")
                                                       .foregroundColor(Color(hex: "#FFFFFF"))
                                                       .font(.custom(
                                                               "Futura-Medium",
                                                               fixedSize: 14))
                                                       .frame(width: UIScreen.main.bounds.width * 0.71,alignment: .leading)
                                                       .padding(.trailing,4)
                                                       //Spacer().frame(width: UIScreen.main.bounds.width * 0.4)
                                                       Image("arrow")
                                                           .resizable()
                                                           .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
                                                           .contrast(15)
                                                   })
                                                   .sheet(isPresented: $isShowingBugView ) {
                                                       BugView()
                                                           }
                                                   
                                               }
                                           }
                                           .frame(height: 14)
                                           .frame(maxWidth: .infinity)
                                       }
                                       
                                       .padding(.vertical,7)
                                       .padding(.horizontal,5)
                                       .frame(height: UIScreen.main.bounds.height * 0.075)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .background(Color(hex: "#333333"))
                                       .cornerRadius(5)
                                       .padding(.bottom,44)
                                       .padding(.horizontal,UIScreen.main.bounds.width * 0.1)
                                       HStack(spacing: 0){
                                           Image("help")
                                           
                                           
                                           Text("Help")
                                           .foregroundColor(Color(hex: "#FFFFFF"))
                                           .font(.custom(
                                                   "Futura-Medium",
                                                   fixedSize: 16))
                                           //.frame(maxWidth: .infinity)
                                           Spacer().frame(width: UIScreen.main.bounds.width * 0.66)
                                       }
                                       .frame(height: 18)
                                       .frame(maxWidth: .infinity)
                                       .padding(.bottom,11)
                                       .padding(.horizontal,5)
                                       VStack(alignment: .leading, spacing: 0){
                                           HStack(spacing: 0){
                                               
                                               NavigationStack{
                                                   Button(action: {
                                                       isShowingPrivacyView.toggle()
                                                   }, label: {
                                                       Text("Privacy Policy")
                                                       .foregroundColor(Color(hex: "#FFFFFF"))
                                                       .font(.custom(
                                                               "Futura-Medium",
                                                               fixedSize: 14))
                                                       .frame(width: UIScreen.main.bounds.width * 0.71,alignment: .leading)
                                                       .padding(.trailing,4)
                                                       //Spacer().frame(width: UIScreen.main.bounds.width * 0.49)
                                                       Image("arrow")
                                                           .resizable()
                                                           .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
                                                           .contrast(15)
                                                   })
                                                   .sheet(isPresented: $isShowingPrivacyView) {
                                                       PrivacyView(url: URL(string: "https://docs.google.com/document/d/e/2PACX-1vQCfVq7kFa2DR49OehK2p44ZXCaB2VSwJHqiiBVMoveY3eEm_yPB512pJHC4iONCd01f33O-g_-HiaD/pub")!)
                                                           }
                                                   
                                               }
                                           }
                                           .frame(height: 14)
                                           .frame(maxWidth: .infinity)
                                           .padding(.bottom,9)
                                           VStack(alignment: .leading, spacing: 0){
                                           }
                                           .frame(height: UIScreen.main.bounds.height * 0.001)
                                           .frame(maxWidth: .infinity, alignment: .leading)
                                           .background(Color(hex: "#696969"))
                                           .padding(.bottom,6)
                                           HStack(spacing: 0){
                                               
                                               NavigationStack{
                                                   Button(action: {
                                                       isShowingTermsService.toggle()
                                                   }, label: {
                                                       Text("Terms of Service")
                                                       .foregroundColor(Color(hex: "#FFFFFF"))
                                                       .font(.custom(
                                                               "Futura-Medium",
                                                               fixedSize: 14))
                                                       .frame(width: UIScreen.main.bounds.width * 0.71,alignment: .leading)
                                                      // Spacer().frame(width: UIScreen.main.bounds.width * 0.4598)
                                                       Image("arrow")
                                                           .resizable()
                                                           .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
                                                           .contrast(15)
                                                   })
                                                   .sheet(isPresented: $isShowingTermsService) {
                                                       TermsServiceView(url: URL(string: "https://docs.google.com/document/d/e/2PACX-1vQCfVq7kFa2DR49OehK2p44ZXCaB2VSwJHqiiBVMoveY3eEm_yPB512pJHC4iONCd01f33O-g_-HiaD/pub")!)
                                                           .background(Color.washedBlack)
                                                           }
                                                   
                                               }

                                           }
                                           .frame(height: 14)
                                           .frame(maxWidth: .infinity)
                                       
                                           
                                       }
                                       .padding(.vertical,7)
                                       .padding(.horizontal,5)
                                       .frame(height: UIScreen.main.bounds.height * 0.08)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .background(Color(hex: "#333333"))
                                       .cornerRadius(5)
                                       .padding(.horizontal,UIScreen.main.bounds.width * 0.1)
                                       .padding(.bottom,44)
                                       
                                   }
                                   
                                   if sizeClass == .compact {
                                       Spacer().frame(height: UIScreen.main.bounds.height * 0.01)
                                       } else {
                                           Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
                                               .listRowBackground(Color.washedBlack)
                                       }
                                   
                                   HStack(spacing: 0){
                                       
                                       Spacer().frame(width: UIScreen.main.bounds.width * 0.35)
                              
                                       NavigationStack {
                                           Button(role: .destructive) {
                                               Task {
                                                   // This block doesn't throw any errors
                                                   await deleteUserAccount()
                                                   // Present the RootView
                                                   if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                                       let window = windowScene.windows.first {
                                                                   window.rootViewController = UIHostingController(rootView: RootView())
                                                               }
                                                   
                                                   showDeleteView.toggle()
                                               }
                                           } label: {
                                               Text("Delete Account")
                                                   .font(.custom("Futura-Medium", fixedSize: 18))
                                           }
                                       }

                                       
                                       
                                   }
                                   
                               }
                               .padding(.top,19)
                               //.padding(.bottom,596)
                               
                               
                           }
                           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                           .background(Color(hex: "#212121"))
                           
                           
                       }
                       .padding(.top,0.1)
                       .padding(.bottom,0.1)
                       .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                       .background(Color(hex: "#FFFFFF"))
                   }
		
    }
    
    private func deleteUserAccount() async {
        do {
            // Delete user data from Firestore
            try await Firestore.firestore().collection("users").document(AuthenticationManager.shared.getAuthenticatedUser().uid).delete()
            try await AuthenticationManager.shared.delete()
            dismiss()
        }
        catch{
            print("error")
        }
    }
}


struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsScreen()
        }
    }
}