//
//  WidgetStyle.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//

import WidgetKit
import SwiftUI
import HandyJSON
import CoreTelephony
import SystemConfiguration
import AVFoundation
import CoreBluetooth
import UIKit

struct WidgetStyle {
    
    // 编辑页面 ， 字体渐变Color 选择
    static let textGradientColors: [String] = [
        Color.String_Color_FAD0C4 + "-" + Color.String_Color_FF9A9E,
        Color.String_Color_FCB69F + "-" + Color.String_Color_FFECD2,
        Color.String_Color_FECFEF + "-" + Color.String_Color_FF9A9E,
        Color.String_Color_C2E9FB + "-" + Color.String_Color_A1C4FD,
        Color.String_Color_F5F7FA + "-" + Color.String_Color_C3CFE2,
        Color.String_Color_667EEA + "-" + Color.String_Color_764BA2,
        Color.String_Color_89F7FE + "-" + Color.String_Color_66A6FF
    ]
    
    // 编辑页面 ， 背景Color 选择
    static let backgroundColors: [String] = [
        Color.String_Color_FFF6EA,
        Color.String_Color_000000,
        Color.String_Color_FFA531,
        Color.String_Color_FDA5A1,
        Color.String_Color_FFD171,
        Color.String_Color_BCEDCF,
        Color.String_Color_C3F2F8,
        Color.String_Color_E7E8FD,
        Color.String_Color_C0DDED,
        Color.String_Color_015EA1
    ]
    
    // 编辑页面 ，背景图片选择

    static let backgroundImageNames: [ String ] = [
        
        // iamgeString
//        "",
////       "add_image",    // 先没有选择照片
//        "backgroundImageName_2",
//       "backgroundImageName_3",
//       "backgroundImageName_4",
//       "backgroundImageName_5",
        
        
        Color.String_Color_FFF6EA,
        Color.String_Color_000000,
        Color.String_Color_FFA531,
        Color.String_Color_FDA5A1,
        Color.String_Color_FFD171,
        Color.String_Color_BCEDCF,
        Color.String_Color_C3F2F8,
        Color.String_Color_E7E8FD,
        Color.String_Color_C0DDED,
        Color.String_Color_015EA1
        
        
    ]
    
    // 编辑界面字体选择
    static let textFonts: [Int] = [0, 1, 2, 3]
    
}


extension WidgetUi {
    
    func getJRWidgetUi() -> JRWidgetConfigure? {
        let configure = JRWidgetConfigure()
        configure.backgroundColor = String(self.color)
        return configure
    }
}

extension String {

    func getWidgetView(ui: JRWidgetConfigure?) -> AnyView? {
        switch WidgetType(rawValue: ui?.nameConfig?.widgetType ?? -1) {
        case .clock:
            return AnyView(ClockListConfig(widgetFamily: 0, configure: ui).itemView())
        case .calendar:
            return AnyView(CalendarConfig(widgetFamily: 0, configure: ui).itemView())
        case .XPanel:
            return AnyView(XPanelConfig(widgetFamily: 0, configure: ui).itemView())
        case .none:
            return nil
        }
    }
    
    func getBackgroundColor() -> Color? {
        if let index = Int(self), index < WidgetStyle.backgroundColors.count {
            if index >= 0 {
                return Color.color(hexString: WidgetStyle.backgroundColors[index])
            }
        }
        return nil
    }
    
    func classFromString() -> AnyClass? {
        // 1、获swift中的命名空间名
        var name = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String
        // 2、如果包名中有'-'横线这样的字符，在拿到包名后，还需要把包名的'-'转换成'_'下横线
        name = name?.replacingOccurrences(of: "-", with: "_")
        // 3、拼接命名空间和类名，”包名.类名“
        let fullClassName = name! + "." + self
        // 通过NSClassFromString获取到最终的类
        let anyClass: AnyClass? = NSClassFromString(fullClassName)
        // 本类type
        return anyClass
    }
    
}

extension String {
    var upperFirstLetter: String {
        return String(self.prefix(1).capitalized + self.dropFirst())
    }
}

protocol JRWidgetView: View {

    // 初始布局的展示
    var configure: JRWidgetConfigure? { get set }

