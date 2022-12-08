//
//  LoginPage.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 08/12/2022.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack{
            Text("Welcome\nback")
                .font(.system(size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height: getRect().height/3.5)
                .padding()
            // Background
                .background(
                    ZStack{
                        // the Circle LinearGradient
                        LinearGradient(colors: [Color("LoginCircle"),Color("LoginCircle").opacity(0.8),Color("Purple")], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                        // Circle 1
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottomTrailing)
                            .padding(30)
                        // Circle 2
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
                            .padding(.leading,30)
                    }
                )
            // Scroll View
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.system(size: 22).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    // Custom TF
                    CustomTextField(icon: "envelope", title: "Email", hint: "example@gmail.com", value: $loginData.email, showPass: .constant(false))
                        .padding(.top, 30)
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPass: $loginData.showPassword)
                        .padding(.top, 10)
                    // Register For Re-enter password
                    if loginData.registerUser{
                        CustomTextField(icon: "envelope", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPass: $loginData.showReEnter_Password)
                            .padding(.top, 10)
                    }
                    // Forget Password Button
                    Button {
                        loginData.forgetPassword()
                    } label: {
                        Text("Forget password?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                        
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    //Login Button
                    Button {
                        if loginData.registerUser{
                            loginData.register()
                        }else{
                            loginData.login()
                        }
                    } label: {
                        Text("Login")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    // Register user Button
                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to Login" : "Create account")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                        
                    }
                    .padding(.top,8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // applaying custom shape
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        
        // Clearing date when changes
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnter_Password = false
        }
        
    }
    
    //MARK: - ViewBuilder
    @ViewBuilder
    func CustomTextField(icon: String,
                         title: String,
                         hint: String,
                         value: Binding<String>,
                         showPass: Binding<Bool>)-> some View{
        VStack(alignment: .leading,spacing: 12){
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(.black.opacity(0.8))
            
            if title.contains("Password") && !showPass.wrappedValue{
                SecureField(hint,text: value)
                    .padding(.top, 2)
            }else{
                TextField(hint,text: value)
                    .padding(.top, 2)
            }
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // show show passowrd btn
        .overlay(
            Group{
                if title.contains("Password"){
                    Button(action: {
                        showPass.wrappedValue.toggle()
                    }, label: {
                        Text(showPass.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13).bold())
                            .foregroundColor(Color("Purple"))
                            .offset(y: 8)
                    })
                }
            }
            ,alignment: .trailing
        )
    }
}
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
