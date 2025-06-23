//
//  FirebaseNet.swift
//  SmallWidget
//
//  Created by hood on 2023/12/7.
//

import Foundation
import GoogleMobileAds
import AdSupport
import SwiftUI
import HandyJSON
import UIKit

// FirebaseModel 配置数据
class FirebaseConfigModel: HandyJSON {
    var ad_ctrl: FirebaseEventModel           = FirebaseEventModel()
    var ad_detail: FirebaseAdsModel           =  FirebaseAdsModel()
    required init() {
        self.ad_ctrl                          = FirebaseEventModel()
        self.ad_detail                        = FirebaseAdsModel()
    }
}

class FirebaseAdsItemModel: HandyJSON {
    required init() {
    }
    var ad_scene: String                            = String()
    var ad_id: String                               = String()
    var ad_type: String                             = String()
    var ad_name: String                             = String()
    var ad_repeatRequest: Int                       = 1                                     // 重复请求，就是两个一样的广告
    // 额外数据（基础）
    var requestTime: Int64                          = CalendarTool.currentTimeInterval()
    var adRealTime: Int64                           = CalendarTool.currentTimeInterval()    // 请求到数据之后的创建时间，用来判断是否过期
    var cacheSeconds: Int64                         = 60 * 60                               // 广告缓存时间(3600秒，一小时)
    var isRequesting: Bool                          = false

    // 额外数据（进阶）
    var startAd: AppOpenAd?
    var nativeAd: NativeAd?
    var bannerAd: BannerView?
    var interstitialAd: InterstitialAd?
    var rewardedAd: RewardedAd?

    
    
    required init(_ itemModel: FirebaseAdsItemModel) {
        ad_scene = itemModel.ad_scene
        ad_id = itemModel.ad_id
        ad_type = itemModel.ad_type
        ad_name = itemModel.ad_name
        ad_repeatRequest = itemModel.ad_repeatRequest
        requestTime = itemModel.requestTime
        adRealTime = itemModel.adRealTime
        cacheSeconds = itemModel.cacheSeconds
        
        // 额外数据（进阶）
        startAd = itemModel.startAd
        nativeAd = itemModel.nativeAd
        bannerAd = itemModel.bannerAd
        interstitialAd = itemModel.interstitialAd
        rewardedAd = itemModel.rewardedAd
    }
    
}

struct FirebaseAdsModel: HandyJSON {
    var release_ad_value: [FirebaseAdsItemModel]       = []
    var debug_ad_value: [FirebaseAdsItemModel]       = []
    
    var value_ads: [[FirebaseAdsItemModel]] {
        #if DEBUG
            return [debug_ad_value]
        #else
            return [release_ad_value]
        #endif
    }
}

struct FirebaseEventModel: HandyJSON {
    var native_enable: Bool                         = true
    var inter_enable: Bool                          = true
    var banner_enable: Bool                         = true
}

enum AdsType: Int {
    case start                                      = 0 // 开屏广告
    case inter                                      = 1 // 插页广告
    case banner                                     = 2 // 横幅广告
    case native                                     = 3 // 原生广告
    case reward                                     = 4 // 激励广告
}
 

let NOTIFICATION_AD_REQUEST_SUCCESS :String = "notification_ad_request_success"
let NOTIFICATION_AD_REQUEST :String = "notification_ad_request"

 // 瀑布流广告
class FirebaseNetwork {
    
    static let shared = FirebaseNetwork()
    
    var firebaseConfigModel: FirebaseConfigModel = FirebaseConfigModel()
    
    var bannerAds: [BannerViewController] = []
    var startAds: [StartViewController] = []
    var interAds: [InterstitialViewController] = []
    var nativeAds: [NativeViewController] = []
    var rewardAds: [RewardViewController] = []
    var shouldRequestNotification: Bool = false