    // 通过观察 更改，变幻
    init(_ configure: JRWidgetConfigure?)
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat) -> CGFloat

}

// 个人页面

enum MType: CGFloat {
    case small
    case medium
    case large
    var value: Double {
        switch self {
        case .small:
            return 1
        case .medium:
            return 364/170
        case .large:
            return 364/382
        }
    }
    var scale: Double {
        switch self {
        case .small:
            return 0.74
        case .medium:
            return 0.51
        case .large:
            return 0.51
        }
    }
}

extension UIView {
    func crop(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: -rect.origin.x, y: -rect.origin.y)
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIImage {
    func crop(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: -rect.origin.x, y: -rect.origin.y)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


struct DeviceInfoUtil {
    
    //MARK: - UIDevice延展

    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPhone1,1":                                       return "iPhone"
        case "iPhone1,2":                                       return "iPhone 3G"
        case "iPhone2,1":                                       return "iPhone 3GS"
        case "iPhone3,1",   "iPhone3,2", "iPhone3,3":             return "iPhone 4"
        case "iPhone4,1",   "iPhone4,2", "iPhone4,3":             return "iPhone 4S"
        case "iPhone5,1",   "iPhone5,2":                          return "iPhone 5"
        case "iPhone5,3",   "iPhone5,4":                          return "iPhone 5C"
        case "iPhone6,1",   "iPhone6,2":                          return "iPhone 5S"
        case "iPhone7,1":                                       return "iPhone 6 Plus"
        case "iPhone7,2":                                       return "iPhone 6"
        case "iPhone8,1":                                       return "iPhone 6S"
        case "iPhone8,2":                                       return "iPhone 6S Plus"
        case "iPhone8,4":                                       return "iPhone SE"
        case "iPhone9,1",   "iPhone9,3":                           return "iPhone 7"
        case "iPhone9,2",   "iPhone9,4":                           return "iPhone 7 Plus"
        case "iPhone10,1",  "iPhone10,4":                         return "iPhone 8"
        case "iPhone10,2",  "iPhone10,5":                         return "iPhone 8 Plus"
        case "iPhone10,3",  "iPhone10,6":                         return "iPhone X"
        case "iPhone11,2":                                       return "iPhone Xs"
        case "iPhone11,4",  "iPhone11,6":                         return "iPhone Xs Max"
        case "iPhone11,8":                                       return "iPhone Xr"
        case "iPhone12,1":                                       return "iPhone 11"
        case "iPhone12,3":                                       return "iPhone 11 Pro"
        case "iPhone12,5":                                       return "iPhone 11 Pro Max"
        case "iPhone12,8":                                       return "iPhone SE 2"
        case "iPhone13,1":                                       return "iPhone 12 mini"
        case "iPhone13,2":                                       return "iPhone 12"
        case "iPhone13,3":                                       return "iPhone 12 Pro"
        case "iPhone13,4":                                       return "iPhone 12 Pro Max"
        case "iPhone14,4":                                       return "iPhone 13 mini"
        case "iPhone14,5":                                       return "iPhone 13"
        case "iPhone14,2":                                       return "iPhone 13 Pro"
        case "iPhone14,3":                                       return "iPhone 13 Pro Max"
        case "iPhone14,6":                                       return "iPhone SE 3"
        case "iPhone14,7":                                       return "iPhone 14"
        case "iPhone14,8":                                       return "iPhone 14 Plus"
        case "iPhone15,2":                                       return "iPhone 14 Pro"
        case "iPhone15,3":                                       return "iPhone 14 Pro Max"
        case "iPhone15,4":                                       return "iPhone 15"
        case "iPhone15,5":                                       return "iPhone 15 Plus"
        case "iPhone16,1":                                       return "iPhone 15 Pro"
        case "iPhone16,2":                                       return "iPhone 15 Pro Max"
        case "i386", "x86_64":                                   return "Simulator"
        default:  return identifier
        }
    }
    
    // iphone / ipad/ mac
    static func getDeviceModel() -> String {
        let device = UIDevice.current
        return device.model
    }
    
