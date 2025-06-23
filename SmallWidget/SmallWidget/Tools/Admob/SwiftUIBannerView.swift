//
//  SwiftUIBannerView.swift
//  SmallWidget
//
//  Created by hood on 2023/12/10.
//

import GoogleMobileAds
import SwiftUI
import UIKit

let BANNERSIZE: CGSize = CGSize(width: UIScreen.main.bounds.width - 20 * 2, height: 60)

public struct SwiftUIBannerView: View {
    
    var objectSize: CGSize = .zero
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()

    init(objectSize: CGSize, admobModel: FirebaseAdsItemModel) {
        self.objectSize = objectSize
        self.admobModel = admobModel
    }
    
    public var body: some View {
        VStack (alignment: .center, spacing: 0) {
            BannerViewRepresentable(objectSize, admobModel)
                .frame(width: objectSize.width, height: objectSize.height, alignment: .center)
        }
    }
}

struct BannerViewRepresentable: UIViewControllerRepresentable {
        
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var objectSize: CGSize = .zero

    init(_ objectSize: CGSize, _ admobModel: FirebaseAdsItemModel) {
        self.admobModel = admobModel
        self.objectSize = objectSize
    }
    
    func makeUIViewController(context: Context) -> BannerViewController {
        return BannerViewController(objectSize, admobModel)
    }

    func updateUIViewController(_ uiViewController: BannerViewController, context: Context) {
        
    }
}

// 基础的请求View
class BannerViewController: UIViewController, BannerViewDelegate {
    
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var objectSize: CGSize = .zero
    private var bannerView: BannerView = BannerView()
    private var isRequesting: Bool = false
    private let requestStatusTime: Int = 30;

    init(_ objectSize: CGSize, _ admobModel: FirebaseAdsItemModel) {
        super.init(nibName: nil, bundle: nil)
        self.admobModel = admobModel
        self.objectSize = objectSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        if ((CalendarTool.currentTimeInterval() - admobModel.adRealTime <= admobModel.cacheSeconds) && (admobModel.bannerAd != nil)) {
            showBannerView()
        } else {
            FirebaseNetwork.shared.loadBannerViewAds()
        }
    }

    // 请求 Banner  广告
    func loadBannerAd() {
        if ((CalendarTool.currentTimeInterval() - admobModel.adRealTime <= admobModel.cacheSeconds) && (admobModel.bannerAd != nil)) {
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
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Banner 】_______【 Request 】_______【 \(admobModel.ad_name) 】")
        admobModel.requestTime = CalendarTool.currentTimeInterval()
        bannerView = BannerView()
        bannerView.adSize = currentOrientationAnchoredAdaptiveBanner(width: BANNERSIZE.width)
        bannerView.adUnitID = admobModel.ad_id
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(Request())
    }
    
    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
        bannerView.delegate = nil
        admobModel.bannerAd = bannerView
        admobModel.adRealTime = CalendarTool.currentTimeInterval()
        bannerView.paidEventHandler = { value in
            
        }
        isRequesting = false;
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Banner 】_______【 Request 】_______【 \(admobModel.ad_name) 】_______ 【 Success 】")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_AD_REQUEST), object: nil)
    }

    func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
        isRequesting = false;
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Banner 】_______【 Request 】_______【 \(admobModel.ad_name) 】_______ 【 Failure __ \(error)】")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_AD_REQUEST), object: nil)
    }
    
    // 展示
    func showBannerView() {
        bannerView = admobModel.bannerAd ?? BannerView()
        bannerView.rootViewController = self
        bannerView.delegate = self
        view.addSubview(bannerView)
        admobModel.bannerAd = nil
        admobModel.requestTime = 0
        admobModel.adRealTime = 0
        isRequesting = false;
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Banner 】_______【 Show 】_______【 \(admobModel.ad_name) 】")
        FirebaseNetwork.shared.loadBannerViewAds()
    }
}
