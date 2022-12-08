//
//  LoginPageModel.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 08/12/2022.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnter_Password: Bool = false
    
    func login(){
        
    }
    func register(){
        
    }
    func forgetPassword(){
        
    }
}
