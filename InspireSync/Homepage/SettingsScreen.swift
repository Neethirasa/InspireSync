// Install URLImage: https://github.com/dmytro-anokhin/url-image
import URLImage 
import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
						
                        Spacer().frame(height: UIScreen.main.bounds.height * 0.10)
                        
                        
                        HStack(spacing: 0){
                            
                            Text("My Account")
                            .foregroundColor(Color(hex: "#FFFFFF"))
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 16))
                            //.frame(maxWidth: .infinity)
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.50)
                        }
                        .frame(height: 18)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom,11)
                        .padding(.horizontal,51)
                        
						VStack(alignment: .leading, spacing: 0){
                            
                            
                            HStack(spacing: 0){
                                Text("Username")
                                .foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
                                .frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.49)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
                            }
                            
                            Spacer().frame(height: UIScreen.main.bounds.height * 0.010)
                            
							VStack(alignment: .leading, spacing: 0){
							}
							.frame(height: 1)
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(Color(hex: "#696969"))
							.padding(.bottom,6)
							HStack(spacing: 0){
								Text("Notifications")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.45)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
							}
							.frame(height: 15)
							.frame(maxWidth: .infinity)
						}
						.padding(.vertical,10)
						.padding(.horizontal,11)
						.frame(height: 66)
						.frame(maxWidth: .infinity, alignment: .leading)
						.background(Color(hex: "#333333"))
						.cornerRadius(5)
						.padding(.bottom,44)
						.padding(.horizontal,46)
						HStack(spacing: 0){
							
							Text("Send Feedback")
							.foregroundColor(Color(hex: "#FFFFFF"))
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 16))
							//.frame(maxWidth: .infinity)
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.45)
						}
						.frame(height: 18)
						.frame(maxWidth: .infinity)
						.padding(.bottom,11)
						.padding(.horizontal,51)
					}
					Group{
						VStack(alignment: .leading, spacing: 0){
							HStack(spacing: 0){
								Text("I spotted a bug")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.40)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
					
							}
							.frame(height: 14)
							.frame(maxWidth: .infinity)
							.padding(.bottom,9)
							VStack(alignment: .leading, spacing: 0){
							}
							.frame(height: 1)
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(Color(hex: "#696969"))
							.padding(.bottom,6)
							HStack(spacing: 0){
								Text("I have a suggestion")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
								.padding(.trailing,4)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.33)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
							}
							.frame(height: 14)
							.frame(maxWidth: .infinity)
						}
                        
						.padding(.vertical,7)
						.padding(.horizontal,10)
						.frame(height: 58)
						.frame(maxWidth: .infinity, alignment: .leading)
						.background(Color(hex: "#333333"))
						.cornerRadius(5)
						.padding(.bottom,44)
						.padding(.horizontal,46)
						HStack(spacing: 0){
							Text("Help")
							.foregroundColor(Color(hex: "#FFFFFF"))
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 16))
							.frame(maxWidth: .infinity)
                            Spacer().frame(width: UIScreen.main.bounds.width * 0.65)
						}
						.frame(height: 18)
						.frame(maxWidth: .infinity)
						.padding(.bottom,11)
						.padding(.horizontal,51)
						VStack(alignment: .leading, spacing: 0){
							HStack(spacing: 0){
								Text("Privacy Policy")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
								.padding(.trailing,4)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.43)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
							}
							.frame(height: 14)
							.frame(maxWidth: .infinity)
							.padding(.bottom,9)
							VStack(alignment: .leading, spacing: 0){
							}
							.frame(height: 1)
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(Color(hex: "#696969"))
							.padding(.bottom,6)
							HStack(spacing: 0){
								Text("Terms of Service")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.39)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)

							}
							.frame(height: 14)
							.frame(maxWidth: .infinity)
							.padding(.bottom,9)
							VStack(alignment: .leading, spacing: 0){
							}
							.frame(height: 1)
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(Color(hex: "#696969"))
							.padding(.bottom,6)
							HStack(spacing: 0){
								Text("Other Legal")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.46)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)

							}
							.frame(height: 14)
							.frame(maxWidth: .infinity)
							.padding(.bottom,9)
							VStack(alignment: .leading, spacing: 0){
							}
							.frame(height: 1)
							.frame(maxWidth: .infinity, alignment: .leading)
							.background(Color(hex: "#696969"))
							.padding(.bottom,6)
							HStack(spacing: 0){
								Text("Safety Center")
								.foregroundColor(Color(hex: "#FFFFFF"))
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 14))
								.frame(maxWidth: .infinity)
                                Spacer().frame(width: UIScreen.main.bounds.width * 0.44)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.018, alignment: .leading)
							}
							.frame(height: 14)
							.frame(maxWidth: .infinity)
                            
						}
						.padding(.vertical,7)
						.padding(.horizontal,10)
						.frame(height: 118)
						.frame(maxWidth: .infinity, alignment: .leading)
						.background(Color(hex: "#333333"))
						.cornerRadius(5)
						.padding(.horizontal,46)
                        
                        
					}
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
                    HStack(spacing: 0){
                        
                        Spacer().frame(width: UIScreen.main.bounds.width * 0.35)
                        Button(role: .destructive){
              
                        }label: {
                        Text("Delete Account")
                                .font(.custom(
                                        "Futura-Medium",
                                        fixedSize: 18))
                        }
                    }
                    
				}
				.padding(.top,19)
				.padding(.bottom,196)
                
                
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
			.background(Color(hex: "#212121"))
            
            
		}
        .scrollDisabled(true)
		.padding(.top,0.1)
		.padding(.bottom,0.1)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
		.background(Color(hex: "#FFFFFF"))
		
    }
}


struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsScreen()
        }
    }
}