    static func getIdentifierID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    // name ： xxx 的 iphone 15 pro max， xxx 的 iphone / 获取设备名称 例如：梓辰的手机
    static func getDeviceName() -> String {
        let device = UIDevice.current
        return device.name
    }
    
    // ios 17.0.1
    static func getDevicesystemVersion() -> String {
        let device = UIDevice.current
        return device.systemVersion
    }
    
    ///获取appundle
    static func getappBundleID() -> String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    /// app名称
    static func getappName() -> String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    ///获取app版本
    static func getappSVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    // 判断Wi-Fi 的情况
    static func wiFiStatus() -> Bool {
        let wifiState = DeviceInfoUtil.getNetworkType().1
        return wifiState
    }
    
    ///获取系统音量大小
    static func getSystemVolumValue() -> CGFloat {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            let currentVolume = AVAudioSession.sharedInstance().outputVolume
            return CGFloat(currentVolume)
        } catch {
            return 0
        }
    }
    
    ///获取系统、蓝牙开关
    static func getBluetoothState() -> Bool {
        let bluetoothState = BluetoothManager().getBluetoothStatus()
        return bluetoothState
    }
    
    ///获取系统 屏幕亮度
    static func getBrightness() -> CGFloat {
        let brightness = UIScreen.main.brightness
        return brightness
    }
    
    /// 获取网络类型
    public static func getNetworkType() -> (String, Bool) {
        var zeroAddress = sockaddr_storage()
        bzero(&zeroAddress, MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_len = __uint8_t(MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { address in
                SCNetworkReachabilityCreateWithAddress(nil, address)
            }
        }
        guard let defaultRouteReachability = defaultRouteReachability else {
            return (notReachable, false)
        }
        var flags = SCNetworkReachabilityFlags()
        let didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        
        guard didRetrieveFlags == true,
              (flags.contains(.reachable) && !flags.contains(.connectionRequired)) == true
        else {
            return (notReachable, false)
        }
        if flags.contains(.connectionRequired) {
            return (notReachable, false)
        } else if flags.contains(.isWWAN) {
            return (self.cellularType(), false)
        } else {
            return ("WiFi", true)
        }
    }

    
    /// 获取蜂窝数据类型
    private static func cellularType() -> String {
        let info = CTTelephonyNetworkInfo()
        var status: String
        
        if #available(iOS 12.0, *) {
            guard let dict = info.serviceCurrentRadioAccessTechnology,
                  let firstKey = dict.keys.first,
                  let statusTemp = dict[firstKey] else {
                return notReachable
            }
            status = statusTemp
        } else {
            guard let statusTemp = info.currentRadioAccessTechnology else {
                return notReachable
            }
            status = statusTemp
        }
        
        if #available(iOS 14.1, *) {
            if status == CTRadioAccessTechnologyNR || status == CTRadioAccessTechnologyNRNSA {
                return "5G"
            }
        }
        
        switch status {
        case CTRadioAccessTechnologyGPRS,
            CTRadioAccessTechnologyEdge,
        CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyWCDMA,
            CTRadioAccessTechnologyHSDPA,
            CTRadioAccessTechnologyHSUPA,
            CTRadioAccessTechnologyeHRPD,
            CTRadioAccessTechnologyCDMAEVDORev0,
            CTRadioAccessTechnologyCDMAEVDORevA,
        CTRadioAccessTechnologyCDMAEVDORevB:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return notReachable
        }
    }
    
    /// 无网络返回字样
    private static var notReachable: String {
        get {
            return "notReachable"
        }
    }
    
    static func getChipModel() -> String {
        let modelName = DeviceInfoUtil.modelName.lowercased()
        if modelName == ("iphone 6") || modelName == ("iphone 6 plus") {
            return "A8"
        } else if modelName == ("iphone se") || modelName == ("iphone 6s") || modelName == ("iphone 6s plus")  {
            return "A9"
        } else if modelName == ("iphone 7") || modelName == ("iphone 7 plus") {
            return "A10 Fusion"
        } else if modelName == ("iphone 8") || modelName == ("iphone 8 plus") {
            return "A11 Bionic"
        } else if modelName == ("iphone x") {
            return "A11 Bionic"
        } else if modelName == ("iphone xr") || modelName == ("iphone xs") || modelName == ("iphone xs max") {
            return "A12 Bionic"
        } else if modelName == ("iphone 11") {
            return "A13 Bionic"
        } else if modelName == ("iphone se (2nd generation)") {
            return "A13 Bionic"
        } else if modelName == ("iphone 12 mini") || modelName == ("iphone 12") || modelName == ("iphone 12 pro") || modelName == ("iphone 12 pro max") {
            return "A14 Bionic"
        } else if modelName == ("iphone 13 mini") || modelName == ("iphone 13") || modelName == ("iphone 13 pro") || modelName == ("iphone 13 pro max") || modelName == ("iphone 14") || modelName == ("iphone 14 plus") || modelName == ("iphone se (3rd generation)") {
            return "A15 Bionic"
        } else if modelName == ("iphone 14 pro") || modelName == ("iphone 14 pro max") || modelName == ("iphone 15") || modelName == ("iphone 15 plus") {
            return "A16 Bionic"
        } else if modelName == ("iphone 15 pro") || modelName == ("iphone 15 pro max") {
            return "A17 pro Chip"
        }
        return "Unknown"
    }
}


