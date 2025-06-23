//
//  PayConfig.swift
//  SmallWidget
//
//  Created by Q801 on 2024/7/30.
//

import Foundation
import StoreKit

/// 商品列表
enum ProductIdType: String {
//    case forever   = "com.focus.widget.theme.lock1"
    case weekly   = "focus.widget.theme.lock.weekly"
}

/// 回调状态
enum PayProgress: String {
    /// 初始状态
    case none = ""
    /// 初始状态
    case unavailable = "Payment environment unavailable"
    /// 开始
    case started = "Start"
    /// 购买中
    case purchasing = "Paying"
    /// 支付成功
    case purchased = "Payment Successful"
    /// 失败
    case payFailed = "Payment Failed"
    /// 重复购买
    case payRestored = "Repeat Successful"
    /// 状态未确认
    case payDeferred = "Status Unconfirmed"
    /// 其他
    case payOther = "Unknown Error"
    /// 取消支付
    case cancel = "Cancel"
    /// 没有可以恢复的
    case noRestored = "No Repeat"
    /// 验证中
    case verifying
}

enum PayCheck: String {
    /// 未初始化
    case notInit = "No Init"
    /// 初始化失败
    case initFailed = "Init Failed"
    /// 没有找到该商品，中断
    case notFound = "Not Found Product"
    /// 系统检测失败
    case systemFailed = "System Failed"
    /// 可以进行
    case ok = "Ok"
}

class PayConfig: NSObject, ObservableObject {

    static let shared = PayConfig()

    /// 是否已经购买
    @Published var isPaied : Bool = false
    /// 购买环境
    @Published var payCheck : PayCheck = .notInit
    /// 购买进度
    @Published var progress : PayProgress = .none
    /// 当前付费的ID
    @Published var currentSelectedPID: ProductIdType = .weekly
    /// 商品列表
    @Published var productList: [SKProduct]?
    
    override init() {
        super.init()
        print("【 PayConfig 】____ 【 init 】")
        // 判断本地支付时间是否过期
        if let localTime = BaseKeychinaUnit.keyChainReadData(identifier: currentSelectedPID.rawValue) as? String, let time = TimeInterval(localTime) {
            _ = determineWhetherCurrentTimeExpired(timeInterval: time)
        }
        checkPayments()
        if payCheck == .notInit {
            initPayments()
        }
    }
    
    /// 检测支付环境，非.ok不允许充值
    func checkPayments() {
        guard let plist = productList, !plist.isEmpty else {
            payCheck = .notInit
            return
        }
        guard SKPaymentQueue.canMakePayments() else {
            payCheck = .systemFailed
            return
        }
        payCheck = .ok
    }
    
    /// 初始化，请求商品列表
    func initPayments() {
        SKPaymentQueue.default().add(self)
        let set: Set<String> = [
            ProductIdType.weekly.rawValue,
        ]
        let request = SKProductsRequest(productIdentifiers: set)
        request.delegate = self
        request.start()
    }
    
    /// 支付商品
    func pay() {
        if payCheck == .ok {
            let pdts = productList?.filter {
                return $0.productIdentifier == currentSelectedPID.rawValue
            }
            guard let product = pdts?.first else {
                progress = .payFailed
                return
            }
            progress = .started
            print("【 PayConfig 】____ 【 payment 】____ 【 started 】")
            let pay: SKMutablePayment = SKMutablePayment(product: product)
            SKPaymentQueue.default().add(pay)
        } else {
            print("【 PayConfig 】____ 【 payment 】____ 【 unavailable 】")
            progress = .unavailable
        }
    }
    
    /// 恢复购买
    func restorePurchases() {
        if payCheck == .ok {
            progress = .started
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
}

// MARK: - SKProductsRequestDelegate
extension PayConfig: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productList = response.products
        payCheck = .ok
    }
    
