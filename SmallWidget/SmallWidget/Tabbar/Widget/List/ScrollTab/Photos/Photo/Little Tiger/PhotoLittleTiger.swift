//
//  PhotoLittleTiger.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/27.
//

import SwiftUI
import WidgetKit
import CoreGraphics


struct PhotoLitttleTigerSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    @State var imageName: String = ""
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        
        if !((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            self.configure = WidgetViewConfig.widgetViewConfig(.imageAndWall, .small)
            self.configure?.nameConfig?.viewName = "PhotoLitttleTigerSmall"
            self.configure?.nameConfig?.orialName = "Little Tiger Phone Wall"
            self.configure?.nameConfig?.typeName = "Little Tiger Phone Wall"
            self.configure?.backgroundColor = Color.String_Color_FFD978
            self.configure?.isNeedTextColorEdit = 0
            self.configure?.fillingImageClipType = 0
            self.configure?.fillingImageCount = 1
            self.configure?.isVIP = 1
        }
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
   
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                ZStack (alignment: .center) {
                    if self.configure?.fillingImageStringArray.count ?? 0 <= 0 {
                        Image("photo_small_30")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        AnyView(PhotoConfig(widgetFamily: 0, configure: configure).imageEditItemView(configure: configure, isShowEdit: false))
                    }
                }
                .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


// 
struct PhotoLitttleTigerMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    @State var imageName: String = ""

    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.imageAndWall, .medium)
        // name
        self.configure?.nameConfig?.viewName = "PhotoLitttleTigerMedium"
        self.configure?.nameConfig?.orialName = "Little Tiger Phone Wall"
        self.configure?.nameConfig?.typeName = "Little Tiger Phone Wall"
        self.configure?.backgroundColor = Color.String_Color_FFD978
        self.configure?.isNeedTextColorEdit = 0
        self.configure?.fillingImageCount = 2
        self.configure?.fillingImageClipType = 1

    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                ZStack (alignment: .center, content: {
                    if self.configure?.fillingImageStringArray.count ?? 0 <= 0 {
                        HStack (alignment: .center, spacing: SWidth(20, geo.size.height)) {
                            ZStack (alignment: .center) {
                                Image("photo_small_30")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            //
                            ZStack (alignment: .center) {
                                Image("photo_medium_30")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    } else {
                        AnyView(PhotoConfig(widgetFamily: 0, configure: configure).imageEditItemView(configure: configure, isShowEdit: false))
                    }
                })
                .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


// MARK: - 编辑图片

struct PhotoLitttleTigerSmall_Fill_Image: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改

    static func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    @State var clipImageFrame: CGRect = .zero
    @State var scaleSelectedImageSize: CGSize = .zero
    @State var isShowEdit: Bool
    
    // 旋转属性
    @GestureState(resetTransaction: .init(animation: .easeInOut)) var gestureValue = ImageRotateAndMagnify()
    
    var body: some View {
        // 双指手势 (自定义实现双指放大和旋转)
        let rotateAndMagnifyDoublePointGesture = MagnificationGesture().simultaneously(with: RotationGesture())
                                                                       .updating($gestureValue, body: { value, State, Transaction in
                                                                           State.scale = value.first ?? 1.0
                                                                           State.rotationDouble = value.second?.degrees ?? 0.00
                                                                       })
                                                                       .onChanged { value in
                                                                           config.imageRotateAndMagnify_0.rotationDouble = value.second?.degrees ?? 0.00
                                                                           config.imageRotateAndMagnify_0.scale = value.first ?? 1.0
                                                                           config.backgroundColor = config.backgroundColor
                                                                       }
    
        // 手势 (实现单指中心旋转)
        let rotatePointGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local)
                                                                        .updating($gestureValue, body: { value, State, Transaction in
                                                                            if State.rotationStartLocation_x == 0 && State.rotationStartLocation_y == 0 {
                                                                                State.rotationStartLocation_x = value.location.x
                                                                                State.rotationStartLocation_y = value.location.y
                                                                            }
                                                                            let diffX = value.location.x - State.rotationStartLocation_x
                                                                            let diffY = value.location.y - State.rotationStartLocation_y
                                                                            let angle = atan2(diffY, diffX) * 180 / .pi
                                                                            State.rotationDouble = angle
                                                                        })
                                                                        .onChanged { value in
                                                                            if config.imageRotateAndMagnify_0.rotationStartLocation_x == 0 && config.imageRotateAndMagnify_0.rotationStartLocation_y == 0 {
                                                                                config.imageRotateAndMagnify_0.rotationStartLocation_x = value.location.x
                                                                                config.imageRotateAndMagnify_0.rotationStartLocation_y = value.location.y
                                                                            }
                                                                            let diffX = value.location.x - config.imageRotateAndMagnify_0.rotationStartLocation_x
                                                                            let diffY = value.location.y - config.imageRotateAndMagnify_0.rotationStartLocation_y
                                                                            let angle = atan2(diffY, diffX) * 180 / .pi
                                                                            config.imageRotateAndMagnify_0.rotationDouble = angle
                                                                            config.backgroundColor = config.backgroundColor
                                                                        }
        
        
        // 手势 (实现单指移动)
        let movePointGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local)
                                                                        .updating($gestureValue, body: { value, State, Transaction in
                                                                             // 手指按下的位置
                                                                             // let startPoint = value.startLocation
                                                                             // 相对于手指的偏移量
                                                                             // let movePoint = value.location
                                                                            State.offset_x = value.location.x - value.startLocation.x
                                                                            State.offset_y = value.location.y - value.startLocation.y
                                                                         })
                                                                         .onChanged { value in
                                                                             config.imageRotateAndMagnify_0.offset_x = value.location.x - value.startLocation.x
                                                                             config.imageRotateAndMagnify_0.offset_y = value.location.y - value.startLocation.y
                                                                             config.backgroundColor = config.backgroundColor
                                                                         }
        
        
        GeometryReader(content: { geo in
            // 图层
            Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                ZStack (alignment: .center) {
                    // 选择的图片
                    Image(uiImage: UIImage(data: Data(base64Encoded: config.fillingImageStringArray[0] ?? "") ?? Data()) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: (clipImageFrame.origin.x + clipImageFrame.width / 2 - geo.size.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height), y: (clipImageFrame.origin.y + clipImageFrame.height / 2 - geo.size.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height))
                        .scaleEffect(config.imageRotateAndMagnify_0.scale)
                        .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                        .background {
                            GeometryReader { proxy in
                                let geoSize = proxy.size
                                Color.clear.ignoresSafeArea(.all)
                                    .onAppear {
                                        scaleSelectedImageSize = geoSize
                                    }
                                    .onChange(of: geoSize) { newValue in
                                        scaleSelectedImageSize = newValue
                                    }
                            }
                        }
                        .mask {
                            Ellipse()
                                .frame(width: geo.size.width * 0.8, height: geo.size.height)
                        }
                    Rectangle()
                        .fill(Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .mask {
                            holeShapeMask(viewRect: CGRect(origin: CGPoint(x: 0, y: 0), size: geo.size), holeRect: clipImageFrame)
                        }
                    // 覆盖图片
                    Image("photo_small_30")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .clipped()
            }
            .onAppear(perform: {
                self.clipImageFrame = CGRect(x: geo.size.width * 0.11, y: geo.size.height * 0.11, width: geo.size.width * 0.78, height: geo.size.height * 0.78)
            })

            // 可以操作的上部边框实体
            if isShowEdit {
                Color.clear.overlay(alignment: .center) {
                    ZStack (alignment: .center) {
                        // 线框
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.Color_000000, lineWidth: 1)
                            .frame(width: scaleSelectedImageSize.width, height: scaleSelectedImageSize.height)
                            .offset(x: (clipImageFrame.origin.x + clipImageFrame.width / 2 - geo.size.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height), y: (clipImageFrame.origin.y + clipImageFrame.height / 2 - geo.size.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height))
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                            .scaleEffect(config.imageRotateAndMagnify_0.scale)
                            .background(content: {
                                // 设置空心体的背景色，让其可以添加手势
                                Color.white.opacity(0.01)
                            })
                            .gesture(rotateAndMagnifyDoublePointGesture)

                        // 删除按钮，并退出当前编辑界面
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("editor_close_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                        }
                        .offset(x: ((clipImageFrame.origin.x + clipImageFrame.width / 2 - geo.size.width / 2) - (scaleSelectedImageSize.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height)) * config.imageRotateAndMagnify_0.scale, y: ((clipImageFrame.origin.y + clipImageFrame.height / 2 - geo.size.height / 2) - (scaleSelectedImageSize.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height)) * config.imageRotateAndMagnify_0.scale)
                        .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                        
                        // 旋转按钮
                        Image("editor_rote_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                            .offset(x: ((clipImageFrame.origin.x + clipImageFrame.width / 2 - geo.size.width / 2) + (scaleSelectedImageSize.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height)) * config.imageRotateAndMagnify_0.scale, y: ((clipImageFrame.origin.y + clipImageFrame.height / 2 - geo.size.height / 2) - (scaleSelectedImageSize.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height)) * config.imageRotateAndMagnify_0.scale)
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                            .gesture(rotatePointGesture)
                         
                        // 拉伸拖动按钮
                        Image("editor_scre_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                            .offset(x: ((clipImageFrame.origin.x + clipImageFrame.width / 2 - geo.size.width / 2) + (scaleSelectedImageSize.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height)) * config.imageRotateAndMagnify_0.scale, y: ((clipImageFrame.origin.y + clipImageFrame.height / 2 - geo.size.height / 2) + (scaleSelectedImageSize.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height)) * config.imageRotateAndMagnify_0.scale)
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                            .gesture(movePointGesture)

                    }
                    .background(Color.white.opacity(0.01))
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func holeShapeMask(viewRect: CGRect, holeRect: CGRect) -> some View {
        let holeView: any View
        var shape = Rectangle().path(in: viewRect)
        shape.addPath(Rectangle().path(in: holeRect))
        holeView = shape.fill(style: FillStyle(eoFill: true))
        return AnyView(holeView)
    }

}



// MARK: - 编辑图片

struct PhotoLitttleTigerMedium_Fill_Image: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改

    static func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    @State var clipImageFrame_0: CGRect = .zero
    @State var scaleSelectedImageSize_0: CGSize = .zero
    @State var clipImageFrame_1: CGRect = .zero
    @State var scaleSelectedImageSize_1: CGSize = .zero
    @State var isShowEdit: Bool
    
    // 旋转属性
    @GestureState(resetTransaction: .init(animation: .easeInOut)) var gestureValue_0 = ImageRotateAndMagnify()
    @GestureState(resetTransaction: .init(animation: .easeInOut)) var gestureValue_1 = ImageRotateAndMagnify()

    var body: some View {
        // 一
        // 双指手势 (自定义实现双指放大和旋转)
        let rotateAndMagnifyDoublePointGesture_0 = MagnificationGesture().simultaneously(with: RotationGesture())
                                                                       .updating($gestureValue_0, body: { value, State, Transaction in
                                                                           State.scale = value.first ?? 1.0
                                                                           State.rotationDouble = value.second?.degrees ?? 0.00
                                                                       })
                                                                       .onChanged { value in
                                                                           config.imageRotateAndMagnify_0.rotationDouble = value.second?.degrees ?? 0.00
                                                                           config.imageRotateAndMagnify_0.scale = value.first ?? 1.0
                                                                           config.backgroundColor = config.backgroundColor
                                                                       }
        
        // 手势 (实现单指中心旋转)
        let rotatePointGesture_0 = DragGesture(minimumDistance: 1, coordinateSpace: .local)
                                                                        .updating($gestureValue_0, body: { value, State, Transaction in
                                                                            if State.rotationStartLocation_x == 0 && State.rotationStartLocation_y == 0 {
                                                                                State.rotationStartLocation_x = value.location.x
                                                                                State.rotationStartLocation_y = value.location.y
                                                                            }
                                                                            let diffX = value.location.x - State.rotationStartLocation_x
                                                                            let diffY = value.location.y - State.rotationStartLocation_y
                                                                            let angle = atan2(diffY, diffX) * 180 / .pi
                                                                            State.rotationDouble = angle
                                                                        })
                                                                        .onChanged { value in
                                                                            if config.imageRotateAndMagnify_0.rotationStartLocation_x == 0 && config.imageRotateAndMagnify_0.rotationStartLocation_y == 0 {
                                                                                config.imageRotateAndMagnify_0.rotationStartLocation_x = value.location.x
                                                                                config.imageRotateAndMagnify_0.rotationStartLocation_y = value.location.y
                                                                            }
                                                                            let diffX = value.location.x - config.imageRotateAndMagnify_0.rotationStartLocation_x
                                                                            let diffY = value.location.y - config.imageRotateAndMagnify_0.rotationStartLocation_y
                                                                            let angle = atan2(diffY, diffX) * 180 / .pi
                                                                            config.imageRotateAndMagnify_0.rotationDouble = angle
                                                                            config.backgroundColor = config.backgroundColor
                                                                        }
        
        // 手势 (实现单指移动)
        let movePointGesture_0 = DragGesture(minimumDistance: 1, coordinateSpace: .local)
                                                                        .updating($gestureValue_0, body: { value, State, Transaction in
                                                                             // 手指按下的位置
                                                                             // let startPoint = value.startLocation
                                                                             // 相对于手指的偏移量
                                                                             // let movePoint = value.location
                                                                            State.offset_x = value.location.x - value.startLocation.x
                                                                            State.offset_y = value.location.y - value.startLocation.y
                                                                         })
                                                                         .onChanged { value in
                                                                             config.imageRotateAndMagnify_0.offset_x = value.location.x - value.startLocation.x
                                                                             config.imageRotateAndMagnify_0.offset_y = value.location.y - value.startLocation.y
                                                                             config.backgroundColor = config.backgroundColor
                                                                         }
        
        
        // 二
        // 双指手势 (自定义实现双指放大和旋转)
        let rotateAndMagnifyDoublePointGesture_1 = MagnificationGesture().simultaneously(with: RotationGesture())
                                                                       .updating($gestureValue_1, body: { value, State, Transaction in
                                                                           State.scale = value.first ?? 1.0
                                                                           State.rotationDouble = value.second?.degrees ?? 0.00
                                                                       })
                                                                       .onChanged { value in
                                                                           config.imageRotateAndMagnify_1.rotationDouble = value.second?.degrees ?? 0.00
                                                                           config.imageRotateAndMagnify_1.scale = value.first ?? 1.0
                                                                           config.backgroundColor = config.backgroundColor
                                                                       }
        
        // 手势 (实现单指中心旋转)
        let rotatePointGesture_1 = DragGesture(minimumDistance: 1, coordinateSpace: .local)
                                                                        .updating($gestureValue_1, body: { value, State, Transaction in
                                                                            if State.rotationStartLocation_x == 0 && State.rotationStartLocation_y == 0 {
                                                                                State.rotationStartLocation_x = value.location.x
                                                                                State.rotationStartLocation_y = value.location.y
                                                                            }
                                                                            let diffX = value.location.x - State.rotationStartLocation_x
                                                                            let diffY = value.location.y - State.rotationStartLocation_y
                                                                            let angle = atan2(diffY, diffX) * 180 / .pi
                                                                            State.rotationDouble = angle
                                                                        })
                                                                        .onChanged { value in
                                                                            if config.imageRotateAndMagnify_1.rotationStartLocation_x == 0 && config.imageRotateAndMagnify_1.rotationStartLocation_y == 0 {
                                                                                config.imageRotateAndMagnify_1.rotationStartLocation_x = value.location.x
                                                                                config.imageRotateAndMagnify_1.rotationStartLocation_y = value.location.y
                                                                            }
                                                                            let diffX = value.location.x - config.imageRotateAndMagnify_1.rotationStartLocation_x
                                                                            let diffY = value.location.y - config.imageRotateAndMagnify_1.rotationStartLocation_y
                                                                            let angle = atan2(diffY, diffX) * 180 / .pi
                                                                            config.imageRotateAndMagnify_1.rotationDouble = angle
                                                                            config.backgroundColor = config.backgroundColor
                                                                        }
        // 手势 (实现单指移动)
        let movePointGesture_1 = DragGesture(minimumDistance: 1, coordinateSpace: .local)
                                                                        .updating($gestureValue_1, body: { value, State, Transaction in
                                                                             // 手指按下的位置
                                                                             // let startPoint = value.startLocation
                                                                             // 相对于手指的偏移量
                                                                             // let movePoint = value.location
                                                                            State.offset_x = value.location.x - value.startLocation.x
                                                                            State.offset_y = value.location.y - value.startLocation.y
                                                                         })
                                                                         .onChanged { value in
                                                                             config.imageRotateAndMagnify_1.offset_x = value.location.x - value.startLocation.x
                                                                             config.imageRotateAndMagnify_1.offset_y = value.location.y - value.startLocation.y
                                                                             config.backgroundColor = config.backgroundColor
                                                                         }
        
        
        
        GeometryReader(content: { geo in
            // 图层
            Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                HStack (alignment: .center,  spacing: SWidth(20, geo.size.height)) {
                    // 一
                    ZStack (alignment: .center) {
                        Image(uiImage: UIImage(data: Data(base64Encoded: config.fillingImageStringArray[0] ?? "") ?? Data()) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .offset(x: (clipImageFrame_0.origin.x + clipImageFrame_0.width / 2 - geo.size.width / 4) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height), y: (clipImageFrame_0.origin.y + clipImageFrame_0.height / 2 - geo.size.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height))
                            .scaleEffect(config.imageRotateAndMagnify_0.scale)
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                            .background {
                                GeometryReader { proxy in
                                    let geoSize = proxy.size
                                    Color.clear.ignoresSafeArea(.all)
                                        .onAppear {
                                            scaleSelectedImageSize_0 = geoSize
                                        }
                                        .onChange(of: geoSize) { newValue in
                                            scaleSelectedImageSize_0 = newValue
                                        }
                                }
                            }
                            .mask {
                                Ellipse()
                                    .frame(width: geo.size.width / 2 * 0.8 , height: geo.size.height)
                            }
                        Rectangle()
                            .fill(Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .mask {
                                holeShapeMask(viewRect: CGRect(origin: CGPoint(x: 0, y: 0), size: geo.size), holeRect: clipImageFrame_0)
                            }
                        // 覆盖图片
                        Image("photo_small_30")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .clipped()
               
                    // 二
                    ZStack (alignment: .center) {
                        Image(uiImage: UIImage(data: Data(base64Encoded: config.fillingImageStringArray[1] ?? "") ?? Data()) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .offset(x: (clipImageFrame_1.origin.x + clipImageFrame_1.width / 2 - geo.size.width / 4) + SWidth(config.imageRotateAndMagnify_1.offset_x, geo.size.height), y: (clipImageFrame_1.origin.y + clipImageFrame_1.height / 2 - geo.size.height / 2) + SWidth(config.imageRotateAndMagnify_1.offset_y, geo.size.height))
                            .scaleEffect(config.imageRotateAndMagnify_1.scale)
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_1.rotationDouble, geo.size.height)), anchor: .center)
                            .background {
                                GeometryReader { proxy in
                                    let geoSize = proxy.size
                                    Color.clear.ignoresSafeArea(.all)
                                        .onAppear {
                                            scaleSelectedImageSize_1 = geoSize
                                        }
                                        .onChange(of: geoSize) { newValue in
                                            scaleSelectedImageSize_1 = newValue
                                        }
                                }
                            }
                            .mask {
                                Ellipse()
                                    .frame(width: geo.size.width / 2 * 0.8, height: geo.size.height)
                            }
                        Rectangle()
                            .fill(Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .mask {
                                holeShapeMask(viewRect: CGRect(origin: CGPoint(x: 0, y: 0), size: geo.size), holeRect: clipImageFrame_1)
                            }
                        // 覆盖图片
                        Image("photo_medium_30")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .clipped()
                }
            }
            .onAppear(perform: {
                self.clipImageFrame_0 = CGRect(x: geo.size.width * 0.05, y: geo.size.height * 0.14, width: geo.size.width * 0.35, height: geo.size.height * 0.75)
                self.clipImageFrame_1 = CGRect(x: geo.size.width * 0.06, y: geo.size.height * 0.14, width: geo.size.width * 0.35, height: geo.size.height * 0.75)
            })

            // 可以操作的上部边框实体
            if isShowEdit {
                Color.clear.overlay(alignment: .center) {
                    
                    HStack (alignment: .center,  spacing: SWidth(20, geo.size.height)) {
                        // 一
                        ZStack (alignment: .center) {
                            // 填充图层，使其不变形
                            Rectangle()
                                .fill(Color.white.opacity(0.01))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            // 线框
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.Color_000000, lineWidth: 1)
                                .frame(width: scaleSelectedImageSize_0.width, height: scaleSelectedImageSize_0.height)
                                .offset(x: (clipImageFrame_0.origin.x + clipImageFrame_0.width / 2 - geo.size.width / 4) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height), y: (clipImageFrame_0.origin.y + clipImageFrame_0.height / 2 - geo.size.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height))
                                .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                                .scaleEffect(config.imageRotateAndMagnify_0.scale)
                                .background(content: {
                                    // 设置空心体的背景色，让其可以添加手势
                                    Color.white.opacity(0.01)
                                })
                                .gesture(rotateAndMagnifyDoublePointGesture_0)

                            // 删除按钮，并退出当前编辑界面
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("editor_close_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                            }
                            .offset(x: ((clipImageFrame_0.origin.x + clipImageFrame_0.width / 2 - geo.size.width / 4) - (scaleSelectedImageSize_0.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height)) * config.imageRotateAndMagnify_0.scale, y: ((clipImageFrame_0.origin.y + clipImageFrame_0.height / 2 - geo.size.height / 2) - (scaleSelectedImageSize_0.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height)) * config.imageRotateAndMagnify_0.scale)
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                            
                            // 旋转按钮
                            Image("editor_rote_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                .offset(x: ((clipImageFrame_0.origin.x + clipImageFrame_0.width / 2 - geo.size.width / 4) + (scaleSelectedImageSize_0.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height)) * config.imageRotateAndMagnify_0.scale, y: ((clipImageFrame_0.origin.y + clipImageFrame_0.height / 2 - geo.size.height / 2) - (scaleSelectedImageSize_0.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height)) * config.imageRotateAndMagnify_0.scale)
                                .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                                .gesture(rotatePointGesture_0)
                             
                            // 拉伸拖动按钮
                            Image("editor_scre_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                .offset(x: ((clipImageFrame_0.origin.x + clipImageFrame_0.width / 2 - geo.size.width / 4) + (scaleSelectedImageSize_0.width / 2) + SWidth(config.imageRotateAndMagnify_0.offset_x, geo.size.height)) * config.imageRotateAndMagnify_0.scale, y: ((clipImageFrame_0.origin.y + clipImageFrame_0.height / 2 - geo.size.height / 2) + (scaleSelectedImageSize_0.height / 2) + SWidth(config.imageRotateAndMagnify_0.offset_y, geo.size.height)) * config.imageRotateAndMagnify_0.scale)
                                .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_0.rotationDouble, geo.size.height)), anchor: .center)
                                .gesture(movePointGesture_0)

                        }

                        // 二
                        ZStack (alignment: .center) {
                            // 填充图层，使其不变形
                            Rectangle()
                                .fill(Color.white.opacity(0.01))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            // 线框
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.blue, lineWidth: 1)
                                .frame(width: scaleSelectedImageSize_1.width, height: scaleSelectedImageSize_1.height)
                                .offset(x: (clipImageFrame_1.origin.x + clipImageFrame_1.width / 2 - geo.size.width / 4) + SWidth(config.imageRotateAndMagnify_1.offset_x, geo.size.height), y: (clipImageFrame_1.origin.y + clipImageFrame_1.height / 2 - geo.size.height / 2) + SWidth(config.imageRotateAndMagnify_1.offset_y, geo.size.height))
                                .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_1.rotationDouble, geo.size.height)), anchor: .center)
                                .scaleEffect(config.imageRotateAndMagnify_1.scale)
                                .background(content: {
                                    // 设置空心体的背景色，让其可以添加手势
                                    Color.red.opacity(0.05)
                                })
                                .gesture(rotateAndMagnifyDoublePointGesture_1)

                            // 删除按钮，并退出当前编辑界面
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("editor_close_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                            }
                            .offset(x: ((clipImageFrame_1.origin.x + clipImageFrame_1.width / 2 - geo.size.width / 4) - (scaleSelectedImageSize_1.width / 2) + SWidth(config.imageRotateAndMagnify_1.offset_x, geo.size.height)) * config.imageRotateAndMagnify_1.scale, y: ((clipImageFrame_1.origin.y + clipImageFrame_1.height / 2 - geo.size.height / 2) - (scaleSelectedImageSize_1.height / 2) + SWidth(config.imageRotateAndMagnify_1.offset_y, geo.size.height)) * config.imageRotateAndMagnify_1.scale)
                            .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_1.rotationDouble, geo.size.height)), anchor: .center)
                            
                            // 旋转按钮
                            Image("editor_rote_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                .offset(x: ((clipImageFrame_1.origin.x + clipImageFrame_1.width / 2 - geo.size.width / 4) + (scaleSelectedImageSize_1.width / 2) + SWidth(config.imageRotateAndMagnify_1.offset_x, geo.size.height)) * config.imageRotateAndMagnify_1.scale, y: ((clipImageFrame_1.origin.y + clipImageFrame_1.height / 2 - geo.size.height / 2) - (scaleSelectedImageSize_1.height / 2) + SWidth(config.imageRotateAndMagnify_1.offset_y, geo.size.height)) * config.imageRotateAndMagnify_1.scale)
                                .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_1.rotationDouble, geo.size.height)), anchor: .center)
                                .gesture(rotatePointGesture_1)
                             
                            // 拉伸拖动按钮
                            Image("editor_scre_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                .offset(x: ((clipImageFrame_1.origin.x + clipImageFrame_1.width / 2 - geo.size.width / 4) + (scaleSelectedImageSize_1.width / 2) + SWidth(config.imageRotateAndMagnify_1.offset_x, geo.size.height)) * config.imageRotateAndMagnify_1.scale, y: ((clipImageFrame_1.origin.y + clipImageFrame_1.height / 2 - geo.size.height / 2) + (scaleSelectedImageSize_1.height / 2) + SWidth(config.imageRotateAndMagnify_1.offset_y, geo.size.height)) * config.imageRotateAndMagnify_1.scale)
                                .rotationEffect(.degrees(SWidth(config.imageRotateAndMagnify_1.rotationDouble, geo.size.height)), anchor: .center)
                                .gesture(movePointGesture_1)
                        }
                    }
                    .background(Color.white.opacity(0.01))
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func holeShapeMask(viewRect: CGRect, holeRect: CGRect) -> some View {
        let holeView: any View
        var shape = Rectangle().path(in: viewRect)
        shape.addPath(Rectangle().path(in: holeRect))
        holeView = shape.fill(style: FillStyle(eoFill: true))
        return AnyView(holeView)
    }

}
