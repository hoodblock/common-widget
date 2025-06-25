//
//  AnimatedUIView.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/23.
//


import SwiftUI
import ClockHandRotationKit

public enum Direction: Hashable, Equatable {
    case horizontal
    case vertical
}

public extension View {
    
    /// 添加沿着锚点旋转的动画
    ///
    /// - Parameters:
    ///   - duration: 旋转一圈维持的秒数，可设为负值表示方向
    ///   - distance: 偏移量
    ///
    /// - Returns: 返回一个添加了摆动的视图
    ///
    ///
    func swingAnimation(duration: CGFloat, distance: CGFloat) -> some View {
        modifier(SwingAnimationModifier(duration: duration, distance: distance))
    }
}

public struct SwingAnimationModifier: ViewModifier {
    public let duration: CGFloat
    public let distance: CGFloat

    public init(duration: CGFloat, distance: CGFloat) {
        // 动画一圈的持续时间（单位是秒）。
        self.duration = duration
        // 摆动的幅度，最大偏移量。
        self.distance = distance
    }

    @ViewBuilder
    private func overlayView(content: Content) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let extendLength = size.width
            let totalDistance = abs(distance) + extendLength
            let innerDiameter = (extendLength + totalDistance) / 2
            ZStack() {
                Color.clear
                ZStack() {
                    Color.clear
                    content
                        .clockHandRotationEffect(period: .custom(duration))
                        .frame(width: innerDiameter, height: innerDiameter)
                }
                .frame(width: totalDistance, height: totalDistance)
            }
            .frame(width: size.width, height: size.height)
        }
    }

    public func body(content: Content) -> some View {
        content.hidden()
            .overlay(overlayView(content: content))
    }
}
