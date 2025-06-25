//
//  AnimatedArcGIFView.swift
//  SmallWidget
//
//  Created by nan on 2025/6/24.
//

import SwiftUI
import ClockHandRotationKit


// 使用
/**
 
 VStack() {
     Text("不")
         .foregroundColor(.blue)
 }
 .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
 .background(
     AnimatedArcGIFView(gifName: "animation_3", defaultImageName: "", maxFrameCount: 15)
 )
 
 */

// MARK: - Arc 遮罩 Shape
struct ArcShape: Shape {
    var startAngle: Double
    var endAngle: Double
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: radius,
                    startAngle: .degrees(startAngle),
                    endAngle: .degrees(endAngle),
                    clockwise: false)
        return path
    }
}

// MARK: - GIF 解码器（同步/异步）
struct GIFDecoder {
    static func decode(fromBundle name: String, maxFrames: Int = 12) async -> (images: [UIImage], duration: TimeInterval)? {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let result = UIImage.decodeGIF(data) else {
            return nil
        }

        let total = result.images.count
        guard total > 0 else { return nil }

        // 计算采样步长
        let step = max(1, total / maxFrames)
        let sampled = stride(from: 0, to: total, by: step).map { result.images[$0] }
        let durationPerFrame = result.duration / Double(total)
        let sampledDuration = durationPerFrame * Double(sampled.count)

        return (sampled, sampledDuration)
    }
}

// MARK: - 主视图：优化版动画 View
struct AnimatedArcGIFView: View {
    let gifName: String
    let defaultImageName: String
    var maxFrameCount = 12

    @State private var frames: [UIImage] = []
    @State private var duration: TimeInterval = 1

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let width = max(size.width, size.height)
            let radius = width * width
            let anglePerFrame = 360.0 / Double(frames.count)

            ZStack {
                if frames.isEmpty {
                    Image(systemName: defaultImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    ForEach(0..<frames.count, id: \.self) { i in
                        Image(uiImage: frames[i])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .mask(
                                ArcShape(startAngle: anglePerFrame * Double(i),
                                         endAngle: anglePerFrame * Double(i + 1),
                                         radius: radius)
                                .stroke(style: StrokeStyle(lineWidth: width * 1.1))
                                .frame(width: size.width, height: size.height)
                                .clockHandRotationEffect(period: .custom(duration))
                                .offset(y: radius) // ⚠️ 必须 offset 让旋转形成轨迹
                            )
                    }
                }
            }
            .frame(width: size.width, height: size.height)
        }
        .task {
            if let result = await GIFDecoder.decode(fromBundle: gifName, maxFrames: maxFrameCount) {
                self.frames = result.images
                self.duration = result.duration
            }
        }
    }
}
