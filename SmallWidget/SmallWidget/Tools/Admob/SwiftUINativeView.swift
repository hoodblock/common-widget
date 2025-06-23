//
//  SwiftUINativeView.swift
//  SmallWidget
//
//  Created by hood on 2023/12/10.
//

import GoogleMobileAds
import SwiftUI
import UIKit

let NATIVESIZE_200: CGSize = CGSize(width: UIScreen.main.bounds.width - 20 * 2, height: ViewLayout.SWidth(200))
let NATIVESIZE_120: CGSize = CGSize(width: UIScreen.main.bounds.width - 20 * 2, height: ViewLayout.SWidth(120))


public struct SwiftUINativeView: View {
    
    var objectSize: CGSize = .zero
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    init(objectSize: CGSize, admobModel: FirebaseAdsItemModel) {
        self.objectSize = objectSize
        self.admobModel = admobModel
    }
    
    public var body: some View {
        VStack (alignment: .center, spacing: 0) {
            NativeViewRepresentable(objectSize, admobModel)
                .frame(width: objectSize.width, height: objectSize.height)
        }
    }
}

struct NativeViewRepresentable: UIViewControllerRepresentable {
        
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var objectSize: CGSize = .zero
    
    init(_ objectSize: CGSize, _ admobModel: FirebaseAdsItemModel) {
        self.admobModel = admobModel
        self.objectSize = objectSize
    }
    
    func makeUIViewController(context: Context) -> NativeViewController {
        return NativeViewController(objectSize, admobModel)
    }

    func updateUIViewController(_ uiViewController: NativeViewController, context: Context) {
        
    }
}

class NativeViewController: UIViewController, NativeAdLoaderDelegate, NativeAdDelegate {

    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var objectSize: CGSize = .zero
    private var isRequesting: Bool = false
    private let requestStatusTime: Int = 30;
    private var nativeLoader: AdLoader = AdLoader()
    private var nativeView: NativeAdView = NativeAdView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ((CalendarTool.currentTimeInterval() - admobModel.adRealTime <= admobModel.cacheSeconds) && (admobModel.nativeAd != nil)) {
            showNativeView()
        } else {
            FirebaseNetwork.shared.loadNativeViewAds()
        }
    }
    
    init(_ objectSize: CGSize, _ admobModel: FirebaseAdsItemModel) {
        super.init(nibName: nil, bundle: nil)
        self.admobModel = admobModel
        self.objectSize = objectSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func loadNativeAd() {
        if ((CalendarTool.currentTimeInterval() - admobModel.adRealTime <= admobModel.cacheSeconds) && (admobModel.nativeAd != nil)) {
            return
        }
        if isRequesting {
            if (CalendarTool.currentTimeInterval() - admobModel.requestTime > requestStatusTime) {
                self.isRequesting = false;
            } else {
                return;
            }
        }
        isRequesting = true
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Native 】_______【 Request 】_______【 \(admobModel.ad_name) 】")
        admobModel.requestTime = CalendarTool.currentTimeInterval()
        nativeLoader = AdLoader(adUnitID: admobModel.ad_id, rootViewController: nil, adTypes: [.native], options: nil)
        nativeLoader.delegate = self
        nativeLoader.load(Request())
    }
    
    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        admobModel.nativeAd = nativeAd
        admobModel.adRealTime = CalendarTool.currentTimeInterval()
        nativeAd.paidEventHandler = { value in
            
        }
        isRequesting = false;
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Native 】_______【 Request 】_______【 \(admobModel.ad_name) 】_______ 【 Success 】")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_AD_REQUEST), object: nil)
    }

    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
        isRequesting = false;
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Native 】_______【 Request 】_______【 \(admobModel.ad_name) 】_______ 【 Failure __ \(error)】")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_AD_REQUEST), object: nil)
    }

    // 展示
    func showNativeView() {
        if let currentNativeAd = admobModel.nativeAd {
            if objectSize.height < ViewLayout.SWidth(130) {
                nativeView = Bundle.main.loadNibNamed("SwiftUINativeAdView_120", owner: nil, options: nil)?.first as! NativeAdView
                nativeView.frame = CGRectMake(0, 0, self.view.frame.size.width, objectSize.height)
                view.frame = CGRectMake(0, 0, self.view.frame.size.width, objectSize.height)
            } else if objectSize.height < ViewLayout.SWidth(300) {
                nativeView = Bundle.main.loadNibNamed("SwiftUINativeAdView_200", owner: nil, options: nil)?.first as! NativeAdView
                nativeView.frame = CGRectMake(0, 0, self.view.frame.size.width, objectSize.height)
                view.frame = CGRectMake(0, 0, self.view.frame.size.width, objectSize.height)
                nativeView.mediaView?.mediaContent = currentNativeAd.mediaContent
            }
            (nativeView.headlineView as? UILabel)?.text = currentNativeAd.headline
            (nativeView.bodyView as? UILabel)?.text = currentNativeAd.body
            (nativeView.iconView as? UIImageView)?.image = currentNativeAd.icon?.image
            (nativeView.storeView as? UILabel)?.text = currentNativeAd.store
            (nativeView.priceView as? UILabel)?.text = currentNativeAd.price
            (nativeView.advertiserView as? UILabel)?.text = currentNativeAd.advertiser
            (nativeView.callToActionView as? UIButton)?.setTitle(currentNativeAd.callToAction, for: .normal)
            nativeView.nativeAd = currentNativeAd
            view.addSubview(nativeView)
            print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Native 】_______【 Show 】_______【 \(admobModel.ad_name) 】_______【 Native Show Success 】")
//            admobModel.nativeAd = nil
//            admobModel.requestTime = 0
//            admobModel.adRealTime = 0
            isRequesting = false;
            FirebaseNetwork.shared.loadNativeViewAds()
            // 这里地址要变，不然刷新不了数据
        } else {
            print("_______【 Firebase 】_______【 Native 】_______【 Show 】_______【 \(admobModel.ad_name) 】_______【 Native Show Failture 】")
            FirebaseNetwork.shared.loadNativeViewAds()
        }
    }
        
}
