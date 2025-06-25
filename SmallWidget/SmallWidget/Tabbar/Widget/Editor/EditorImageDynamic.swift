//
//  EditorImageDynamic.swift
//  SmallWidget
//
//  Created by Q801 on 2024/3/11.
//

import SwiftUI
import CoreData
import HandyJSON


struct EditorImageDynamic: View {
        
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    @StateObject var viewModel = ContentViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    // 持续化对象
    @Environment(\.managedObjectContext) private var viewContext
        
    // 获取数据，可以加条件
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WidgetConfigure.name, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<WidgetConfigure>
    @State private var isNextPageActive = false

    var snapCarouselStyle: SnapCarouselStyle = .default
    let leftRightSpacing = ViewLayout.SWidth(60)
           
    // 要切换的tabbar
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    @State var lightModel: Bool = false

    @State private var showVIPSheet = false
    @ObservedObject var payConfig = PayConfig.shared

    
    var body: some View {
        VStack(alignment: .center,  spacing: ViewLayout.SWidth(20)) {
            Spacer()
            // 顶部绘制区
            VStack(alignment: .center,  spacing: 0) {
                // 展示目标视图
                widgitEditView(isShowEdit: true)
                // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                    .overlay {
//                        if config.isVIP == 1 {
//                            HStack (spacing: 0) {
//                                Spacer()
//                                VStack (spacing: 0) {
//                                    Image("widget_vip_icon")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: ViewLayout.S_W_10() * 6, height: ViewLayout.S_W_10() * 6, alignment: .center)
////                                            .background(.green)
//                                    Spacer()
//                                }
//                            }
//                            .offset(x: ViewLayout.S_W_10() * 2, y: -ViewLayout.S_W_10() * 2)
//                        }
//                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // 中间选择照片区域
            VStack (alignment: .center, spacing: ViewLayout.SWidth(20)) {
                Spacer()
                HStack (alignment: .center, spacing: ViewLayout.SWidth(20)) {
                    Spacer()
                    Spacer()
                }
                .frame(maxHeight: ViewLayout.SWidth(50))
                Spacer()
            }
            // 确认button
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
//                            if (config.isVIP == 1) && !payConfig.isPaied {
//                                Image("pay_vip_icon")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: ViewLayout.S_W_30(), height: ViewLayout.S_W_30(), alignment: .center)
//                            }
                        }
                    }
                    .onTapGesture {
                        // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                        if (config.isVIP == 1) && !payConfig.isPaied {
//                            showVIPSheet = true
//                        } else {
//                            saveWidgetConfigure()
//                        }
                        saveWidgetConfigure()
                    }
                Spacer()
            }
            
            // 点击跳转
            NavigationLink(destination: WidgetEditorStatus(tabSelected: $tabSelected, widgetSelected: $widgetSelected), isActive: $isNextPageActive) {
            }
        }
        .navigationTitle(config.nameConfig!.orialName)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Color_F6F6F6)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(viewBlock: {
            withAnimation(nil) {
                presentationMode.wrappedValue.dismiss()
            }
        }, lightModel: $lightModel))
        .fullScreenCover(isPresented: $showVIPSheet) {
            VIPDetailView(dismissBlock: {
                
            })
            .background(BackgroundClearView())
        }
        .toolbarBackground(.white, for: .navigationBar)
    }
    
    func widgitEditView(isShowEdit: Bool) -> some View {
        VStack (alignment: .center, spacing: 0) {
//            AnyView(PhotoConfig(widgetFamily: 0, configure: config).imageEditItemView(configure: config, isShowEdit: true))
        }
        .frame(width: config.nameConfig?.sizeType == 0 ? snapCarouselStyle.cardWidth * 3 :  (UIScreen.main.bounds.width - ViewLayout.SWidth(30) * 2), height: config.nameConfig?.sizeType == 0 ? snapCarouselStyle.cardHeight * 3 :  (UIScreen.main.bounds.width - ViewLayout.SWidth(30) * 2) / 2)
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
        // 这里下面的图层经过Mark后，获取到的不见选择的相册图片，所以在选择组件列表页面，看不到选择后的图片，只能看到框架配图
        if let uiImage = ImageRenderer(content: widgitEditView(isShowEdit: false)).uiImage {
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






