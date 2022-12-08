//
//  ContentView.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 08/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
