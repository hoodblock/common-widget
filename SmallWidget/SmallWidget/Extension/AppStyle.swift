//
//  AppStyle.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/5.
//

import SwiftUI

struct VLabelTStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing:0) {
            configuration.icon
                .frame(width:30, height: 30)
                .padding(.bottom, 8)
            configuration.title
                .font(.S_Pro_10())
            
        }
    }
}

struct WLabelBStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing:0) {
            configuration.title
                .font(.S_Pro_11())
                .foregroundColor(Color.buttonText)
                .padding(.trailing, 6)
            
            configuration.icon
                .frame(width:15, height: 15)
        }
    }
}


struct CustomTabItem: View {
    
    let imageName: String
    let title: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .frame(width: 40, height: 40)
        }
    }
}


struct VisibilityStyle: ViewModifier {
    
    @Binding var hidden: Bool
    func body(content: Content) -> some View {
        Group {
            if hidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}

struct NavigationBarVisibilityStyle: ViewModifier {
    
    @Binding var hidden: Bool
    
    func body(content: Content) -> some View {
        Group {
            if hidden {
                withAnimation {
                    content.navigationBarHidden(true)
                }
            } else {
                content
            }
        }
    }
}


struct ViewLayout {
    
    static func SWidth(_ width: CGFloat) -> CGFloat {
        UIScreen.main.bounds.size.width * width / 375.0
    }
           
    static func SHeight(_ height: CGFloat) -> CGFloat {
        UIScreen.main.bounds.size.height * height / 812.0
    }
    
    public static func S_W_2() -> CGFloat { SWidth(2) }
    public static func S_W_3() -> CGFloat { SWidth(3) }
    public static func S_W_5() -> CGFloat { SWidth(5) }
    public static func S_W_6() -> CGFloat { SWidth(6) }
    public static func S_W_7() -> CGFloat { SWidth(7) }
    public static func S_W_8() -> CGFloat { SWidth(8) }
    public static func S_W_9() -> CGFloat { SWidth(9) }
    public static func S_W_10() -> CGFloat { SWidth(10) }
    public static func S_W_11() -> CGFloat { SWidth(11) }
    public static func S_W_12() -> CGFloat { SWidth(12) }
    public static func S_W_14() -> CGFloat { SWidth(14) }
    public static func S_W_15() -> CGFloat { SWidth(15) }
    public static func S_W_16() -> CGFloat { SWidth(16) }
    public static func S_W_17() -> CGFloat { SWidth(17) }
    public static func S_W_18() -> CGFloat { SWidth(18) }
    public static func S_W_20() -> CGFloat { SWidth(20) }
    public static func S_W_22() -> CGFloat { SWidth(22) }
    public static func S_W_25() -> CGFloat { SWidth(25) }
    public static func S_W_30() -> CGFloat { SWidth(30) }
    public static func S_W_35() -> CGFloat { SWidth(35) }
    public static func S_W_40() -> CGFloat { SWidth(40) }
    public static func S_W_50() -> CGFloat { SWidth(50) }
    public static func S_W_55() -> CGFloat { SWidth(55) }
    public static func S_W_60() -> CGFloat { SWidth(60) }
    public static func S_W_100() -> CGFloat { SWidth(100) }
    public static func S_W_101() -> CGFloat { SWidth(101) }
    public static func S_W_180() -> CGFloat { SWidth(180) }
    public static func S_W_190() -> CGFloat { SWidth(190) }
    public static func S_W_200() -> CGFloat { SWidth(200) }
    public static func S_W_210() -> CGFloat { SWidth(210) }
    public static func S_W_215() -> CGFloat { SWidth(215) }

    // Height
    public static func S_H_2() -> CGFloat { SHeight(2) }
    public static func S_H_3() -> CGFloat { SHeight(3) }
    public static func S_H_5() -> CGFloat { SHeight(5) }
    public static func S_H_6() -> CGFloat { SHeight(6) }
    public static func S_H_7() -> CGFloat { SHeight(7) }
    public static func S_H_10() -> CGFloat { SHeight(10) }
    public static func S_H_12() -> CGFloat { SHeight(12) }
    public static func S_H_14() -> CGFloat { SHeight(14) }
    public static func S_H_15() -> CGFloat { SHeight(15) }
    public static func S_H_18() -> CGFloat { SHeight(18) }
    public static func S_H_20() -> CGFloat { SHeight(20) }
    public static func S_H_22() -> CGFloat { SHeight(22) }
    public static func S_H_25() -> CGFloat { SHeight(25) }
    public static func S_H_30() -> CGFloat { SHeight(30) }

    // Radius
    public static func S_R_5() -> CGFloat { SHeight(10) / 2 }
    public static func S_R_10() -> CGFloat { SHeight(10) / 2}
    public static func S_R_15() -> CGFloat { SHeight(15) / 2 }
    public static func S_R_20() -> CGFloat { SHeight(20) / 2}

}

extension View {
    
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }

    func navigationBarVisibility(hidden: Binding <Bool>) -> some View {
        modifier(NavigationBarVisibilityStyle(hidden: hidden))
    }
    
    func visibility(hidden: Binding<Bool>) -> some View {
        modifier(VisibilityStyle(hidden: hidden))
    }
    
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

struct Constants {
    static let statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var snapCarouselStyle: SnapCarouselStyle {
        get { self[SnapCarouselStyleKey.self]}
        set { self[SnapCarouselStyleKey.self] = newValue }
    }
}

private struct SnapCarouselStyleKey: EnvironmentKey {
     static let defaultValue: SnapCarouselStyle = .default
}


private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

final class PathManager:ObservableObject{
    @Published var path = NavigationPath()
    
    func backPath() {
        path.removeLast()
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CustomViewModel<Content: View>: Identifiable {
    let id = UUID()
    let view: Content
}

extension TupleView {
    var getViews: [AnyView] {
        makeArray(from: value)
    }
    
    private struct GenericView {
        let body: Any
        
        var anyView: AnyView? {
            AnyView(_fromValue: body)
        }
    }
    
    private func makeArray<Tuple>(from tuple: Tuple) -> [AnyView] {
        func convert(child: Mirror.Child) -> AnyView? {
            withUnsafeBytes(of: child.value) { ptr -> AnyView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                return binded.first?.anyView
            }
        }
        
        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


extension Date {
    
    func getCurrentDayScaleConfig()-> Date {
        let calendar:Calendar = Calendar.current;
        let year = calendar.component(.year, from: self);
        let month = calendar.component(.month, from: self);
        let day = calendar.component(.day, from: self);
        let components = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        return Calendar.current.date(from: components)!
    }
}

