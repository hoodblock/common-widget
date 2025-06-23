//
//  ContentView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/1.
//

import SwiftUI
import CoreData

struct CustomBackButton: View {
    @State var viewBlock: () -> ()
    @Binding var lightModel: Bool
    
    var body: some View {
        Button(action: {
            viewBlock()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor( lightModel ? Color.Color_FFFFFF : Color.Color_000000)
                .padding(.leading, ViewLayout.SWidth(10)) // Adjust the leading padding here
        }
    }
}


struct PopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Popup Content")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                Button("Dismiss") {
                    isPresented = false
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding()
        }
    }
}

enum Tab : Int32 {
    case widgets = 0
    case setting = 1
    case _default = 2   // 用于weight = 0的变量，在适当的时候切回到第一个tab，又外部来处理，需要的时候，要把Tab 一层层传递一下去
}

struct ContentView: View {
    // 持续化对象
    @Environment(\.managedObjectContext) private var viewContext
    // 获取数据，可以加条件
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default)
    
    private var items: FetchedResults<Item>

    @State private var tabSelected: Tab = .widgets
    // 第一个tabbar的
    @State private var widgetSelected: Int = 0
    @State private var wallpaperSelected: Int = 0

    init() {
        let appearance = UITabBarAppearance()
        // 取消线，设置透明图层，一定要更新
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.configureWithTransparentBackground() // 更新
        // 再设置其他配置
        appearance.backgroundColor = .white

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [.font: UIFont.S_Pro_10(), .foregroundColor: UIColor.Color_A5A6BF]
        itemAppearance.selected.titleTextAttributes = [.font: UIFont.S_Pro_10(.medium), .foregroundColor: UIColor.Color_393672]

        // 各种布局方式设置一下
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance

        let navigationAppearance =  UINavigationBarAppearance()
        navigationAppearance.titleTextAttributes = [.font: UIFont.S_Pro_16(.medium), .foregroundColor: UIColor.Color_393672]

        // 返回文字
        let backAppearance = UIBarButtonItemAppearance(style: .plain)
        backAppearance.normal.titleTextAttributes = [.font: UIFont.S_Pro_16(), .foregroundColor: UIColor.Color_393672]
        
        // 设置返回按钮的样式
        navigationAppearance.backButtonAppearance = backAppearance
        navigationAppearance.buttonAppearance = backAppearance
        UINavigationBar.appearance().standardAppearance = navigationAppearance
    }

    var body: some View {
        GeometryReader { GeometryProxy in
            tableBottomView()
        }
        .font(Font.S_Pro_13(.regular))
        .background(Color.Color_F6F6F6)
    }
    
    
    func tableBottomView() -> some View {
        NavigationStack() {
            TabView(selection: $tabSelected) {
                WidgetsTabView(tabSelected: $tabSelected, widgetSelected: $widgetSelected)
                    .tabItem {
                        tabSelected == Tab.widgets ? Label("Widgets", image: "tabbar_widget_selected") : Label("Widgets", image: "tabbar_widget_normal")
                    }
                    .tag(Tab.widgets)
                SettingView()
                    .tabItem {
                        tabSelected == Tab.setting ? Label("Setting", image:"tabbar_setting_seleted"): Label("Setting", image: "tabbar_setting_normal")
                    }
                    .tag(Tab.setting)
            }
        }
    }
}


struct TabBarItem: View {
    let title: String
    let image: String
    let selected: Bool

    var body: some View {
        VStack {
            Image(image)
            Text(title)
                .foregroundColor(selected ? .blue : .gray)
        }
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