    init() {
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [""]
        MobileAds.shared.start(completionHandler: nil)
        loadLocalCacheFirebaseAdmobConfig()
        NotificationCenter.default.addObserver(self, selector: #selector(isCheckAdViewAllRespontNotification), name: Notification.Name(NOTIFICATION_AD_REQUEST), object: nil)
    }
    
    // 本地firebase 数据
    private func loadLocalCacheFirebaseAdmobConfig() {
        // 读取配置数据
        guard let fileURL = Bundle.main.url(forResource: "FirebaseAdmobConfigJson", withExtension: "geojson") else {
            print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 未找到 广告配置本地文件 】")
            return
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let jsonString = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            firebaseConfigModel.ad_ctrl = FirebaseEventModel.deserialize(from: jsonString, designatedPath: "ad_ctrl") ?? FirebaseEventModel()
            firebaseConfigModel.ad_detail = FirebaseAdsModel.deserialize(from: jsonString, designatedPath: "ad_detail") ?? FirebaseAdsModel()
       } catch {
           print("【 \(CalendarTool.showCurrentTimeString(true)) 】_______【 Firebase 】_______【 解析本地啊广告配置失败 】")
       }
    }
    
    // 全新请求广告数据，会清除历史广告数据
    func requestAds() {
        loadStartAds()
        // 延长执行
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadDefaultAds()
        }
    }
    
    // 以ID为单位，每个ID里有多个（高中低）数据，按顺序去取
    private func loadStartAds() {
        if PayConfig.shared.isPaied {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_AD_REQUEST), object: nil)
            }
            return
        }
        loadStartViewAds()
    }
    
    private func loadDefaultAds() {
        if PayConfig.shared.isPaied {
            return
        }
        loadNativeViewAds()
        loadInterstitialViewAds()
        loadBannerViewAds()
    }
    
    @objc func isCheckAdViewAllRespontNotification(_ notification: Notification) {
        if PayConfig.shared.isPaied {
            if !shouldRequestNotification {
                shouldRequestNotification = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    NotificationCenter.default.post(name: Notification.Name(NOTIFICATION_AD_REQUEST_SUCCESS), object: nil)
                }
            }
        } else {
//            var startBool: Bool = false
            var nativrBool: Bool = false
            var bannerBool: Bool = true
            var interBool: Bool = false
//            for itemView in startAds {
//                if !itemView.admobModel.isRequesting {
//                    startBool = true
//                    break
//                }
//            }
            for itemView in nativeAds {
                if !itemView.admobModel.isRequesting {
                    nativrBool = true
                    break
                }
            }
            for itemView in bannerAds {
                if !itemView.admobModel.isRequesting {
                    bannerBool = true
                    break
                }
            }
            for itemView in interAds {
                if !itemView.admobModel.isRequesting {
                    interBool = true
                    break
                }
            }
            if !firebaseConfigModel.ad_ctrl.inter_enable {
                interBool = true
            }
            if !firebaseConfigModel.ad_ctrl.banner_enable {
                bannerBool = true
            }
            if !firebaseConfigModel.ad_ctrl.native_enable {
                nativrBool = true
            }
            if interBool && bannerBool && nativrBool {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    NotificationCenter.default.post(name: Notification.Name(NOTIFICATION_AD_REQUEST_SUCCESS), object: nil)
                }
            }
        }
    }
}


// MARK: Start / Open 开屏广告
extension FirebaseNetwork {
    
    func loadStartViewAds() {
        if PayConfig.shared.isPaied {
            return
        }
        startAds = []
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            for item in itemValue {
                if item.ad_type.contains("APP_OPEN") {
                    for _ in 0..<item.ad_repeatRequest {
                        let viewController = StartViewController(.zero, FirebaseAdsItemModel(item))
                        viewController.loadStartAd()
                        startAds.append(viewController)
                    }
                }
            }
        }
    }
    
    // 更新广告数据,不管重复多少个，必须把重复的全部使用完再请求
    func loadStartAdViewModel() -> (FirebaseAdsItemModel, Bool) {
        var findModel: FirebaseAdsItemModel?
        if PayConfig.shared.isPaied {
            return (findModel ?? FirebaseAdsItemModel(), false)
        }
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            // high / mid / all
            var find: Bool = false
            for indexValue in itemValue {
                for adItem in startAds {
                    if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                        if ((CalendarTool.currentTimeInterval() - adItem.admobModel.adRealTime <= adItem.admobModel.cacheSeconds) && (adItem.admobModel.startAd != nil)) {
                            if !find {
                                if findModel == nil {
                                    findModel = adItem.admobModel
                                }
                                find = true
                                break
                            }
                        }
                    }
                }
                if !find {
                    for adItem in startAds {
                        if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                            adItem.loadStartAd()
                        }
                    }
                }
            }
        }
        return (findModel ?? FirebaseAdsItemModel(), (findModel?.startAd != nil) ? true : false)
    }
}

