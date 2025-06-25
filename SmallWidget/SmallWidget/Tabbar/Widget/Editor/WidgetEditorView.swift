//
//  WidgetEditorView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/9.
//

import SwiftUI
import CoreData
import HandyJSON


// 底部编辑列表
struct EditorList : View {
    
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    @Binding var isShowBottomButton: Bool
    @State private var isNextPageActive = false
    @State var selectedImage: UIImage?
    
    // 要切换的tabbar
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    
    @inlinable init(config: JRWidgetConfigure, isShowBottomButton: Binding<Bool>, tabSelected: Binding<Tab>, widgetSelected: Binding<Int>) {
        self.config = config
        self._isShowBottomButton = isShowBottomButton
        self._tabSelected = tabSelected
        self._widgetSelected = widgetSelected
    }
    
    var body: some View {
         
        VStack(spacing: ViewLayout.S_W_20()) {
            Spacer(minLength: ViewLayout.S_W_2())
            if WidgetType(rawValue: config.nameConfig!.widgetType) == .todo {
                EditorTodoList(config: config)
            } else if WidgetType(rawValue: config.nameConfig!.widgetType) == .anniversary {
                if config.isNeedItemEditCount == 3 {
                    EditorMatter(config: config, isType: .item_0)
                    EditorTextColor(config: config, textColorTag: .item_0)
                    EditorTextFont(config: config, textFontTag: .item_0)
                    EditorAnniversary(config: config, pickDate: [config.itemConfig_0.textDate.components(separatedBy: "-")[0], config.itemConfig_0.textDate.components(separatedBy: "-")[1], config.itemConfig_0.textDate.components(separatedBy: "-")[2]], isType: .item_0)
                    
                    EditorMatter(config: config, isType: .item_1)
                    EditorTextColor(config: config, textColorTag: .item_1)
                    EditorTextFont(config: config, textFontTag: .item_1)
                    EditorAnniversary(config: config, pickDate: [config.itemConfig_1.textDate.components(separatedBy: "-")[0], config.itemConfig_1.textDate.components(separatedBy: "-")[1], config.itemConfig_1.textDate.components(separatedBy: "-")[2]], isType: .item_1)
                    
                    EditorMatter(config: config, isType: .item_2)
                    EditorTextColor(config: config, textColorTag: .item_2)
                    EditorTextFont(config: config, textFontTag: .item_2)
                    EditorAnniversary(config: config, pickDate: [config.itemConfig_2.textDate.components(separatedBy: "-")[0], config.itemConfig_2.textDate.components(separatedBy: "-")[1], config.itemConfig_2.textDate.components(separatedBy: "-")[2]], isType: .item_2)
                } else if config.isNeedItemEditCount == 2 {
                    EditorMatter(config: config, isType: .item_0)
                    EditorTextColor(config: config, textColorTag: .item_0)
                    EditorTextFont(config: config, textFontTag: .item_0)

                    EditorMatter(config: config, isType: .item_1)
                    EditorTextColor(config: config, textColorTag: .item_1)
                    EditorTextFont(config: config, textFontTag: .item_1)
                    EditorAnniversary(config: config, pickDate: [config.itemConfig_0.textDate.components(separatedBy: "-")[0], config.itemConfig_0.textDate.components(separatedBy: "-")[1], config.itemConfig_0.textDate.components(separatedBy: "-")[2]], isType: .item_0)
                } else {
                    EditorMatter(config: config, isType: .item_0)
                    EditorTextColor(config: config, textColorTag: .item_0)
                    EditorTextFont(config: config, textFontTag: .item_0)
                    EditorAnniversary(config: config, pickDate: [config.itemConfig_0.textDate.components(separatedBy: "-")[0], config.itemConfig_0.textDate.components(separatedBy: "-")[1], config.itemConfig_0.textDate.components(separatedBy: "-")[2]], isType: .item_0)
                }
            } else if WidgetType(rawValue: config.nameConfig!.widgetType) == .imageAndWall {
                if config.fillingImageCount == 1 {
                    EditorImage(config: config, selectedTag: 0) { isNextPageActive = true }
                } else if config.fillingImageCount == 2 {
                    HStack (spacing: ViewLayout.SWidth(0)) {
                        EditorImage(config: config, selectedTag: 0) { isNextPageActive = true }
                        EditorImage(config: config, selectedTag: 1) { isNextPageActive = true }
                    }
                } else if config.fillingImageCount == 3 {
                    HStack (spacing: ViewLayout.SWidth(0)) {
                        HStack (alignment: .center, spacing: ViewLayout.SWidth(0)) {
                            EditorImage(config: config, selectedTag: 0) { isNextPageActive = true }
                            EditorImage(config: config, selectedTag: 1) { isNextPageActive = true }
                            EditorImage(config: config, selectedTag: 2) { isNextPageActive = true }
                        }
                    }
                }
             }
            if config.isNeedTextChangeEdit == 1 {
                EditorMatter(config: config, isType: .item_0)
            }
            if config.isNeedTextColorEdit == 1 {
                EditorTextColor(config: config)
                EditorTextFont(config: config)
            }
            if config.isNeedBackgroudColorEdit == 1 {
                EditorBackground(config: config)
            }
            // 获取到图片自动跳转
            NavigationLink(destination: EditorImageDynamic(config: config, tabSelected: $tabSelected, widgetSelected: $widgetSelected), isActive: $isNextPageActive) {
            }
        }
        .padding([.leading, .trailing], ViewLayout.S_W_20())
        .onAppear {
            if config.fillingImageCount == 1 {
                if config.fillingImageStringArray[0]?.count ?? 0 > 0 {
                    isShowBottomButton = true
                } else {
                    isShowBottomButton = false
                }
            } else if config.fillingImageCount == 2 {
                if (config.fillingImageStringArray[0]?.count ?? 0 > 0) && (config.fillingImageStringArray[1]?.count ?? 0 > 0) {
                    isShowBottomButton = true
                } else {
                    isShowBottomButton = false
                }
            } else if config.fillingImageCount == 3 {
                if (config.fillingImageStringArray[0]?.count ?? 0 > 0) && (config.fillingImageStringArray[1]?.count ?? 0 > 0) && (config.fillingImageStringArray[2]?.count ?? 0 > 0){
                    isShowBottomButton = true
                } else {
                    isShowBottomButton = false
                }
            }
        }
    }
}