struct CircleSection: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var isCircle: Bool = false

    func path(in rect: CGRect) -> Path {
        var path = Path()
        if isCircle {
           
            // 计算圆心和半径
                  let center = CGPoint(x: rect.midX, y: rect.midY)
                  let radius = rect.width / 2
                  
                  // 添加起始直线段
                  path.move(to: CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)),
                                        y: center.y + radius * sin(CGFloat(startAngle.radians))))
                  
                  // 添加起始圆角
                  path.addArc(tangent1End: CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)),
                                                   y: center.y + radius * sin(CGFloat(startAngle.radians))),
                              tangent2End: CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians + .pi / 2)),
                                                   y: center.y + radius * sin(CGFloat(startAngle.radians + .pi / 2))),
                              radius: radius)
                  
                  // 添加结束直线段
                  path.addLine(to: CGPoint(x: center.x + radius * cos(CGFloat(endAngle.radians)),
                                           y: center.y + radius * sin(CGFloat(endAngle.radians))))
                  
                  // 添加结束圆角
                  path.addArc(tangent1End: CGPoint(x: center.x + radius * cos(CGFloat(endAngle.radians)),
                                                   y: center.y + radius * sin(CGFloat(endAngle.radians))),
                              tangent2End: CGPoint(x: center.x + radius * cos(CGFloat(endAngle.radians - .pi / 2)),
                                                   y: center.y + radius * sin(CGFloat(endAngle.radians - .pi / 2))),
                              radius: radius)
                  
        } else {
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.width / 2,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
        }
        return path
    }
}


class BluetoothManager: NSObject, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager!
    var isBluetoothOn: Bool = false

    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: false])
        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothOn = true
        } else {
            isBluetoothOn = false
        }
    }

    func getBluetoothStatus() -> Bool {
        print("test:\(centralManager?.state)")
        return centralManager?.state != .poweredOff && centralManager?.state != .unauthorized && centralManager?.state != .unsupported
    }
}



extension UIDevice {
    
    func getBatteryRatio() -> (Double , Double) {
        return (Double(270), Double(270) + Double(0.5 * 360 / 100))
    }
    
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    // 比例要话一个圆，从什么角度到什么角度，默认从中上位置开始（圆认为中左为0，）那么就从270开始
    func getMemoryUsageRatio() -> (Double , Double) {
        return (Double(270), Double(270) + Double(usedDiskSpaceInBytes * 360 / totalDiskSpaceInBytes))
    }
    
    //MARK: Get String Value
    var totalDiskSpaceInGB: String {
       return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var freeDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var usedDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var totalDiskSpaceInMB: String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    
    var freeDiskSpaceInMB: String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    
    var usedDiskSpaceInMB: String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
    
    //MARK: Get raw value
    var totalDiskSpaceInBytes: Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    
    /*
     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
     */
    var freeDiskSpaceInBytes: Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }
    
    var usedDiskSpaceInBytes: Int64 {
       return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
}
