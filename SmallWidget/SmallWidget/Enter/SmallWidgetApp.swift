//
//  SmallWidgetApp.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/1.
//

import SwiftUI
import AppTrackingTransparency
import Combine
import Network

let USERDEFAULT_RATE_ALERT = "USERDEFAULT_RATE_ALERT"
let USERDEFAULT_BOARD_COMPLETED = "USERDEFAULT_BOARD_COMPLETED"
let USERDEFAULT_CLICK_ATTrRACKINGMANAGER = "USERDEFAULT_CLICK_ATTrRACKINGMANAGER"

class NetworkReachabilityManager: ObservableObject {
    
    static let shared = NetworkReachabilityManager()
    private init() {
        checkNewStatus()
    }
    
    @Published var isReachable = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var cancellable: AnyCancellable?
    func checkNewStatus() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
        cancellable = AnyCancellable {
            self.monitor.cancel()
        }
        monitor.start(queue: queue)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var isInitThirdSDKStatus: Bool = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        _ = PayConfig.shared
        _ = initThirdSDK()
        return true
    }
    
    func initThirdSDK() -> Bool {
        if NetworkReachabilityManager.shared.isReachable {
            if !isInitThirdSDKStatus {
                isInitThirdSDKStatus = true
                FirebaseNetwork.shared.requestAds()
            }
            return true
        } else {
            return false
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}

@main
struct SwiftUIAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase

    // 弹窗授权
    @State private var isATTrackingCompleted: Bool = false
    // 广告启动页
    @State private var canShowStartAdView: Bool = true
    
    // 引导启动页
    @State private var isOnBoardingCompleted: Bool = false

    // 展示内容
    @State private var canShowContentView: Bool = false

    // 由于要先展示启动页，所以必须一个假页面做授权处理，先去授权弹窗（ATTrackingManager / Network）
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            VStack() {
                if canShowStartAdView && ((NetworkReachabilityManager.shared.isReachable) && ((UserDefaults.standard.value(forKey: USERDEFAULT_CLICK_ATTrRACKINGMANAGER) != nil) ? UserDefaults.standard.value(forKey: USERDEFAULT_CLICK_ATTrRACKINGMANAGER)! as! Bool : false)) {
                    AdLaunchPage(canShowStartAdView: $canShowStartAdView)
                        .onAppear {
                            _ = appDelegate.initThirdSDK()
                        }
                } else if (!isOnBoardingCompleted && isATTrackingCompleted) {
                    BootBoardingPage(isOnBoardingCompleted: $isOnBoardingCompleted)
                } else if isOnBoardingCompleted && !canShowStartAdView {
                    ContentView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    LaunchPage()
                }
            }
        }
        .onChange(of: canShowStartAdView) { canShowStartAdView in
            isOnBoardingCompleted = (UserDefaults.standard.value(forKey: USERDEFAULT_BOARD_COMPLETED) != nil) ? UserDefaults.standard.value(forKey: USERDEFAULT_BOARD_COMPLETED)! as! Bool : false
            if isOnBoardingCompleted {
                canShowContentView = true
            }
        }
        .onChange(of: isOnBoardingCompleted) { isOnBoardingCompleted in
            canShowContentView = true
            canShowStartAdView = false
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active: appActiveStatus()
            case .inactive: appInactiveStatus()
            case .background: appBackgroundStatus()
            @unknown default:
                print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP Default   （在后台）】_______________")
            }
        }
        .onChange(of: isATTrackingCompleted) { isATTrackingCompleted in
            canShowStartAdView = true
        }
    }
        
    func appActiveStatus() {
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP Active    （活跃）】_______________")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            requestIDFAPermission()
        }
    }
    
    func appInactiveStatus() {
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP Inactive  （休眠）】_______________")

    }
    
    func appBackgroundStatus() {
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP Background（在后台）】_______________")
//        if PayConfig.shared.isPaied {
//            canShowStartAdView = false
//        } else {
//            canShowStartAdView = true
//        }
    }
    
    func requestIDFAPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .notDetermined:
                    print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP ATTrackingManager 】__________【 notDetermine 】_______________【 \(status) 】")
                case .denied, .authorized, .restricted:
                    isATTrackingCompleted = true
                    UserDefaults.standard.setValue(true, forKey: USERDEFAULT_CLICK_ATTrRACKINGMANAGER)
                    UserDefaults.standard.synchronize()
                    print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP ATTrackingManager 】__________【 restricted 】_______________【 \(status) 】")
                default:
                    print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______________【 APP ATTrackingManager （授权失败）】_______________【 \(status) 】")
                    isATTrackingCompleted = true
                    UserDefaults.standard.setValue(true, forKey: USERDEFAULT_CLICK_ATTrRACKINGMANAGER)
                    UserDefaults.standard.synchronize()
                }
            }
        } else {
            isATTrackingCompleted = true
            UserDefaults.standard.setValue(true, forKey: USERDEFAULT_CLICK_ATTrRACKINGMANAGER)
            UserDefaults.standard.synchronize()
        }
    }
}

// MARK: - 启动页， 用于提前授权弹窗

struct LaunchPage: View {
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Image("splashImage")
                .resizable()
                .frame(width: 130, height: 130)
            Text(DeviceInfoUtil.getappName())
            Spacer()
            ZStack(alignment: .center) {
                HStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 100, height: 8, alignment: .center)
                        .cornerRadius(4, corners: .allCorners)
                }
            }
            .padding([.leading, .trailing, .bottom], 40)
        }
    }
}

// MARK: - 广告启动页
struct AdLaunchPage: View {
    
    @Binding var canShowStartAdView: Bool
    @State private var progress: CGFloat = 0.0          // 当前位置
    @State private var timeAllProgress: CGFloat = 5
    @State private var timeProgress: CGFloat = 0.05     // 每个时间间隔
    @State private var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let progressDefaultWidth: CGFloat =  UIScreen.main.bounds.size.width - 40 * 2

    @State private var showAd: Bool = false
    @State private var isReceiveAdsNotification: Bool = false
    @State private var showVIPView: Bool = false
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack (alignment: .center) {
                Spacer()
                Image("splashImage")
                    .resizable()
                    .frame(width: 130, height: 130)
                Text(DeviceInfoUtil.getappName())
                Spacer()
                ZStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: progressDefaultWidth, height: 8, alignment: .center)
                            .cornerRadius(4, corners: .allCorners)
                    }
                    HStack(alignment: .center) {
                        VStack(alignment: .center) {
                            Rectangle()
                                .frame(width: progress, height: 8, alignment: .center)
                                .foregroundColor(Color.Color_8682FF)
                                .cornerRadius(4, corners: .allCorners)
                                .onAppear {
                                    timer = Timer.publish(every: timeProgress, on: .main, in: .common).autoconnect()
                                }
                        }
                        Spacer(minLength: 0)
                    }
                }
                .padding([.leading, .trailing, .bottom], 40)
            }
        }
        .ignoresSafeArea(.all)
        .onReceive(timer) { _ in
            if progress < progressDefaultWidth {
                let increment = (progressDefaultWidth / timeAllProgress) * timeProgress
                progress += increment
            } else {
                progress = progressDefaultWidth
                withAnimation {
                    if PayConfig.shared.isPaied {
                        canShowStartAdView = false
                    } else {
                        showVIPView = true
                    }
                }
                timer.upstream.connect().cancel()
            }
        }
        .fullScreenCover(isPresented: $showVIPView) {
            VIPDetailView(dismissBlock: {
                canShowStartAdView = false
            })
            .background(BackgroundClearView())
        }
    }
}
