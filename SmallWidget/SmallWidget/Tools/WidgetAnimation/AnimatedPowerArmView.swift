//
//  AnimatedPowerArmView.swift
//  SmallWidget
//
//  Created by nan on 2025/6/25.
//

import SwiftUI
import ClockHandRotationKit


public extension View {
    
    /// 为任意视图添加“双动力臂摇摆动画效果”，可支持水平或者垂直摆动
    ///
    /// 利用两个联动的动力臂，实现内容视图在水平方向或垂直方向的周期性摆动。
    /// 视觉上模拟类似钟摆或机械臂的运动。
    ///
    /// - Parameters:
    ///   - arm1Length: 第一段动力臂（连接到固定点）长度，影响第一层旋转幅度
    ///   - arm2Length: 第二段动力臂（连接内容视图）长度，影响内容视图的摆动范围
    ///   - duration1: 第一段动力臂旋转一周所需时间（秒），可设为负值表示方向
    ///   - duration2: 第二段动力臂旋转一周所需时间（秒），同上
    ///   - direction: 摆动方向，可选 `.horizontal`（水平）或 `.vertical`（垂直）
    ///
    /// - Returns: 返回一个添加了“联动双臂摆动动画”的视图
    ///
    /// 横向或者纵向水平摆动要求： arm1Length = arm2Length 、 -duration1 = duration2 * 2
    ///
    func swingAnimation(arm1Length: CGFloat, arm2Length: CGFloat, duration1: CGFloat, duration2: CGFloat, direction: SwingDirection) -> some View {
        modifier(DualSwingModifier(arm1Length: arm1Length,arm2Length: arm2Length,duration1: duration1,duration2: duration2,direction: direction))
    }
}

public enum SwingDirection {
    case horizontal
    case vertical
}

public struct DualSwingModifier: ViewModifier {
    let arm1Length: CGFloat
    let arm2Length: CGFloat
    let duration1: CGFloat
    let duration2: CGFloat
    let direction: SwingDirection

    public func body(content: Content) -> some View {
        ZStack {
            // 可视中线（参考线）
            if direction == .horizontal {
                Rectangle()
                    .frame(width: (arm1Length + arm2Length) * 2, height: 1)
                    .foregroundColor(.red.opacity(0))
            } else {
                Rectangle()
                    .frame(width: 1, height: (arm1Length + arm2Length) * 2)
                    .foregroundColor(.red.opacity(0))
            }
            // 双臂结构
            ZStack {
                // 动力臂1
                Rectangle()
                    .frame(width: direction == .horizontal ? arm1Length : 30, height: direction == .horizontal ? 30 : arm1Length)
                    .foregroundColor(.red.opacity(0))

                // 动力臂2
                ZStack {
                    Rectangle()
                        .frame(width: direction == .horizontal ? arm2Length : 30, height: direction == .horizontal ? 30 : arm2Length)
                        .foregroundColor(.blue.opacity(0.0))
                    // 内容
                    content
                        .swingAnimation(duration: duration1, distance: 0)
                        .offset(x: direction == .horizontal ? arm2Length / 2 : 0, y: direction == .vertical ? arm2Length / 2 : 0)
                }
                .background(Color.blue.opacity(0))
                .swingAnimation(duration: duration2, distance: 0)
                .offset(x: direction == .horizontal ? arm1Length / 2 : 0, y: direction == .vertical ? arm1Length / 2 : 0)
            }
            .swingAnimation(duration: duration1, distance: 0)
        }
    }
}
