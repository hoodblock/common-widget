//
//  MyWidgetsView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/7.
//

import SwiftUI
import CoreData
import Intents

struct MyWidgetsView: View {
    
    let itemTitles: [String] = ["Small", "Medium"]

    @State private var itemSelected: Int = 0
   
    @State private var showInsterAds: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // 底部tabbar
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    @State var lightModel: Bool = false

    var body: some View {

        let leftWidth = (UIScreen.main.bounds.width - ViewLayout.S_W_20() * 4) / 3
        let rightWidth = (UIScreen.main.bounds.width - ViewLayout.S_W_20() * 3) / 2
        let itemLayout_0 = [ GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_20()), GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_20()), GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_20()) ]
        let itemLayout_1 = [ GridItem(.fixed(rightWidth), spacing: ViewLayout.S_W_20()), GridItem(.fixed(rightWidth), spacing: ViewLayout.S_W_20()) ]
        NavigationStack {
            VStack (alignment: .center) {
                ScrollSlidingTabBar(selection: $itemSelected, tabs: itemTitles,style: ScrollSlidingTabBar.Style(font: .S_Pro_14(), selectedFont: .S_Pro_16(.medium), activeAccentColor: Color.Color_393672, inactiveAccentColor: Color.Color_A5A6BF, indicatorHeight: 4, borderColor: Color.clear, borderHeight: 0, buttonHInset: 7, buttonVInset: 2))
                    .padding( [.top, .bottom], ViewLayout.S_W_10())
                    .padding( [.leading, .trailing], ViewLayout.S_W_20())

                TabView(selection: $itemSelected) {
                        
                    ScrollView {
                        LazyVGrid(columns: itemLayout_0, spacing: ViewLayout.SWidth(20)) {
                            ForEach(Array(typeHistoryWidget(type: .small).indices), id: \.self) { index in
                                NavigationLink {
                                    WidgetEditorView(tabSelected: $tabSelected, widgetSelected: $widgetSelected, configure: typeHistoryWidget(type: .small)[index].1)
                                } label: {
                                    if let uiImage = ImageRenderer(content:  AnyView(
                                        (typeHistoryWidget(type: .small)[index].0)
                                            .frame(minWidth: ViewLayout.S_W_100(), minHeight: ViewLayout.S_W_100())
                                            .background(.white)
                                            .cornerRadius(ViewLayout.S_W_10())
                                    )).uiImage {
                                        Image.init(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)

                                    }
                                }
                            }
                        }
                    }.tag(0)
                 
                    ScrollView {
                        LazyVGrid(columns: itemLayout_1, spacing: ViewLayout.SWidth(20)) {
                            ForEach(Array(typeHistoryWidget(type: .medium).indices), id: \.self) { index in
                                NavigationLink {
                                    WidgetEditorView(tabSelected: $tabSelected, widgetSelected: $widgetSelected, configure: typeHistoryWidget(type: .medium)[index].1)
                                } label: {
                                    if let uiImage = ImageRenderer(content:  AnyView(
                                        (typeHistoryWidget(type: .medium)[index].0)
                                            .frame(minWidth: ViewLayout.S_W_215(), minHeight: ViewLayout.S_W_100())
                                            .background(.white)
                                            .cornerRadius(ViewLayout.S_W_10())
                                    )).uiImage {
                                        Image.init(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)

                                    }
                                }
                            }
                        }
                    }.tag(1)
                            
                    ScrollView {
                        LazyVGrid(columns: itemLayout_1) {
                            ForEach(0..<4){ _ in
                                //                            Calendar0().environment(\.currentWidgetFamily, .systemLarge)
                                EmptyView()
                            }
                            .scaledToFill()
                        }
                    }.tag(2)
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.default, value: itemSelected)
            }
            .background(Color.Color_F6F6F6)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton(viewBlock: {
                showInsterAds = true
            }, lightModel: $lightModel))
            .presentInterstitialAd(isPresented: $showInsterAds, adModel: FirebaseNetwork.shared.loadInterstitialAdViewModel().0, showedBlock: {
                showInsterAds = false
                withAnimation(nil) {
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .navigationTitle("My Widget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
}

extension MyWidgetsView {
 
        func typeHistoryWidget(type: WidgetSizeType) -> [(AnyView, JRWidgetConfigure)] {
        var typeArray: [(AnyView, JRWidgetConfigure)] = []
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        switch type {
        case .small:
            fetchRequest.predicate = NSPredicate(format: "%K == 0", #keyPath(WidgetConfigure.size))
        case .medium:
            fetchRequest.predicate = NSPredicate(format: "%K == 1", #keyPath(WidgetConfigure.size))
        case .large:
            fetchRequest.predicate = NSPredicate(format: "%K == 2", #keyPath(WidgetConfigure.size))
        }
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                let configJsonString = data.widgetUi?.configString
                let widgetConfig: JRWidgetConfigure = JRWidgetConfigureStatic.widgetConfig(JRWidgetConfigureStatic.deserialize(from: configJsonString) ?? JRWidgetConfigureStatic())
                if widgetConfig.nameConfig?.sizeType == type.rawValue {
                    switch WidgetType(rawValue: widgetConfig.nameConfig?.widgetType ?? -1) {
                    case .clock:
                        typeArray.append((AnyView(ClockListConfig(widgetFamily: 0, configure: widgetConfig).itemView()), widgetConfig))
                    case .calendar:
                        typeArray.append((AnyView(CalendarConfig(widgetFamily: 0, configure: widgetConfig).itemView()), widgetConfig))
                    case .XPanel:
                        typeArray.append((AnyView(XPanelConfig(widgetFamily: 0, configure: widgetConfig).itemView()), widgetConfig))
                    case .none:
                        EmptyView()
                    }
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return typeArray
    }
    
    
}
