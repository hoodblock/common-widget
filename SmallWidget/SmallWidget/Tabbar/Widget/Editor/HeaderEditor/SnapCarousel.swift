//
//  SnapCarousel.swift
//  SwiftUICarousel
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

// 这里有三种情况：
// 间距是根据计算得出来

public struct SnapCarouselStyle {

    public let itemSpacing: CGFloat
    public let cardWidth: CGFloat
    public let cardHeight: CGFloat
    let cardType: WidgetSizeType
    
    public static let `default` = SnapCarouselStyle(
        itemSpacing: ViewLayout.S_W_30(),
        cardWidth: WidgetSizeType.small.value * (WidgetSizeType.small.scaleWidth),
        cardHeight: WidgetSizeType.small.scaleWidth,      // 高相同
        cardType: .small
    )
    
    public static let `small` = SnapCarouselStyle (
        itemSpacing: ViewLayout.S_W_30(),
        cardWidth: WidgetSizeType.small.value * (WidgetSizeType.small.scaleWidth),
        cardHeight: WidgetSizeType.small.scaleWidth,      // 高相同
        cardType: .small
    )
    
    public static let `medium` = SnapCarouselStyle (
        itemSpacing: ViewLayout.S_W_30(),
        cardWidth: WidgetSizeType.medium.value * (WidgetSizeType.small.scaleWidth),
        cardHeight: WidgetSizeType.small.scaleWidth,
        cardType: .medium
    )
    
    public static let `large` = SnapCarouselStyle (
        itemSpacing: ViewLayout.S_W_30(),
        cardWidth: WidgetSizeType.large.value * (WidgetSizeType.large.scaleWidth),
        cardHeight: WidgetSizeType.large.scaleWidth,
        cardType: .large

    )
}

// MARK: - 编辑顶部选中的组件

struct SnapSingle<Content: View>: View {
    
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var config: JRWidgetConfigure

    let style: SnapCarouselStyle
    let content: ()-> Content
    
    init(style: SnapCarouselStyle, _ content: @autoclosure @escaping () -> Content) {
        self.content = content
        self.style = style
    }
    
    var body: some View {
        return Canvas {
            let views: [AnyView?] = [config.nameConfig!.viewName?.getWidgetView(ui: config)]
            Carousel(numberOfItems: CGFloat(views.count), spacing: style.itemSpacing, cardHeight: style.cardHeight, cardWidth: style.cardWidth) {
                ForEach(views.indices, id: \.self) { index in
                    CarouselItem(_id: Int(index), spacing: style.itemSpacing, cardWidth: style.cardWidth, cardHeight: style.cardHeight) {
                        VStack {
                            views[index]
                        }
                    }
                    .background(Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF))
                    .cornerRadius(ViewLayout.S_W_10())
                }
            }
        }
    }
}


extension SnapSingle {
    func style(_ style: SnapCarouselStyle) -> some View {
        return self.environment(\.snapCarouselStyle, style as SnapCarouselStyle)
    }
}





// Data
struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
}

// State
public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0              // 活跃，是否选中
    @Published var screenDrag: Float = 0.0
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let cardHeight: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    @State private var showSpring = false
    
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        cardHeight: CGFloat,
        cardWidth: CGFloat,
        @ViewBuilder _ items: () -> Items) {
            
            self.items = items()
            self.numberOfItems = numberOfItems
            self.spacing = spacing
            self.cardHeight = cardHeight
            self.totalSpacing = (numberOfItems - 1) * spacing + 40 * 2 // 两个边距
            self.cardWidth = cardWidth
        }
    
    var body: some View {
        
//        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing // 总宽度
//        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
//        let leftPadding = widthOfHiddenCards + spacing
//        let totalMovement = cardWidth + spacing
//        
//        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
//        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
//        
//        var calcOffset = Float(activeOffset)
//        
//        if (calcOffset != Float(nextOffset)) {
//            calcOffset = Float(activeOffset) + UIState.screenDrag
//        }
//        
        return HStack(alignment: .center) {
            items
        }
        .offset(x: CGFloat(20))
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.UIState.screenDrag = 0
            showSpring.toggle()
            if (value.translation.width < -50) &&  self.UIState.activeCard < Int(numberOfItems) - 1 {
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            
            if (value.translation.width > 50) && self.UIState.activeCard > 0 {
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
        .animation(.spring(), value: showSpring)
    }
}

// 设置全屏，配置环境变量
struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.Color_F6F6F6)
    }
}

struct CarouselItem<Content: View>: View {
    
    @EnvironmentObject var UIState: UIStateModel
    @Environment(\.snapCarouselStyle) private var style

    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content
    
    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        cardWidth: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = cardWidth
        self.cardHeight = cardHeight
        self._id = _id
    }
    
    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight, alignment: .center)
    }
}

struct SnapCarousel: View {
    
    @EnvironmentObject var UIState: UIStateModel
    @Environment(\.snapCarouselStyle) private var style
    
    let content: [AnyView]
    
    init<Views>(@ViewBuilder content: @escaping () -> TupleView<Views>) {
        self.content = content().getViews
    }
    
    var body: some View {
        
        let spacing: CGFloat = style.itemSpacing
        let cardwidth: CGFloat = style.cardWidth
        let cardHeight: CGFloat = style.cardHeight

        return Canvas {
            Carousel(numberOfItems: CGFloat(content.count), spacing: spacing, cardHeight: cardHeight, cardWidth: cardwidth
            ) {
                ForEach(content.indices, id: \.self) { index in
                    CarouselItem(_id: Int(index), spacing: spacing, cardWidth: cardwidth, cardHeight: cardHeight) {
                        VStack {
                            content[index]
                        }
                    }
                }
                
            }
        }
    }
}

extension SnapCarousel {
    func style(_ style: SnapCarouselStyle) -> some View {
        return self.environment(\.snapCarouselStyle, style as SnapCarouselStyle)
    }
}


struct SnapCarousel_Previews: PreviewProvider {
    
    static var previews: some View {
        SnapCarousel(content: {
            Text("1")
            Text("2")
        })
        .style(.small)
        .environmentObject(ContentViewModel().stateModel)
        
        SnapCarousel(content: {
            Text("1")
            Text("2")
        })
        .style(.medium)
        .environmentObject(ContentViewModel().stateModel)
        
    }
}
