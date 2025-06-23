//
//  BatteryHelper.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/26.
//

import UIKit
import Combine

// 在Widget Extension 无法获取正确的电量
class BatteryHelper: ObservableObject {
        
    @Published var batteryLevel: Float = UIDevice.current.batteryLevel

    private var batteryObserver: NSObjectProtocol?

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        batteryObserver = NotificationCenter.default.addObserver(forName: UIDevice.batteryLevelDidChangeNotification, object: nil, queue: nil) { [weak self] _ in
            self?.batteryLevel = UIDevice.current.batteryLevel
        }
    }

    deinit {
        UIDevice.current.isBatteryMonitoringEnabled = false
        if let observer = batteryObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
