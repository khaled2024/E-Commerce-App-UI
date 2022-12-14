//
//  LikedPage.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 14/12/2022.
//

import SwiftUI

struct LikedPage: View {
    // for designing...
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        Text("Favorite")
                            .font(.system(size: 28).bold())
                        Spacer()
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image(systemName:"trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    // check if liked product are empty...
                    if sharedData.likedProducts.isEmpty{
                        Group{
                            Image("NotFound")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .padding(.top, 35)
                            Text("No favorite yet")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                            Text("Hit the liked button on each product to save favorite ones.")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    }else{
                        // displaying products
                        VStack(spacing: 15){
                            ForEach(sharedData.likedProducts) { product in
                                HStack(spacing: 0) {
                                    if showDeleteOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeColor").ignoresSafeArea())
        }
    }
    @ViewBuilder
    func CardView(product: Product)-> some View{
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.system(size: 18).bold())
                    .lineLimit(1)
                Text(product.subTitle)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
                Text("Type: \(product.type.rawValue)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
            Color.white.cornerRadius(15)
        )
    }
    func deleteProduct(product: Product){
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            // remove
            let _ = withAnimation {
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
