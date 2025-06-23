//
//  WidgetExtensionUI.swift
//  SmallWidget
//
//  Created by Thomas on 2023/7/1.
//

import Foundation
import SwiftUI

extension WidgetEUi {
    
    func getJRWidgetUi() -> JRWidgetConfigure? {
        let configure = JRWidgetConfigure()
        configure.backgroundColor = self.backgroundColor ?? Color.String_Color_000000
        return configure
    }
}
