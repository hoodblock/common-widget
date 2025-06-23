//
//  FloatView.swift
//  SmallWidget
//
//  Created by Thomas on 2024/12/11.
//

import SwiftUI

//let CircleFrameW: CGFloat = 105.00  // 圆形按钮的宽度和高度
//let CircleFrameH: CGFloat = 50.00  // 圆形按钮的宽度和高度

let CircleFrameW: CGFloat = 157.00  // 圆形按钮的宽度和高度
let CircleFrameH: CGFloat = 75.00  // 圆形按钮的宽度和高度

let USERDEFAULT_FLOAT_DRAG_POINT_X: String = "USERDEFAULT_FLOAT_DRAG_POINT_X"
let USERDEFAULT_FLOAT_DRAG_POINT_Y: String = "USERDEFAULT_FLOAT_DRAG_POINT_Y"

struct FloatingDragView: View {
    
    @GestureState private var dragOffset: CGSize = .zero
    @Environment(\.safeAreaInsets) private var safeAreaInsets  // 获取安全区域的边距
    
    @State private var position: CGPoint = CGPoint(x: CircleFrameW, y: CircleFrameH)  // 初始位置
    @State private var isDragging = false
    
    var draggable: Bool = true        // 是否允许拖动
    var autoDocking: Bool = true      // 是否启用自动吸附
    var clickClosure: (() -> Void)?   // 点击回调闭包
    
    var body: some View {
        ZStack {
            Image("devirce_icon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: CircleFrameW, height: CircleFrameH)  // 设置按钮大小为圆形
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)  // 添加阴影效果
                .position(position)  // 设置按钮位置
                .gesture(
                    DragGesture() // 拖动手势
                        .onChanged { value in
                            if draggable {
                                // 计算新的位置，跟随手指移动
                                let newLocation = CGPoint(x: value.location.x, y: value.location.y)
                                // 获取屏幕的宽高
                                let screenWidth = UIScreen.main.bounds.width
                                let screenHeight = UIScreen.main.bounds.height
                                
                                // 使用安全区域的边距，限制上下位置
                                let safeAreaTop = safeAreaInsets.top  // 顶部安全区
                                let safeAreaBottom = safeAreaInsets.bottom  // 底部安全区
                                
                                // 限制 X 轴的位置，防止超出屏幕
                                if newLocation.x < CircleFrameW / 2 {
                                    position.x = CircleFrameW / 2
                                } else if newLocation.x > screenWidth - CircleFrameW / 2 {
                                    position.x = screenWidth - CircleFrameW / 2
                                } else {
                                    position.x = newLocation.x
                                }
                                if newLocation.y < safeAreaTop {  // 顶部安全区加按钮高度的一半
                                    position.y = safeAreaTop
                                } else if newLocation.y > (screenHeight - safeAreaBottom - CircleFrameH * 3) { // 底部安全区加按钮高度的一半
                                    position.y = (screenHeight - safeAreaBottom - CircleFrameH * 3)
                                } else {
                                    position.y = newLocation.y
                                }
                            }
                        }
                        .onEnded { _ in
                            if autoDocking {
                                self.autoDockEdge()
                            }
                            self.isDragging = false
                        }
                )
                .gesture(
                    TapGesture().onEnded {
                        self.buttonTapped()
                    }
                )
        }
        .onAppear {
            // 设置按钮的初始位置
            if (UserDefaults.standard.value(forKey: USERDEFAULT_FLOAT_DRAG_POINT_X) != nil) {
                let point: CGPoint = CGPoint(x: UserDefaults.standard.value(forKey: USERDEFAULT_FLOAT_DRAG_POINT_X) as! CGFloat, y: UserDefaults.standard.value(forKey: USERDEFAULT_FLOAT_DRAG_POINT_Y) as! CGFloat)
                self.position = CGPoint(x: point.x, y: point.y)
            } else {
                self.position = CGPoint(x: UIScreen.main.bounds.width - CircleFrameW / 2, y: UIScreen.main.bounds.height - safeAreaInsets.bottom - CircleFrameH * 5)
            }
        }
        .zIndex(1)
    }
    
    // 点击事件的回调
    private func buttonTapped() {
        clickClosure?()  // 执行传入的点击回调闭包
    }
    
    // 自动吸附到最近的边缘
    private func autoDockEdge() {
        let screenWidth = UIScreen.main.bounds.width
        let distanceToLeft = position.x
        let distanceToRight = screenWidth - position.x
        withAnimation(.easeInOut(duration: 0.2)) {
            if distanceToLeft < distanceToRight {
                position.x = CircleFrameW / 2
            } else {
                position.x = screenWidth - CircleFrameW / 2
            }
            UserDefaults.standard.set(position.x, forKey: USERDEFAULT_FLOAT_DRAG_POINT_X)
            UserDefaults.standard.set(position.y, forKey: USERDEFAULT_FLOAT_DRAG_POINT_Y)
            UserDefaults.standard.synchronize()
        }
    }
}
