//
//  CartPage.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 14/12/2022.
//

import SwiftUI

struct CartPage: View {
    // for designing...
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        HStack{
                            Text("Basket")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        // check if liked product are empty...
                        if sharedData.cartProducts.isEmpty{
                            Group{
                                Image("NotFound")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .padding(.top, 35)
                                Text("No Items added")
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                Text("Hit the plus button to save into basket")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                            }
                        }else{
                            // displaying products
                            VStack(spacing: 15){
                                ForEach($sharedData.cartProducts) { $product in
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
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                // showing total and check out button
                if !sharedData.cartProducts.isEmpty{
                    Group{
                        HStack{
                            Text("Total")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                            Text(sharedData.getTotalPrice())
                                .font(.system(size: 18).bold())
                                .foregroundColor(Color("Purple"))
                        }
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color("Purple"))
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.7), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                        
                    }
                    .padding(.horizontal, 25)
                }
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeColor").ignoresSafeArea())
        }
    }
    func deleteProduct(product: Product){
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            // remove
            let _ = withAnimation {
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}
struct CardView: View{
    // making prodct as binding to can update in real time
    @Binding var product: Product
    var body: some View{
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
                // quentity Button...
                HStack(spacing: 10){
                    Text("Quantity")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Purple"))
                            .cornerRadius(4)
                    }
                    Text("\(product.quantity)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Purple"))
                            .cornerRadius(4)
                    }
                }
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
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}
