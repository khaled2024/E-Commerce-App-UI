//
//  MoreProductView.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 10/12/2022.
//

import SwiftUI

struct MoreProductView: View {
    var body: some View {
        VStack{
            Text("More products")
                .font(.system(size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
        .background(Color("HomeColor"))
    }
}

struct MoreProductView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductView()
    }
}
