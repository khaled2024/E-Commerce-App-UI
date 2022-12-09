//
//  ContentView.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 08/12/2022.
//

import SwiftUI

struct ContentView: View {
    //log status
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group{
            if log_Status{
                MainPage()
            }else{
                OnboardingPage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
