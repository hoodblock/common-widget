//
//  SettingView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/5.
//

import SwiftUI
import WebKit
import SafariServices


/// webview
struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct BaseWebView : View {
    
    @State var title : String
    @State var URL : URL
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var lightModel: Bool = false

    var body: some View {
        HStack (alignment: .center) {
            WebView(url: URL)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Color_F6F6F6)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(viewBlock: {
            withAnimation(nil) {
                presentationMode.wrappedValue.dismiss()
            }
        }, lightModel: $lightModel))
        .toolbarBackground(.white, for: .navigationBar)
    }
}

///

struct SafariView: View {
    var url: URL
    var onDismiss: (() -> Void)? // 回调当 SafariView 被 dismiss 时

    var body: some View {
        SafariViewControllerWrapper(url: url, onDismiss: onDismiss)
            .navigationBarBackButtonHidden(true) // 隐藏返回按钮
    }
}

// 2. 实现 UIViewControllerRepresentable
struct SafariViewControllerWrapper: UIViewControllerRepresentable {
    var url: URL
    var onDismiss: (() -> Void)?

    // 创建并返回一个 SFSafariViewController
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = context.coordinator // 设置代理
        return safariVC
    }

    // 更新视图
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // 通常这里可以更新视图，当前没有需要更新的内容
    }

    // 创建一个 Coordinator 来处理 SafariViewController 的生命周期
    func makeCoordinator() -> Coordinator {
        return Coordinator(onDismiss: onDismiss)
    }

    // Coordinator 用于管理 SFSafariViewController 的行为
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var onDismiss: (() -> Void)?

        init(onDismiss: (() -> Void)?) {
            self.onDismiss = onDismiss
        }

        // 当 SFSafariViewController 被 dismiss 时触发
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            onDismiss?() // 调用 dismiss 回调
        }
    }
}




///
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Do nothing
    }
}

struct SettingView: View {
    
    @State private var showVIPSheet = false
    @ObservedObject var payConfig = PayConfig.shared

    @State private var showWebView = false

    var body: some View {
        Color.Color_F6F6F6.edgesIgnoringSafeArea(.all).overlay {
            GeometryReader { geometry in
                ZStack (alignment: .center) {
                    VStack (alignment: .center, spacing: 0) {
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            HStack(alignment:.center, spacing: 0) {
                                Text("Setting")
                                    .font(.S_Pro_20(.medium))
                                    .foregroundColor(Color.Color_393672)
                                Spacer(minLength: 0)
                            }
                            Image("pay_default_back_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay {
                                    if payConfig.isPaied {
                                        VStack () {
                                            HStack() {
                                                Image("vip_vip")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                                                HStack () {
                                                    Text("Lifetime Member")
                                                        .foregroundColor(Color.Color_393672)
                                                        .font(Font.S_Pro_15(.bold))
                                                    Spacer()
                                                }
                                                Spacer()
                                            }
                                            Spacer()
                                            vipDetailItemsView()
                                        }
                                        .padding([.leading, .trailing], ViewLayout.S_W_10() * 2)
                                        .padding([.top, .bottom], ViewLayout.S_W_10() * 1.5)
                                    } else {
                                        ZStack () {
                                            HStack () {
                                                Spacer()
                                                VStack () {
                                                    Image("pay_vip_icon")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: ViewLayout.S_W_10() * 14, height: ViewLayout.S_W_10() * 14, alignment: .center)
                                                    Spacer()
                                                }
                                            }
                                            .offset(x: 35, y: -70)
                                            VStack () {
                                                Spacer()
                                                vipDetailItemsView()
                                                    .onTapGesture {
                                                        showVIPSheet = true
                                                    }
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                        }
                        .fullScreenCover(isPresented: $showVIPSheet) {
                            VIPDetailView(dismissBlock: {
                                
                            })
                            .background(BackgroundClearView())
                        }
                        HStack {
                            Text("More")
                                .foregroundColor(Color.Color_393672)
                                .font(.S_Pro_20())
                            Spacer()
                        }
                        .padding([.top, .bottom], ViewLayout.S_W_15())
                        VStack(alignment: .center, spacing: 0) {
                            // privacy agreement
                            NavigationLink(destination: {
                                BaseWebView(title: "Privacy Policy", URL: URL(string: "https://www.baidu.com")!)
                            }, label: {
                                tableItem(image: "settings_0", name: "Privacy Agreement")
                            })
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.Color_EFEFEF)
                                .padding([.leading, .trailing], ViewLayout.S_W_20())
                            // about
                            NavigationLink(destination: {
                                AboutView()
                            }, label: {
                                tableItem(image: "settings_2", name: "About")
                            })
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.Color_EFEFEF)
                                .padding([.leading, .trailing], ViewLayout.S_W_20())
                            // rate us
                            Button {
                                if let url = URL(string: "itms-apps://apps.apple.com/app/id6473517249?action=write-review"), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            } label: {
                                tableItem(image: "settings_3", name: "Rate")
                            }
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.Color_EFEFEF)
                                .padding([.leading, .trailing], ViewLayout.S_W_20())
                            // telegram
                            Button {
                                if let url = URL(string: "https://t.me/+jKE_D2qfalNlZjk1"), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            } label: {
                                tableItem(image: "settings_5", name: "Telegram")
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(ViewLayout.S_W_10())
                        Spacer()
                    }
                    .padding([.leading,.trailing], ViewLayout.S_W_20())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
//                .overlay {
//                    FloatingDragView {
//                        self.showWebView = true
//                    }
//                }
                .sheet(isPresented: $showWebView) {
                    SafariView(url: URL(string: "https://baidu.com/")!, onDismiss: {
                        print("Safari View dismissed.")
                    })
                }
            }
        }
    }

    func tableItem(image: String, name: String) -> some View {
        HStack(alignment: .center, spacing: 0) {
            Image(image)
                .padding([.leading,.trailing], 10)
            Text(name)
                .foregroundColor(Color.Color_393672)
                .font(.S_Pro_16())
            Spacer(minLength: 0)
            Image("setting_arrow")
                .frame(width: 15, height:15)
                .padding(.trailing, ViewLayout.S_W_16())
        }
        .frame(height: ViewLayout.S_W_50())
    }
    
    func vipDetailItemsView() -> some View {
        VStack () {
            HStack() {
                VStack () {
                    Image("vip_3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                    Text("Widgets")
                        .foregroundColor(Color.Color_393672)
                        .font(Font.S_Pro_10(.regular))
                }
                Spacer()
                VStack () {
                    Image("vip_0")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                    Text("No Ads")
                        .foregroundColor(Color.Color_393672)
                        .font(Font.S_Pro_10(.regular))
                }
                Spacer()
                VStack () {
                    Image("vip_4")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                    Text("Wallpapers")
                        .foregroundColor(Color.Color_393672)
                        .font(Font.S_Pro_10(.regular))
                }
                Spacer()
                VStack () {
                    Image("vip_2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                    Text("Themes")
                        .foregroundColor(Color.Color_393672)
                        .font(Font.S_Pro_10(.regular))
                }
            }
        }
        .padding([.leading, .trailing], ViewLayout.S_W_10() * 2)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
