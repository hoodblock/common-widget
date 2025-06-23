//
//  PhotoWavePointBox.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/27.
//

import SwiftUI
import WidgetKit
import CoreGraphics



struct PhotoWavePointBoxSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    @State var imageName: String = ""
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.imageAndWall, .small)

        // name
        self.configure?.nameConfig?.viewName = "PhotoWavePointBoxSmall"
        self.configure?.nameConfig?.orialName = "Wave Point Box"
        self.configure?.nameConfig?.typeName = "Wave Point Box"
        self.configure?.backgroundColor = Color.String_Color_FFFFFF
        self.configure?.fillingImageCount = 1
        self.configure?.isNeedTextColorEdit = 0
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                ZStack (alignment: .center) {
                    if self.configure?.fillingImageStringArray.count ?? 0 <= 0 {
                        Image("photo_small_34")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        AnyView(PhotoConfig(widgetFamily: 0, configure: configure).imageEditItemView(configure: configure, isShowEdit: false))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


//

struct PhotoWavePointBoxMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    @State var imageName: String = ""
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.imageAndWall, .medium)

        // name
        self.configure?.nameConfig?.viewName = "PhotoWavePointBoxMedium"
        self.configure?.nameConfig?.orialName = "Wave Point Box"
        self.configure?.nameConfig?.typeName = "Wave Point Box"
        self.configure?.backgroundColor = Color.String_Color_FFFFFF
        self.configure?.isNeedTextColorEdit = 0
        self.configure?.fillingImageCount = 1
        self.configure?.fillingImageClipType = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View{
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                ZStack (alignment: .center) {
                    if self.configure?.fillingImageStringArray.count ?? 0 <= 0 {
                        Image("photo_medium_34")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        AnyView(PhotoConfig(widgetFamily: 0, configure: configure).imageEditItemView(configure: configure, isShowEdit: false))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


// MARK: - 编辑图片

struct PhotoWavePointBoxSmall_Fill_Image: View {
    
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
        
        // 手势 (实现单指拖动手势 + 中心旋转)
        // 实现单指拖动手势 + 中心旋转 实现不了，两个都是中心点位置变化，会有冲突，只能实现其一，那就实现旋转
//        let dragWithRotatePointGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local).simultaneously(with: RotationGesture())
//                                                                        .updating($gestureValue, body: { value, State, Transaction in
//                                                                            State.offset = value.first?.location ?? CGPoint(x: 0, y: 0)
//                                                                            State.rotationAngle = value.second ?? .zero
//                                                                        })
//                                                                        .onChanged { value in
//                                                                            config.imageRotateAndMagnify_0.offset = value.first?.location ?? CGPoint(x: 0, y: 0)
//                                                                            .degrees(config.imageRotateAndMagnify_0.rotationDouble) = value.second ?? .zero
//                                                                        }
        
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
                    
                    Rectangle()
                        .fill(Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .mask {
                            holeShapeMask(viewRect: CGRect(origin: CGPoint(x: 0, y: 0), size: geo.size), holeRect: clipImageFrame)
                        }
                    Image("photo_small_34")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .clipped()
            }
            .onAppear(perform: {
                // w:h = 1.3
                self.clipImageFrame = CGRect(x: geo.size.width * 0, y: geo.size.height * 0, width: geo.size.width, height: geo.size.height)
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

struct PhotoWavePointBoxMedium_Fill_Image: View {
    
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
        
        // 手势 (实现单指拖动手势 + 中心旋转)
        // 实现单指拖动手势 + 中心旋转 实现不了，两个都是中心点位置变化，会有冲突，只能实现其一，那就实现旋转
//        let dragWithRotatePointGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local).simultaneously(with: RotationGesture())
//                                                                        .updating($gestureValue, body: { value, State, Transaction in
//                                                                            State.offset = value.first?.location ?? CGPoint(x: 0, y: 0)
//                                                                            State.rotationAngle = value.second ?? .zero
//                                                                        })
//                                                                        .onChanged { value in
//                                                                            config.imageRotateAndMagnify_0.offset = value.first?.location ?? CGPoint(x: 0, y: 0)
//                                                                            .degrees(config.imageRotateAndMagnify_0.rotationDouble) = value.second ?? .zero
//                                                                        }
       
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
                    
                    Rectangle()
                        .fill(Color.color(hexString: config.backgroundColor ?? Color.String_Color_FFFFFF))
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .mask {
                            holeShapeMask(viewRect: CGRect(origin: CGPoint(x: 0, y: 0), size: geo.size), holeRect: clipImageFrame)
                        }
                    
                    Image("photo_medium_34")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                  
                }
                .clipped()
            }
            .onAppear(perform: {
                // w:h = 1.3
                self.clipImageFrame = CGRect(x: geo.size.width * 0.05, y: geo.size.height * 0.1, width: geo.size.width * 0.9, height: geo.size.height * 0.8)
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






