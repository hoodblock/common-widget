//
//  File.swift
//  
//
//  Created by LIU Liming on 18/12/22.
//

import SwiftUI

extension View {
    /// - Parameters:
    ///   - id: used to differentiate a view and its ancestor if they both call `readFrame`
    /// - Note: `onChange` maybe called with duplicated values
    public func readFrame(in space: CoordinateSpace, id: String = "shared", onChange: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color
                    .clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: [.init(space: space, id: id): proxy.frame(in: space)])
            }
        )
        .onPreferenceChange(FramePreferenceKey.self) {
            onChange($0[.init(space: space, id: id)] ?? .zero)
        }
    }
    
    func readHeight(onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: HeightPerferenceKey.self, value: geometryProxy.size.height)
            }
        )
        .onPreferenceChange(HeightPerferenceKey.self, perform: onChange)
    }
}

private struct HeightPerferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        // 这里不进行任何操作，直接把值抛出
//        value = nextValue()
    }
}

// 每页的信息
private struct FramePreferenceKey: PreferenceKey {
    
    static var defaultValue: [PreferenceValueKey: CGRect] = [:]
    // 传递值
    static func reduce(value: inout [PreferenceValueKey: CGRect], nextValue: () -> [PreferenceValueKey: CGRect]) {
        value.merge(nextValue()) { $1 }
    }
}

private struct PreferenceValueKey: Hashable {
    let space: CoordinateSpace
    let id: String
}