    func requestDidFinish(_ request: SKRequest) {
        if let pList = productList, !pList.isEmpty {
            payCheck = .ok
        } else {
            payCheck = .initFailed
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        payCheck = .initFailed
    }
}

// MARK: - SKPaymentTransactionObserver
extension PayConfig: SKPaymentTransactionObserver {
        
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("【 PayConfig 】____ 【 payment 】____ 【 cancel 】")
        progress = .cancel
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("【 PayConfig 】____ 【 payment 】____ 【 verifying 】")
        if transactions.count > 0 {
            let transaction: SKPaymentTransaction = transactions.last!
            switch transaction.transactionState {
            case .purchasing:
                progress = .purchasing
            case .purchased:
                progress = .verifying
                verifyReceipts {
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
            case .failed:
                progress = .payFailed
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                progress = .verifying
                verifyReceipts {
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
            case .deferred:
                progress = .payDeferred
                SKPaymentQueue.default().finishTransaction(transaction)
            @unknown default:
                progress = .payOther
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if queue.transactions.count <= 0 {
            progress = .noRestored
        } else {
            for transaction in queue.transactions {
                if transaction.payment.productIdentifier == currentSelectedPID.rawValue {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    progress = .payRestored
                }
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        progress = .payOther
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}


extension PayConfig {
    
    func verifyReceipts(completion: @escaping () -> ()) {
        do {
            if let receiptURL = Bundle.main.appStoreReceiptURL, let receiptData = try? Data(contentsOf: receiptURL, options: .alwaysMapped) {
                let receiptString = receiptData.base64EncodedString()
                var verifyReceipt:String = "https://sandbox.itunes.apple.com/verifyReceipt"
                #if !DEBUG
                    verifyReceipt = "https://buy.itunes.apple.com/verifyReceipt"
                #endif
                let purchaseURL = URL(string: verifyReceipt)!
                var request = URLRequest(url: purchaseURL)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let jsonBody: [String: Any] = [
                                "receipt-data": receiptString,
                                "password": "45e685d660c44fff8dce68549c1cae1f" // App 专用共享密钥
                ]
                let jsonData = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
                request.httpBody = jsonData
                let task = URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
                    if error != nil {
                        completion()
                        self?.progress = .payDeferred
                        return
                    }
                    guard let data = data else {
                        completion()
                        self?.progress = .payDeferred
                        return
                    }
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let status = json["status"] as? Int {
                            if status == 0 {
                                if let receiptInfo = json["receipt"] as? [String: Any], let inAppReceipts = receiptInfo["in_app"] as? [[String: Any]] {
                                    for receipt in inAppReceipts {
                                        if let expiresDateString = receipt["expires_date"] as? String, let utcTimestamp = PayConfig.convertFlexibleTimestamp(dateString: expiresDateString) {
                                            print("【 PayConfig 】____ 【 verifying 】____ 【 currentTime: \(CalendarTool.dateFormatString(timeStamp: Int64(Date().timeIntervalSince1970))) 】____ 【 expiresTime: \(CalendarTool.dateFormatString(timeStamp: Int64(utcTimestamp))) 】")
                                            if !(self?.determineWhetherCurrentTimeExpired(timeInterval: ((utcTimestamp))) ?? true) {
                                                completion()
                                                print("【 PayConfig 】____ 【 verifying 】____ 【 有支付记录 - 未过期 】")
                                                print("【 PayConfig 】____ 【 verifying 】____ 【 currentTime: \(CalendarTool.dateFormatString(timeStamp: Int64(Date().timeIntervalSince1970))) 】____ 【 expiresTime: \(CalendarTool.dateFormatString(timeStamp: Int64(utcTimestamp))) 】")
                                                return
                                            }
                                        }
                                    }
                                }
                                print("【 PayConfig 】____ 【 verifying 】____ 【 有支付记录 - 全部已过期 】")
                                completion()
                            } else {
                                print("【 PayConfig 】____ 【 verifying 】____ 【 有订单 - 未支付 】")
                                completion()
                                self?.progress = .payDeferred
                            }
                        }
                    } catch {
                        self?.progress = .payDeferred
                        completion()
                    }
                }
                task.resume()
            }
        } catch {
            completion()
        }
    }
}

//
extension PayConfig {
    
    // 与当前时间戳比较，判断是否是过期
    // return false 没过期
    // return true 已过期
    func determineWhetherCurrentTimeExpired(timeInterval: TimeInterval) -> Bool {
        if Date().timeIntervalSince1970 < timeInterval {
            DispatchQueue.main.async {[weak self] in
                self?.isPaied = true
                self?.progress = .purchased
                // 本地保存其中一个没过期的时间戳
                _ = BaseKeychinaUnit.keyChainSaveData(data: String(timeInterval), withIdentifier: self?.currentSelectedPID.rawValue ?? "focus.widget.theme.lock.weekly")
            }
            return false
        } else {
            return true
        }
    }
}

extension PayConfig {
    
    static func convertFlexibleTimestamp(dateString: String) -> TimeInterval? {
        let formats = [
            "yyyy-MM-dd HH:mm:ss 'Etc/GMT'V",
            "yyyy-MM-dd HH:mm:ss Etc/GMT",
            "yyyy-MM-dd HH:mm:ss"
        ]
        for format in formats {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            if let date = formatter.date(from: dateString.components(separatedBy: " ").dropLast().joined(separator: " ")) {
                return date.timeIntervalSince1970
            }
        }
        return nil
    }
    
}
