//
//  ProductDetailView.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 12/12/2022.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    var animation: Namespace.ID
    // shared data model
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        VStack{
            // title bar & product Image...
            VStack{
                // title bar
                HStack{
                    // back btn
                    Button {
                        // closing view
                        sharedData.showDetailProduct = false
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    Spacer()
                    // favorite btn
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor( isLiked() ? .red : .black.opacity(0.7))
                    }
                }
                .padding()
                // product Image...
                Image(product.productImage)
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height/2.7)
            .zIndex(1)
            // product detail...
            ScrollView(.vertical, showsIndicators: false) {
                // product data...
                VStack(alignment: .leading, spacing: 15) {
                    // title...
                    Text(product.title)
                        .font(.system(size: 20).bold())
                    // subtitle...
                    Text(product.subTitle )
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    // text
                    Text("Get Apple TV+ free for a year")
                        .font(.system(size: 16).bold())
                        .padding(.top)
                    // description...
                    Text("Available when you purchase any new iPhone, iPad, iPad Touch, Mac or apple TV, $4.99/month after free trial.")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    // full description...
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                    }
                    .font(.system(size: 15).bold())
                    .foregroundColor(Color("Purple"))
                    // total price
                    HStack{
                        Text("Total")
                            .font(.system(size: 17))
                        Spacer()
                        Text(product.price)
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical,20)
                    // Basket btn
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddToCart() ? "added" : "add") to basket")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
                            )
                    }
                    
                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // corner radius for only top side
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color("HomeColor").ignoresSafeArea())
    }
    //MARK: - Functions
    // liked btn...
    func addToLiked(){
        // if user tap to liked btn and there was a product with the same id in likeded products will remove it...
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            // return the index when self.product.id == product.id
            return self.product.id == product.id
        }){
            // remove from liked products...
            sharedData.likedProducts.remove(at: index)
        }else{
            // adding to liked products...
            sharedData.likedProducts.append(product)
        }
    }
    // is liked
    func isLiked()-> Bool{
        return sharedData.likedProducts.contains { product in
            self.product.id == product.id
        }
    }
    // (Cart) Basket btn...
    func addToCart(){
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // remove from cart products...
            sharedData.cartProducts.remove(at: index)
        }else{
            // adding to cart products...
            sharedData.cartProducts.append(product)
        }
    }
    // is added to cart
    func isAddToCart()-> Bool{
        return sharedData.cartProducts.contains { product in
            self.product.id == product.id
        }
    }
}
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        ProductDetailView(product: HomeViewModel().products[0])
        //            .environmentObject(SharedDataModel())
        MainPage()
    }
}