struct WidgetEditorView: View {
        
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    @StateObject var viewModel = ContentViewModel()
    
    // 持续化对象
    @Environment(\.managedObjectContext) private var viewContext
    
    // 获取数据，可以加条件
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WidgetConfigure.name, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<WidgetConfigure>
            
    var snapCarouselStyle: SnapCarouselStyle = .default

    @State private var showInsterAds: Bool = true
    @State private var isNextPageActive = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // 要切换的tabbar
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    // 是否显示底部确认按钮
    @State var isShowBottomButton: Bool = true
    @State var lightModel: Bool = false

    @State private var showVIPSheet = false
    @ObservedObject var payConfig = PayConfig.shared

    @State private var showWebView = false

    init (tabSelected: Binding<Tab>, widgetSelected:Binding<Int>, configure: JRWidgetConfigure) {
        self.config = configure
        self._tabSelected = tabSelected
        self._widgetSelected = widgetSelected
        if WidgetSizeType(rawValue: config.nameConfig!.sizeType) == .small {
            self.snapCarouselStyle = SnapCarouselStyle.small
        } else if WidgetSizeType(rawValue: config.nameConfig!.sizeType) == .medium {
            self.snapCarouselStyle = SnapCarouselStyle.medium
        } else if WidgetSizeType(rawValue: config.nameConfig!.sizeType) == .large {
            self.snapCarouselStyle = SnapCarouselStyle.large
        }
    }
    
