# common-widget
iOS 日常小组件（SwiftUI）支持时钟，日历，系统面板等小、中、型组件和付费订阅模式
---

📊 界面预览

<h3></h3>
<p align="center">
  <img src="https://github.com/user-attachments/assets/4cce0b22-6bbb-4b0e-aa04-25befccb8903" width="180"/>
  <img src="https://github.com/user-attachments/assets/c4a17385-83af-4a5f-97e9-8547518d7894" width="180"/>
  <img src="https://github.com/user-attachments/assets/83769e3c-f9f1-4ef7-a0a8-1442a3fd9bbf" width="180"/>
  <img src="https://github.com/user-attachments/assets/db1a69e0-199d-420d-8e90-86e57ee5c90e" width="180"/>
  <img src="https://github.com/user-attachments/assets/6f57da82-e427-409f-a540-e06d504b8f39" width="180"/>
</p>

---

✨ 功能概览

- 🔓 周内购订阅机制 （包含本地支付验证）
  
- 📱 时钟（支持秒级刷新）、日历、面板等小、中组件
  
- 🧩 视图旋转、视图垂直或水平摆动、不规则摆动等动画组件
  
- 🎨 自定义外观（修改字体、文字颜色，组件背景色）
  
- 🧊 透明组件（用户将主屏壁纸作为小组件背景，实现原生隐藏式视觉融合效果）
  
- 🕓 历史组件（用户保留历史设置的组件，支持回溯）
  
- 📢 AdMob 广告
  
---

# 🚀 特别惊喜 - 突破组件刷新限制

https://github.com/user-attachments/assets/6a843691-1160-4777-9ee7-fcab5474a166

在 iOS 系统中，小组件（Widget）是运行在一个沙盒 Timeline 环境中的，其刷新频率受限于系统资源管理：

- 🔋 电量优化机制：系统限制组件的刷新频率，尤其是动画或高频动态更新

- ⏳ 刷新间隔限制：最高刷新频率约为每 15 分钟一次（由 WidgetCenter 调度），无法实现每秒更新

- ❌ 使用 TimelineView(.periodic)、Canvas 等方式，在锁屏或主屏幕上无法实现真实动画效果

---

🦾 动力臂动画机制：ClockHandRotationKit

本项目引入了 ClockHandRotationKit 第三方库，它允许视图围绕锚点持续旋转，不依赖 Timeline 刷新频率

- 将视图想象成挂在两节机械臂末端的物体
- 每节机械臂可独立绕某个点旋转，设置不同的旋转周期/速度
- 当两节臂同时摆动时，组合起来的末端路径可产生：
  - 水平往返运动（如悬挂的钟摆）
  - 垂直运动
  - 甚至自定义路径（如正方形、椭圆形）
    
这种动画效果完全模拟出动力学中的非线性路径运动，并且在系统不允许刷新组件内容的情况下依然生效

- 动力臂代码示例

```swift
   ZStack {
                // 动力臂1
                Rectangle()
                    .frame(width: direction == .horizontal ? arm1Length : 30, height: direction == .horizontal ? 30 : arm1Length)
                    .foregroundColor(.red.opacity(0))

                // 动力臂2
                ZStack {
                    Rectangle()
                        .frame(width: direction == .horizontal ? arm2Length : 30, height: direction == .horizontal ? 30 : arm2Length)
                        .foregroundColor(.blue.opacity(0.0))
                    // 内容
                    content
                        .swingAnimation(duration: duration1, distance: 0)
                        .offset(x: direction == .horizontal ? arm2Length / 2 : 0, y: direction == .vertical ? arm2Length / 2 : 0)
                }
                .background(Color.blue.opacity(0))
                .swingAnimation(duration: duration2, distance: 0)
                .offset(x: direction == .horizontal ? arm1Length / 2 : 0, y: direction == .vertical ? arm1Length / 2 : 0)
            }
            .swingAnimation(duration: duration1, distance: 0)
```
---
