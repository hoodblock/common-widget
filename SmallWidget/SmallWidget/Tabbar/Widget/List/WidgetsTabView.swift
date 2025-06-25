//
//  WidgetsTabView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/5.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var showToast: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
        }
        .padding(.bottom, ViewLayout.S_W_10())
        .opacity(showToast ? 1 : 0)
        .animation(.easeInOut(duration: 0.3))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                showToast = false
            }
        }
    }
}

struct WidgetsTabView: View {
    
    enum WidgetsTab {
        case settings
        case transparent
        case favorite
    }
    
    // 顶部导航
    @State private var naviteLinkItems: [Bool] = [false, false, false]
    // 底部tabbar
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    // 广告
    @State private var nativeModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    @State private var refreshFlag = false
    @State private var showPopup = true
    @State private var rateShowCount: Int = 0
    
    @ObservedObject var payConfig = PayConfig.shared
    
    @State private var showWebView = false

    var body: some View {
        
        let scrollWidgetArray: [(title: String, view: AnyView)] = [
            (title: "Clock",            view: AnyView(ClockListView(tabSelected: $tabSelected, widgetSelected: $widgetSelected))),
            (title: "Calendar",         view: AnyView(CalendarView(tabSelected: $tabSelected, widgetSelected: $widgetSelected))),
            (title: "X Panel",          view: AnyView(XPanelView(tabSelected: $tabSelected, widgetSelected: $widgetSelected))),
        ]

        Color.Color_F6F6F6.edgesIgnoringSafeArea(.all).overlay {
            GeometryReader { proxy in
                ZStack (alignment: .center) {
                    VStack (alignment: .center, spacing: 0) {
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            // 顶部区域 （文案 / 搜索）
                            HStack(alignment:.center, spacing: 0) {
                                Text("Simple Widgets")
                                    .font(.S_Pro_20(.medium))
                                    .foregroundColor(Color.Color_393672)
                                Spacer(minLength: 0)
                            }
                            if nativeModel.nativeAd != nil && nativeModel.ad_id.count > 0 {
                                SwiftUINativeView(objectSize: NATIVESIZE_120, admobModel: nativeModel)
                                    .id(refreshFlag)
                            }
                            // 中间引导选项, 这里会有来两种逻辑，点击跳转和点击取消
                            HStack(spacing: ViewLayout.S_W_16()) {
                                if !naviteLinkItems.isEmpty {
                                    nativeWidgetItem(destination: WidgetSettingView(), $naviteLinkItems[0], .setting)
                                    nativeWidgetItem(destination: TransparentView(), $naviteLinkItems[1], .transparent)
                                    nativeWidgetItem(destination: MyWidgetsView(tabSelected: $tabSelected, widgetSelected: $widgetSelected), $naviteLinkItems[2], .favorite)
                                }
                            }
                            .onAppear() {
                                naviteLinkItems = Array(repeating: false, count: 3)
                            }
                            .frame(height: ViewLayout.S_H_25() * 3)
                        }
                        Spacer(minLength: ViewLayout.SWidth(8))
                        // MARK: - 这里的的按钮说是太小了，让放大一点
                        ScrollSlidingTabBar(selection: $widgetSelected, tabs: scrollWidgetArray.map { $0.title }, style: ScrollSlidingTabBar.Style(font: Font.S_Pro_14(), selectedFont: Font.S_Pro_16(.medium), activeAccentColor: Color.Color_393672, inactiveAccentColor: Color.Color_A5A6BF, indicatorHeight: ViewLayout.S_H_3(), borderColor: Color.clear, borderHeight: 0, buttonHInset: ViewLayout.S_W_10(), buttonVInset: ViewLayout.S_H_10()))
                        TabView(selection: $widgetSelected) {
                            ForEach(scrollWidgetArray.map { $0.view }.indices, id: \.self) { index in
                                scrollWidgetArray.map { $0.view }[index]
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .listStyle(PlainListStyle())
                    }
                    .padding([.leading,.trailing], ViewLayout.S_W_20())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } // GeometryReader
        } // Color
        .onAppear {
            nativeModel = FirebaseNetwork.shared.loadNativeAdViewModel().0
            if nativeModel.nativeAd != nil && nativeModel.ad_id.count > 0 {
                refreshFlag.toggle()
            }
            rateShowCount = ((UserDefaults.standard.value(forKey: USERDEFAULT_RATE_ALERT) != nil) ? UserDefaults.standard.value(forKey: USERDEFAULT_RATE_ALERT)! as! Int : 0) + 1
            UserDefaults.standard.setValue(rateShowCount, forKey: USERDEFAULT_RATE_ALERT)
            UserDefaults.standard.synchronize()
        }
    } // body
}

extension WidgetsTabView {
    
    enum widgetItemType {
        case setting
        case transparent
        case favorite
    }

    func nativeWidgetItem<Destination: View>(destination: Destination, _ isActive: Binding<Bool>, _ type: widgetItemType = .setting) -> some View {
        NavigationLink(destination: destination, isActive: isActive) {
            switch type {
            case .setting:
                widgetItem(content: Label("Widget Settings", image: !isActive.wrappedValue ? "widget_setting_default" : "widget_setting_selected"), isHighlighted: isActive)
            case .transparent:
                widgetItem(content: Label("Transparent Widget", image: !isActive.wrappedValue ? "widget_transparent_default" : "widget_transparent_selected"), isHighlighted: isActive)
            case .favorite:
                widgetItem(content: Label("My Widget", image: !isActive.wrappedValue ? "widget_favorite_default" : "widget_favorite_selected"), isHighlighted: isActive)
            }
        }
    }
    
    func widgetItem<Content: View>(content: Content, isHighlighted: Binding<Bool>) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .center)
            .labelStyle(VLabelTStyle())
            .background(isHighlighted.wrappedValue ? Color.Color_8682FF : Color.Color_EAEAFF)
            .cornerRadius(ViewLayout.S_H_10())
            .foregroundColor(isHighlighted.wrappedValue ? .white : Color.Color_A5A6BF)
            .gesture(TapGesture().onEnded({
                isHighlighted.wrappedValue.toggle()
//                DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(400))) {
//                    isHighlighted.wrappedValue.toggle()
//                }
            }))
    }
    
}