// MARK: INTERSTITIAL / Interstitial 插页广告
extension FirebaseNetwork {
    
    func loadInterstitialViewAds() {
        if PayConfig.shared.isPaied {
            return
        }
        if !firebaseConfigModel.ad_ctrl.inter_enable {
            return
        }
        interAds = []
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            for item in itemValue {
                if item.ad_type.contains("INTERSTITIAL") {
                    for _ in 0..<item.ad_repeatRequest {
                        let viewController = InterstitialViewController(.zero, FirebaseAdsItemModel(item))
                        viewController.loadInterstitialAd()
                        interAds.append(viewController)
                    }
                }
            }
        }
    }
    
    // 更新广告数据,不管重复多少个，必须把重复的全部使用完再请求
    func loadInterstitialAdViewModel() -> (FirebaseAdsItemModel, Bool) {
        var findModel: FirebaseAdsItemModel?
        if PayConfig.shared.isPaied {
            return (findModel ?? FirebaseAdsItemModel(), false)
        }
        if !firebaseConfigModel.ad_ctrl.inter_enable {
            return (FirebaseAdsItemModel(), false)
        }
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            // high / mid / all
            var find: Bool = false
            for indexValue in itemValue {
                for adItem in interAds {
                    if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                        if ((CalendarTool.currentTimeInterval() - adItem.admobModel.adRealTime <= adItem.admobModel.cacheSeconds) && (adItem.admobModel.interstitialAd != nil)) {
                            if !find {
                                if findModel == nil {
                                    findModel = adItem.admobModel
                                }
                                find = true
                                break
                            }
                        }
                    }
                }
                if !find {
                    for adItem in interAds {
                        if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                            adItem.loadInterstitialAd()
                        }
                    }
                }
            }
        }
        return (findModel ?? FirebaseAdsItemModel(), (findModel?.interstitialAd != nil) ? true : false)
    }
}

// MARK: Banner 横幅广告
extension FirebaseNetwork {
    
    func loadBannerViewAds() {
        if PayConfig.shared.isPaied {
            return
        }
        if !firebaseConfigModel.ad_ctrl.banner_enable {
            return
        }
        bannerAds = []
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            for item in itemValue {
                if item.ad_type.contains("BANNER") {
                    for _ in 0..<item.ad_repeatRequest {
                        let viewController = BannerViewController(BANNERSIZE, FirebaseAdsItemModel(item))
                        viewController.loadBannerAd()
                        bannerAds.append(viewController)
                    }
                }
            }
        }
    }
    
    // 更新广告数据,不管重复多少个，必须把重复的全部使用完再请求
    func loadBannerAdViewModel() -> (FirebaseAdsItemModel, Bool) {
        var findModel: FirebaseAdsItemModel?
        if PayConfig.shared.isPaied {
            return (findModel ?? FirebaseAdsItemModel(), false)
        }
        if !firebaseConfigModel.ad_ctrl.banner_enable {
            return (FirebaseAdsItemModel(), false)
        }
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            // high / mid / all
            var find: Bool = false
            for indexValue in itemValue {
                for adItem in bannerAds {
                    if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                        if ((CalendarTool.currentTimeInterval() - adItem.admobModel.adRealTime <= adItem.admobModel.cacheSeconds) && (adItem.admobModel.bannerAd != nil)) {
                            if !find {
                                if findModel == nil {
                                    findModel = adItem.admobModel
                                }
                                find = true
                                break
                            }
                        }
                    }
                }
                if !find {
                    for adItem in bannerAds {
                        if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                            adItem.loadBannerAd()
                        }
                    }
                }
            }
        }
        return (findModel ?? FirebaseAdsItemModel(), (findModel?.bannerAd != nil) ? true : false)
    }
}

