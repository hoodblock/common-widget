//
//  PointAnimation.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/23.
//

import ClockHandRotationKit
import SwiftUI

// 方向
public enum Direction: Hashable, Equatable {
    case horizontal             // 水平方向
    case vertical               // 竖直方向
}

// 扩展
public extension View {
    
    /** 摇摆动画
     ** duration：动画的持续时间
     ** direction：摆动动画的方向
     ** distance：摆动动画的距离（横向最大距离或者纵向最大距离）
     */
    func swingAnimation(duration: CGFloat, direction: Direction = .horizontal, distance: CGFloat) -> some View {
        modifier(SwingAnimationModifier(duration: duration, direction: direction, distance: distance))
    }
    
    //
}

// 将摆动动画应用于视图的修改器。
public struct SwingAnimationModifier: ViewModifier {
    // 动画的持续时间
    public let duration: CGFloat
    // 摆动动画的方向
    public let direction: Direction
    // 摆动动画的距离（横向最大距离或者纵向最大距离）
    public let distance: CGFloat
    
    public init(duration: CGFloat, direction: Direction, distance: CGFloat) {
        self.duration = duration
        self.direction = direction
        self.distance = distance
    }

    private var alignment: Alignment {
        if direction == .vertical {
            return distance > 0 ? .top : .bottom
        } else {
            return distance > 0 ? .leading : .trailing
        }
    }
    
    // 修改文件

//    @ViewBuilder
//    private func overlayView(content: Content) -> some View {
//        let alignment = alignment
//        GeometryReader {
//            let size = $0.size
//            let extendLength = direction == .vertical ? size.height : size.width
//            let length: CGFloat = abs(distance) + extendLength
//            let innerDiameter = (length + extendLength) / 2
//            let outerAlignment: Alignment = {
//                if direction == .vertical {
//                    return distance > 0 ? .bottom : .top
//                } else {
//                    return distance > 0 ? .trailing : .leading
//                }
//            }()
//
//            ZStack(alignment: outerAlignment) {
//                Color.clear
//                ZStack(alignment: alignment) {
//                    Color.clear
//                    ZStack(alignment: alignment) {
//                        Color.clear
//                        content.clockHandRotationEffect(period: .secondHand)
////                        content.clockHandRotationEffect(period: .custom(30))
//                    }
//                    .frame(width: innerDiameter, height: innerDiameter)
//                    .background(Color.blue.opacity(0.4))
//                }
//                .frame(width: length, height: length)
//                .background(Color.black.opacity(0.3))
//            }
//            .frame(width: size.width, height: size.height, alignment: alignment)
//            .background(Color.red.opacity(0.2))
//        }
//    }
    
    // 源文件
    @ViewBuilder
     private func overlayView(content: Content) -> some View {
         let alignment = alignment
         GeometryReader {
             let size = $0.size
             let extendLength = direction == .vertical ? size.height : size.width
             let length: CGFloat = abs(distance) + extendLength
             let innerDiameter = (length + extendLength) / 2
             let outerAlignment: Alignment = {
                 if direction == .vertical {
                     return distance > 0 ? .bottom : .top
                 } else {
                     return distance > 0 ? .trailing : .leading
                 }
             }()

             ZStack(alignment: outerAlignment) {
                 Color.clear
                 ZStack(alignment: alignment) {
                     Color.clear
                     ZStack(alignment: alignment) {
                         Color.clear
//                         content.clockHandRotationEffect(period: .custom(duration))
                         content.clockHandRotationEffect(period: .secondHand)
                     }
                     .frame(width: innerDiameter, height: innerDiameter)
//                     .clockHandRotationEffect(period: .custom(-duration / 2))
                     content.clockHandRotationEffect(period: .secondHand)

                 }
                 .frame(width: length, height: length)
//                 .clockHandRotationEffect(period: .custom(duration))
                 content.clockHandRotationEffect(period: .secondHand)
             }
             .frame(width: size.width, height: size.height, alignment: alignment)
         }
     }
    

    public func body(content: Content) -> some View {
        content.hidden()
            .overlay(overlayView(content: content))
    }
}
