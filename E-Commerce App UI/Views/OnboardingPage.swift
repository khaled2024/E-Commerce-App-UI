//
//  OnboardingPage.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 08/12/2022.
//

import SwiftUI
// to uset custom font in all pages
let customFont = "Raleway-Regular"
struct OnboardingPage: View {
    // showing login page
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image("Onboarding")
                .resizable()
                .scaledToFit()
            Button {
                withAnimation {
                    showLoginPage.toggle()
                }
            } label: {
                Text("Get started")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
                
            }
            .padding(.horizontal,30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            Spacer()
            
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Purple")
        )
        .overlay(
            Group{
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage()
            .previewDevice("iPhone 12")
    }
}
//MARK: - extension for get screen bounds...
extension View{
    func getRect()-> CGRect{
        return UIScreen.main.bounds
    }
}
