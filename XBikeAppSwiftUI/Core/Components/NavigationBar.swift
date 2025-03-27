//
//  NavigationBar.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

class NavigationBarViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var showLeft: Bool = false
    @Published var showRight: Bool = false
    @Published var imgLeft: String = ""
    @Published var imgRight: String = ""
}

struct NavigationBar: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var vm = NavigationBarViewModel()
    var callbackLeft: () -> () = { }
    var callbackRight: () -> () = { }
    
    init(title: String, showLeft:Bool = false, showRight:Bool = false, imgLeft:String = "",
         imgRight:String = "", callbackLeft: @escaping () -> () = {}, callbackRight: @escaping () -> () = {}){
        vm.title = title
        vm.showLeft = showLeft
        vm.showRight = showRight
        vm.imgLeft = imgLeft
        vm.imgRight = imgRight
        self.callbackLeft = callbackLeft
        self.callbackRight = callbackRight
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack(alignment: .top, spacing: 0) {
                    
                    if vm.showLeft == true {
                        Button(action: {
                            self.callbackLeft()
                        }) {
                            HStack {
                                Image(vm.imgLeft)
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                    .resizable()
                                    .frame(width: 22,height: 22)
                            }
                            .frame(width: 40, height: 64)
                        }
                        .background(.clear)
                        .padding(.leading, 10)
                    } else {
                        HStack {}
                        .frame(width: 40, height: 64)
                    }
                   
                    Spacer()
                    
                    Text(vm.title)
                        .padding(.top, 20)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if vm.showRight == true {
                        Button(action: {
                            self.callbackRight()
                        }) {
                            HStack {
                                Image(vm.imgRight)
                                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                    .resizable()
                                    .frame(width: 22,height: 22)
                            }
                            .frame(width: 40, height: 64)
                        }
                        .background(.clear)
                        .padding(.trailing, 10)
                    } else {
                        HStack {}
                        .frame(width: 40, height: 64)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                Spacer(minLength: 0)
                Rectangle()
                    .fill(Color.grayOne)
                    .frame(height: 0.5)
                    .padding(.bottom, 0)
            }
            .zIndex(1)
        }
        .background(Color.orangeOne)
        .frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
