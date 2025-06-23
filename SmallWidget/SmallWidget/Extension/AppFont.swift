//
//  AppFont.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/5.
//

import SwiftUI




enum FontName: Int {
    case SFPro = 0
    case Shrikhand = 1
    case Arbutus = 2
    case VastShadow = 3
}


extension Font {
    
    static func SWidth(_ fontSize: CGFloat, _ maxHeight: CGFloat) -> CGFloat {
        return maxHeight * fontSize / 155
    }
}



/**
 ==================================================== 【 SF_Pro 】 ================================ 【 SF_Pro 】========================================= 【 SF_Pro 】=================================================================
 */

extension Font {
    
    // 显式定义
    static func S_Pro_2(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 1 : 2), maxHeight)) }
    static func S_Pro_3(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 2 : 3), maxHeight)) }
    static func S_Pro_4(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 3 : 4), maxHeight)) }
    static func S_Pro_5(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 4 : 5), maxHeight)) }
    static func S_Pro_6(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 5 : 6), maxHeight)) }
    static func S_Pro_7(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 6 : 7), maxHeight)) }
    static func S_Pro_8(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 7 : 8), maxHeight)) }
    static func S_Pro_9(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 7 : 9), maxHeight)) }
    static func S_Pro_10(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 8 : 10), maxHeight)) }
    static func S_Pro_11(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 9 : 11), maxHeight)) }
    static func S_Pro_12(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 10 : 12), maxHeight)) }
    static func S_Pro_13(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 11 : 13), maxHeight)) }
    static func S_Pro_14(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 12 : 14), maxHeight)) }
    static func S_Pro_15(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 13 : 15), maxHeight)) }
    static func S_Pro_16(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 14 : 16), maxHeight)) }
    static func S_Pro_17(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 15 : 17), maxHeight)) }
    static func S_Pro_18(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 16 : 18), maxHeight)) }
    static func S_Pro_19(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 17 : 19), maxHeight)) }
    static func S_Pro_20(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 18 : 20), maxHeight)) }
    static func S_Pro_21(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 19 : 21), maxHeight)) }
    static func S_Pro_22(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 20 : 22), maxHeight)) }
    static func S_Pro_23(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 21 : 23), maxHeight)) }
    static func S_Pro_24(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 22 : 24), maxHeight)) }
    static func S_Pro_25(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 23 : 25), maxHeight)) }
    static func S_Pro_28(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 23 : 28), maxHeight)) }
    static func S_Pro_29(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 24 : 29), maxHeight)) }
    static func S_Pro_30(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 25 : 30), maxHeight)) }
    static func S_Pro_35(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 30 : 35), maxHeight)) }
    static func S_Pro_38(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 33 : 38), maxHeight)) }
    static func S_Pro_39(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 34 : 39), maxHeight)) }
    static func S_Pro_40(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 35 : 40), maxHeight)) }
    static func S_Pro_45(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 40 : 45), maxHeight)) }
    static func S_Pro_50(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 40 : 50), maxHeight)) }
    static func S_Pro_60(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 50 : 60), maxHeight)) }
    static func S_Pro_70(_ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth((nameFont == FontName.Shrikhand.rawValue || nameFont == FontName.VastShadow.rawValue ? 60 : 70), maxHeight)) }

    // 自定义公共方式，适配个别字号
    static func S_Pro(size: CGFloat, _ weight: Font.Weight = .regular, _ maxHeight: CGFloat = 155, _ nameFont: Int = 0) -> Font { Font.custom(proFontName(weight, nameFont), size: SWidth(size, maxHeight)) }

    // TODO: 咩有 中体，粗体
    static func proFontName(_ weight: Font.Weight, _ nameFont: Int = 0) -> String {
        switch nameFont {
        case FontName.SFPro.rawValue:
            switch weight {
            case .regular:
                return "SFPro-Regular"
            case .medium:
                return "SFPro-Medium"
            case .bold:
                return "SFPro-Bold"
            default:
                return "SFPro-Regular"
            }
        case FontName.Shrikhand.rawValue:
            switch weight {
            case .regular:
                return "Shrikhand-Regular"
            case .medium:
                return "Shrikhand-Regular"
            case .bold:
                return "Shrikhand-Regular"
            default:
                return "Shrikhand-Regular"
            }
        case FontName.Arbutus.rawValue:
            switch weight {
            case .regular:
                return "Arbutus-Regular"
            case .medium:
                return "Arbutus-Regular"
            case .bold:
                return "Arbutus-Regular"
            default:
                return "Arbutus-Regular"
            }
        case FontName.VastShadow.rawValue:
            switch weight {
            case .regular:
                return "VastShadow-Regular"
            case .medium:
                return "VastShadow-Regular"
            case .bold:
                return "VastShadow-Regular"
            default:
                return "VastShadow-Regular"
            }
        default:
            switch weight {
            case .regular:
                return "SFPro-Regular"
            case .medium:
                return "SFPro-Medium"
            case .bold:
                return "SFPro-Bold"
            default:
                return "SFPro-Regular"
            }
        }
    }
    
    static func textType(_ textType: Int?) -> Font.Weight {
        switch textType {
        case 0:
            return .regular
        case 1:
            return .medium
        case 2:
            return .bold
        case .none:
            return .regular
        case .some(_):
            return .regular
        }
    }
    
}

extension UIFont {
    
    // 显式定义
    static func S_Pro_8(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(8, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(8, maxHeight), weight: weight) }
    static func S_Pro_10(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(10, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(10, maxHeight), weight: weight) }
    static func S_Pro_11(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(11, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(11, maxHeight), weight: weight) }
    static func S_Pro_12(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(12, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(12, maxHeight), weight: weight) }
    static func S_Pro_13(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(13, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(13, maxHeight), weight: weight) }
    static func S_Pro_14(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(14, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(14, maxHeight), weight: weight) }
    static func S_Pro_15(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(15, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(15, maxHeight), weight: weight) }
    static func S_Pro_16(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(16, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(16, maxHeight), weight: weight) }
    static func S_Pro_17(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(17, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(17, maxHeight), weight: weight) }
    static func S_Pro_18(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(18, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(18, maxHeight), weight: weight) }
    static func S_Pro_19(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(19, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(19, maxHeight), weight: weight) }
    static func S_Pro_20(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(20, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(20, maxHeight), weight: weight) }
    static func S_Pro_21(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(21, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(21, maxHeight), weight: weight) }
    static func S_Pro_22(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(22, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(22, maxHeight), weight: weight) }
    static func S_Pro_23(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(23, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(23, maxHeight), weight: weight) }
    static func S_Pro_24(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(24, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(24, maxHeight), weight: weight) }
    static func S_Pro_25(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(25, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(25, maxHeight), weight: weight) }
    static func S_Pro_30(_ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(30, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(30, maxHeight), weight: weight) }
    
    // 自定义公共方式，适配个别字号
    static func S_Pro(size: CGFloat, _ weight: Weight = .regular, _ maxHeight: CGFloat = 155) -> UIFont { UIFont(name: proFontName(weight), size: Font.SWidth(size, maxHeight)) ?? UIFont.systemFont(ofSize: Font.SWidth(size, maxHeight), weight: weight) }

    static func proFontName(_ weight: UIFont.Weight) -> String {
        switch weight {
        case .regular:
            return "SFPro-Regular"
        case .medium:
            return "SFPro-Medium"
        case .bold:
            return "SFPro-Bold"
        default:
            return "SFPro-Regular"
        }
    }
}
