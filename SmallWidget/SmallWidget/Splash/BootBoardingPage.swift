//
//  BootBoardingPage.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/1.
//

import SwiftUI

enum BootPageType: Int {
    case board_0 = 0
    case board_1 = 1
    case board_2 = 2
}

// MARK: - 本地启动页

struct BootBoardingPage: View {
    
    @Binding var isOnBoardingCompleted: Bool

    @State private var selectedIndex = BootPageType.board_0

    var body: some View {
        
        ZStack(alignment:.bottomLeading) {
            TabView(selection: $selectedIndex) {
                // 第一个标签视图
                Image("board_0")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                    .tag(BootPageType.board_0)
                
                // 第二个标签视图
                Image("board_1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                    .tag(BootPageType.board_1)
                
                // 最后一个标签视图
                
                Image("board_2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                    .tag(BootPageType.board_2)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer(minLength: 0)
                HStack {
                    PageIndicator(selectedIndex: selectedIndex.rawValue)
                    Spacer(minLength: 0)
                    Button(action: {
                        UserDefaults.standard.setValue(true, forKey: USERDEFAULT_BOARD_COMPLETED)
                        UserDefaults.standard.synchronize()
                        isOnBoardingCompleted = true
                    }) {
                        Text("Start")
                            .font(.S_Pro_20())
                            .padding()
                            .frame(width: ViewLayout.S_W_20() * 7, height: ViewLayout.S_H_25() * 2)
                            .background(getButtonColor(selectedIndex.rawValue))
                            .foregroundColor(.white)
                            .cornerRadius(ViewLayout.S_H_10())
                    }
                }
            }
            .padding(ViewLayout.S_W_20())
            
        }
        .statusBarHidden(true)
    }
    
    func getButtonColor(_ index: Int) -> Color {
        switch index {
        case BootPageType.board_0.rawValue:
            return .Color_C58F59
        case BootPageType.board_1.rawValue:
            return .Color_8682FF
        case BootPageType.board_2.rawValue:
            return .Color_AEA795
        default:
            return .blue
        }
    }
}

struct PageIndicator: View {
    
    let selectedIndex: Int
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(selectedIndex == BootPageType.board_0.rawValue ? .Color_C58F59 : .gray)
                .frame(width: selectedIndex == BootPageType.board_0.rawValue ? ViewLayout.S_W_10() * 3 : ViewLayout.S_W_10(), height: ViewLayout.S_H_10())
                .cornerRadius(ViewLayout.S_H_5())
            
            Rectangle()
                .foregroundColor(selectedIndex == BootPageType.board_1.rawValue ? .Color_8682FF : .gray)
                .frame(width: selectedIndex == BootPageType.board_1.rawValue ? ViewLayout.S_W_10() * 3 : ViewLayout.S_W_10(), height: ViewLayout.S_H_10())
                .cornerRadius(ViewLayout.S_H_5())
            
            Rectangle()
                .foregroundColor(selectedIndex == BootPageType.board_2.rawValue ? .Color_AEA795 : .gray)
                .frame(width: selectedIndex == BootPageType.board_2.rawValue ? ViewLayout.S_W_10() * 3 : ViewLayout.S_W_10(), height: ViewLayout.S_H_10())
                .cornerRadius(ViewLayout.S_H_5())
        }
    }
}

struct BootBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        BootBoardingPage(isOnBoardingCompleted: .constant(true))
    }
}
