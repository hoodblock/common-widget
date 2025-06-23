//
//  SwiftUIInterstitialView.swift
//  SmallWidget
//
//  Created by hood on 2023/12/10.
//

import GoogleMobileAds
import SwiftUI
import UIKit

    
struct SwiftUIInterstitialView: View {

    var objectSize: CGSize = .zero
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var showedBlock: () -> Void  // 展示的回调

    init(objectSize: CGSize, admobModel: FirebaseAdsItemModel, showedBlock: @escaping (() -> Void)) {
        self.objectSize = objectSize
        self.admobModel = admobModel
        self.showedBlock = showedBlock
    }
    
    public var body: some View {
        VStack (alignment: .center, spacing: 0) {
            InterstitialViewRepresentable(objectSize, admobModel, showedBlock: showedBlock)
                .frame(width: objectSize.width, height: objectSize.height, alignment: .center)
        }
    }
}


struct InterstitialViewRepresentable: UIViewControllerRepresentable {
    
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var objectSize: CGSize = .zero
    var showedBlock: () -> Void  // 展示的回调

    init(_ objectSize: CGSize, _ admobModel: FirebaseAdsItemModel, showedBlock: @escaping (() -> Void)) {
        self.admobModel = admobModel
        self.objectSize = objectSize
        self.showedBlock = showedBlock
    }
    
    func makeUIViewController(context: Context) -> InterstitialViewController {
        return InterstitialViewController(objectSize, admobModel, showedBlock)
    }

    func updateUIViewController(_ uiViewController: InterstitialViewController, context: Context) {
        
    }
}



class InterstitialViewController: UIViewController, FullScreenContentDelegate {
    var admobModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    var objectSize: CGSize = .zero
    var showedBlock: () -> Void  // 展示的回调

    private var isRequesting: Bool = false
    private let requestStatusTime: Int = 30;
    private var interstitialAd: InterstitialAd = InterstitialAd()

    init(_ objectSize: CGSize, _ admobModel: FirebaseAdsItemModel, _ showedBlock: @escaping (() -> Void) = {}) {
        self.showedBlock = showedBlock
        super.init(nibName: nil, bundle: nil)
        self.admobModel = admobModel
        self.objectSize = objectSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ((CalendarTool.currentTimeInterval() - admobModel.adRealTime <= admobModel.cacheSeconds) && (admobModel.interstitialAd != nil)) {
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                self.showInterstitialView()
            }
        } else {
            showedBlock()
            FirebaseNetwork.shared.loadInterstitialViewAds()
        }
    }

    func loadInterstitialAd() {
        if ((CalendarTool.currentTimeInterval() - admobModel.adRealTime <= admobModel.cacheSeconds) && (admobModel.interstitialAd != nil)) {
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
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Interstitial 】_______【 Request 】_______【 \(admobModel.ad_name) 】")
        admobModel.requestTime = CalendarTool.currentTimeInterval()
        InterstitialAd.load(with: admobModel.ad_id, request: Request()) { [self] interstitialAd, err in
            if let err = err {
                print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Interstitial 】_______【 Request 】_______【 \(admobModel.ad_name) 】_______ 【 Failure __ \(err)】")
            } else {
                admobModel.adRealTime = CalendarTool.currentTimeInterval()
                admobModel.interstitialAd = interstitialAd
                interstitialAd!.paidEventHandler = { value in
                    
                }
                print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Interstitial 】_______【 Request 】_______【 \(admobModel.ad_name) 】_______ 【 Success 】")
            }
            isRequesting = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_AD_REQUEST), object: nil)
        }
    }
  
    // 点击广告取消按钮，让广告消失
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        admobModel.interstitialAd = nil
        admobModel.requestTime = 0
        admobModel.adRealTime = 0
        isRequesting = false
        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Interstitial 】_______【 Show 】_______【 \(admobModel.ad_name) 】_______【 adDidDismissFullScreenContent 】")
        showedBlock()
        FirebaseNetwork.shared.loadInterstitialViewAds()
    }

    // 广告展示失败
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        admobModel.interstitialAd = nil
        admobModel.requestTime = 0
        admobModel.adRealTime = 0
        isRequesting = false
//        print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Interstitial 】_______【 Show 】_______【 \(admobModel.ad_name) 】_______【 \(error) 】_______【 didFailToPresentFullScreenContentWithError 】")
        showedBlock()
//        FirebaseNetwork.shared.loadInterstitialViewAds()
    }
    
    func showInterstitialView() {
        if let currentInterstitialAd = admobModel.interstitialAd {
            interstitialAd = currentInterstitialAd
            interstitialAd.fullScreenContentDelegate = self
            interstitialAd.present(from: self)
            print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 Interstitial 】_______【 Show 】_______【 \(admobModel.ad_name) 】_______【 Interstitial Show Success 】")
        } else {
//            print("_______【 Firebase 】_______【 Interstitial 】_______【 Show 】_______【 \(admobModel.ad_name) 】_______【 Interstitial Show Failture 】")
            showedBlock()
        }
    }
    
}