    var body: some View {
        VStack(alignment: .center,  spacing: ViewLayout.SWidth(20)) {
            // 顶部绘制区
            VStack(alignment: .center,  spacing: 0) {
                // 展示目标视图
                VStack (spacing: 0) {
                    widgitEditView()
                    // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                        .overlay {
//                            if config.isVIP == 1 {
//                                HStack (spacing: 0) {
//                                    Spacer()
//                                    VStack (spacing: 0) {
//                                        Image("widget_vip_icon")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: ViewLayout.S_W_10() * 6, height: ViewLayout.S_W_10() * 6, alignment: .center)
//                                        Spacer()
//                                    }
//                                }
//                                .offset(x: ViewLayout.S_W_10() * 2, y: -ViewLayout.S_W_10() * 2)
//                            }
//                        }
                }
                .frame(height: (config.nameConfig?.sizeType == 2) ? (ViewLayout.S_W_40() * 8) : (ViewLayout.S_W_40() * 5), alignment: .center)
                
                // 编辑选项
                ScrollView(.vertical, showsIndicators: false) {
                    EditorList(config: config, isShowBottomButton: $isShowBottomButton, tabSelected: $tabSelected, widgetSelected: $widgetSelected)
                }
                .background(Color.Color_FFFFFF)
                .cornerRadius(ViewLayout.S_W_30(), corners: [.topLeft, .topRight])
            }
            .background(Color.Color_F6F6F6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .overlay {
//                FloatingDragView {
//                    self.showWebView = true
//                }
//            }
            // 确认button
            if isShowBottomButton {
                HStack (alignment: .center, spacing: 0) {
                    Spacer()
                    Rectangle()
                        .fill(Color.Color_8682FF)
                        .frame(width:ViewLayout.S_W_50() * 4, height: ViewLayout.S_W_50())
                        .cornerRadius(ViewLayout.S_W_10())
                        .overlay {
                            HStack () {
                                Text("Save Widget")
                                    .foregroundColor(.white)
                                    .font(.S_Pro_16(.medium))
                                // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                                if (config.isVIP == 1) && !payConfig.isPaied {
//                                    Image("pay_vip_icon")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: ViewLayout.S_W_30(), height: ViewLayout.S_W_30(), alignment: .center)
//                                }
                            }
                        }
                        .onTapGesture {
                            // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                            if (config.isVIP == 1) && !payConfig.isPaied {
//                                showVIPSheet = true
//                            } else {
//                                saveWidgetConfigure()
//                            }
                            saveWidgetConfigure()
                        }
                    Spacer()
                }
            }
            // 点击底部跳转按钮- 图片设置除外
            NavigationLink(destination: WidgetEditorStatus(tabSelected: $tabSelected, widgetSelected: $widgetSelected), isActive: $isNextPageActive) {
            }
        }
        .navigationTitle(config.nameConfig!.orialName)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Color_FFFFFF)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(viewBlock: {
            withAnimation(nil) {
                presentationMode.wrappedValue.dismiss()
            }
        }, lightModel: $lightModel))
        .presentInterstitialAd(isPresented: $showInsterAds, adModel: FirebaseNetwork.shared.loadInterstitialAdViewModel().0, showedBlock: {
            showInsterAds = false
        })
        .fullScreenCover(isPresented: $showVIPSheet) {
            VIPDetailView(dismissBlock: {
                
            })
            .background(BackgroundClearView())
        }
        .sheet(isPresented: $showWebView) {
            SafariView(url: URL(string: "https://baidu.com/")!, onDismiss: {
                print("Safari View dismissed.")
            })
        }
        .toolbarBackground(.white, for: .navigationBar)
    }
    
    
    func widgitEditView() -> some View {
        return HStack (alignment: .center) {
            // MARK: - 独立创建时，config的地址没有变，所以不会重新创建，这里需要转化一次,改变config的地址
            config.nameConfig!.viewName?.getWidgetView(ui: JRWidgetConfigureStatic.widgetConfig(JRWidgetConfigureStatic.staticJRWidgetConfig(config), isInLayout: (config.nameConfig?.widgetType == WidgetType.battery.rawValue ? 1 : 0) ))
        }
        .frame(width: config.nameConfig?.sizeType == 0 ? snapCarouselStyle.cardWidth * 1.5 :  snapCarouselStyle.cardWidth * 1.5, height: config.nameConfig?.sizeType == 0 ? snapCarouselStyle.cardHeight * 1.5 :  snapCarouselStyle.cardHeight * 1.5)
        .cornerRadius(ViewLayout.SWidth(10))
    }
    
    func saveWidgetConfigure() {
        let newItem = WidgetConfigure(context: viewContext)
        newItem.name = config.nameConfig?.viewName
        newItem.id = Int32(Int(Date().timeIntervalSince1970))
        newItem.type =  String(format: "%d", config.nameConfig?.widgetType ?? -1)
        newItem.size = Int16(config.nameConfig?.sizeType ?? 0)
        newItem.widgetUi = WidgetUi(context: viewContext)
        newItem.widgetUi?.background = config.backgroundColor
        newItem.widgetUi?.color = Int16(0x000000)
        newItem.widgetUi?.configString = JRWidgetConfigureStatic.staticJRWidgetConfig(config).toJSONString()
        newItem.widgetUi?.isLocal = "1"
        if let uiImage = ImageRenderer(content: widgitEditView()).uiImage {
            if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                newItem.imageData = imageData
            }
        }
        if let viewName = config.nameConfig?.viewName {
            let num = fentchItemCount(viewName: viewName)
            newItem.showName = "\(config.nameConfig?.orialName ?? "Widget") #\(num)"
        }
        do {
            try viewContext.save()
            isNextPageActive.toggle()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fentchItemCount(viewName: String) -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = WidgetConfigure.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(WidgetConfigure.name), viewName)
        request.predicate = predicate
        do {
            let count = try viewContext.count(for: request)
            return count
        } catch {
            print("Error fetching item count: \(error)")
            return 0
        }
    }
}