// MARK: Native 原生广告
extension FirebaseNetwork {
    
    func loadNativeViewAds() {
        if PayConfig.shared.isPaied {
            return
        }
        if !firebaseConfigModel.ad_ctrl.native_enable {
            return
        }
        nativeAds = []
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            for item in itemValue {
                if item.ad_type.contains("NATIVE") {
                    for _ in 0..<item.ad_repeatRequest {
                        let viewController = NativeViewController(BANNERSIZE, FirebaseAdsItemModel(item))
                        viewController.loadNativeAd()
                        nativeAds.append(viewController)
                    }
                }
            }
        }
    }
    
    // 更新广告数据,不管重复多少个，必须把重复的全部使用完再请求
    func loadNativeAdViewModel() -> (FirebaseAdsItemModel, Bool) {
        var findModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
        if PayConfig.shared.isPaied {
            return (findModel, false)
        }
        if !firebaseConfigModel.ad_ctrl.native_enable {
            return (FirebaseAdsItemModel(), false)
        }
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            // high / mid / all
            var find: Bool = false
            for indexValue in itemValue {
                for adItem in nativeAds {
                    if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                        if ((CalendarTool.currentTimeInterval() - adItem.admobModel.adRealTime <= adItem.admobModel.cacheSeconds) && (adItem.admobModel.nativeAd != nil)) {
                            if !find {
                                if findModel.nativeAd == nil {
                                    findModel = adItem.admobModel
                                }
                                find = true
                                break
                            }
                        }
                    }
                }
                if !find {
                    for adItem in nativeAds {
                        if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                            adItem.loadNativeAd()
                        }
                    }
                }
            }
        }
        return (findModel, (findModel.nativeAd != nil) ? true : false)
    }
}

// MARK: REWARD / Reward 激励广告
extension FirebaseNetwork {
    
    func loadRewardViewAds() {
        if PayConfig.shared.isPaied {
            return
        }
        rewardAds = []
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            for item in itemValue {
                if item.ad_type.contains("REWARD") {
                    for _ in 0..<item.ad_repeatRequest {
                        let viewController = RewardViewController(.zero, FirebaseAdsItemModel(item))
                        viewController.loadRewardAd()
                        rewardAds.append(viewController)
                    }
                }
            }
        }
    }
    
    // 更新广告数据,不管重复多少个，必须把重复的全部使用完再请求
    func loadRewardAdViewModel() -> (FirebaseAdsItemModel, Bool) {
        var findModel: FirebaseAdsItemModel?
        if PayConfig.shared.isPaied {
            return (findModel ?? FirebaseAdsItemModel(), false)
        }
        for itemValue in firebaseConfigModel.ad_detail.value_ads {
            // high / mid / all
            var find: Bool = false
            for indexValue in itemValue {
                for adItem in rewardAds {
                    if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                        if !((CalendarTool.currentTimeInterval() - adItem.admobModel.adRealTime <= adItem.admobModel.cacheSeconds) || (adItem.admobModel.rewardedAd == nil)) {
                            if !find {
                                if findModel == nil {
                                    findModel = adItem.admobModel
                                }
                                find = true
                                break
                            }
                        }
                    }
                }
                if !find {
                    for adItem in rewardAds {
                        if (adItem.admobModel.ad_id == indexValue.ad_id) && (adItem.admobModel.ad_name == indexValue.ad_name)  {
                            adItem.loadRewardAd()
                        }
                    }
                }
            }
        }
        return (findModel ?? FirebaseAdsItemModel(), (findModel?.rewardedAd != nil) ? true : false)
    }
}
