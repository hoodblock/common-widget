//
//  SwiftUIView.swift
//  
//
//  Created by LIU Liming on 18/12/22.
//

import SwiftUI


public struct ScrollSlidingTabBar: View {
    @Binding
    private var selection: Int
    
    private let tabs: [String]
    
    private let style: Style
    
    private let onTap: ((Int) -> Void)?
    
    @State
    private var buttonFrames: [Int: CGRect] = [:]
    
    private var containerSpace: String {
        return "container"
    }
    
    public init(selection: Binding<Int>, tabs: [String], style: Style = .default, onTap: ((Int) -> Void)? = nil) {
        self._selection = selection
        self.tabs = tabs
        self.style = style
        self.onTap = onTap
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    buttons()
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(style.borderColor)
                            .frame(height: style.borderHeight, alignment: .leading)
                        indicatorContainer()
                    }
                }
                .coordinateSpace(name: containerSpace)
            }
            .onChange(of: selection) { newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}

extension ScrollSlidingTabBar {
    
    private func buttons() -> some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { obj in
                Button {
                    selection = obj.offset
                    onTap?(obj.offset)
                } label: {
                    HStack {
                        Text(obj.element)
                            .font(isSelected(index: obj.offset) ? style.selectedFont : style.font)
                    }
                    // 增大 Text 的响应区域，更好点击
                    .padding(.horizontal, style.buttonHInset)
                    .padding(.vertical, style.buttonVInset)
                }
                .accentColor(
                    isSelected(index: obj.offset) ? style.activeAccentColor : style.inactiveAccentColor
                )
                .readFrame(in: .named(containerSpace)) {
                    buttonFrames[obj.offset] = $0
                }
                .id(obj.offset)
            }
        }
    }
    
    private func indicatorContainer() -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: tabWidth(), height: style.indicatorHeight)
            .overlay(indicator(), alignment: .center)
            .offset(x: selectionBarXOffset(), y: 0)
            .animation(.default, value: selection)
    }
    
    private func indicator() -> some View {
        //  因为有的会固定底部引导不标记栏的大小，，所以这里写成固定数字大小
        Rectangle()
            .fill(Color.Color_8682FF)
            .frame(width: 28, height: style.indicatorHeight)
            .cornerRadius(10)
    }
}

extension ScrollSlidingTabBar {
    private func sanitizedSelection() -> Int {
        return max(0, min(tabs.count - 1, selection))
    }
    
    private func isSelected(index: Int) -> Bool {
        return sanitizedSelection() == index
    }
    
    private func selectionBarXOffset() -> CGFloat {
        return buttonFrames[sanitizedSelection()]?.minX ?? .zero
    }
    
    private func indicatorWidth(selection: Int) -> CGFloat {
        return max(tabWidth() - style.buttonHInset * 2, .zero)
    }
    
    private func tabWidth() -> CGFloat {
        return buttonFrames[sanitizedSelection()]?.width ?? .zero
    }
}

extension ScrollSlidingTabBar {
    
    public struct Style {
        public let font: Font
        public let selectedFont: Font
        
        public let activeAccentColor: Color
        public let inactiveAccentColor: Color
        
        public let indicatorHeight: CGFloat
        
        public let borderColor: Color
        public let borderHeight: CGFloat
        
        public let buttonHInset: CGFloat
        public let buttonVInset: CGFloat
        
        public init(font: Font, selectedFont: Font, activeAccentColor: Color, inactiveAccentColor: Color, indicatorHeight: CGFloat, borderColor: Color, borderHeight: CGFloat, buttonHInset: CGFloat, buttonVInset: CGFloat) {
            self.font = font
            self.selectedFont = selectedFont
            self.activeAccentColor = activeAccentColor
            self.inactiveAccentColor = inactiveAccentColor
            self.indicatorHeight = indicatorHeight
            self.borderColor = borderColor
            self.borderHeight = borderHeight
            self.buttonHInset = buttonHInset
            self.buttonVInset = buttonVInset
        }
        
        public static let `default` = Style(
            font: .body,
            selectedFont: .body.bold(),
            activeAccentColor: .blue,
            inactiveAccentColor: .black.opacity(0.4),
            indicatorHeight: 2,
            borderColor: .gray.opacity(0.2),
            borderHeight: 1,
            buttonHInset: 16,
            buttonVInset: 10
        )
    }
}

#if DEBUG
private struct SlidingTabConsumerView: View {
    @State
    private var selection: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollSlidingTabBar(
                selection: $selection,
                tabs: ["First", "Second", "Third", "Fourth", "Fifth", "Sixth"]
            )
            TabView(selection: $selection) {
                HStack {
                    Spacer(minLength: 0)
                    Text("First View")
                    Spacer(minLength: 0)
                }
                .tag(0)
                
                HStack {
                    Spacer(minLength: 0)
                    Text("Second View")
                    Spacer(minLength: 0)
                }
                .tag(1)
                
                HStack {
                    Spacer(minLength: 0)
                    Text("Third View")
                    Spacer(minLength: 0)
                }
                .tag(2)
                
                HStack {
                    Spacer(minLength: 0)
                    Text("Fourth View")
                    Spacer(minLength: 0)
                }
                .tag(3)
                
                HStack {
                    Spacer(minLength: 0)
                    Text("Fifth View")
                    Spacer(minLength: 0)
                }
                .tag(4)
                
                HStack {
                    Spacer(minLength: 0)
                    Text("Sixth View")
                    Spacer(minLength: 0)
                }
                .tag(5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.default, value: selection)
        }
    }
}

struct ScrollSlidingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SlidingTabConsumerView()
    }
}
#endif
