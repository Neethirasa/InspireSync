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
						
                        Spacer().frame(height: 100)
                        
                        
						Text("My Account")
						.foregroundColor(Color(hex: "#FFFFFF"))
						.font(.system(size: 18))
						.padding(.bottom,9)
						.padding(.horizontal,47)
						VStack(alignment: .leading, spacing: 0){
							Text("Username")
							.foregroundColor(Color(hex: "#FFFFFF"))
                            .font(.custom(
                                    "Futura-Medium",
                                    fixedSize: 14))
							.padding(.bottom,8)
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
								.padding(.trailing,175)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)
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
						}
						.frame(height: 18)
						.frame(maxWidth: .infinity)
						.padding(.bottom,11)
						.padding(.horizontal,51)
                        .padding(.trailing,175)
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
								.padding(.trailing,160)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)
					
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
                                .padding(.trailing,130)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)
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
                            .padding(.trailing,250)
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
                                .padding(.trailing,160)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)
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
                                .padding(.trailing,150)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)

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
                                .padding(.trailing,180)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)

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
                                .padding(.trailing,170)
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 20, height: 14, alignment: .leading)
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
                    Spacer().frame(height: 100)
                    HStack(spacing: 0){
                        
                        Spacer().frame(width: 140)
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
