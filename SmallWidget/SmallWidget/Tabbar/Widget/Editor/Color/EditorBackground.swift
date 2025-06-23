//
//  EditorBackground.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/11.
//

import SwiftUI

struct EditorBackground: View {
    
    @ObservedObject var config: JRWidgetConfigure
    
    var backgroundColorStringDefault: String = String()
        
    init(config: JRWidgetConfigure) {
        self.config = config
    }
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: ViewLayout.S_W_5()){
            HStack {
                Text("Background")
                    .foregroundColor(Color.Color_393672)
                    .font(.S_Pro_14())
            }
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ViewLayout.S_W_20()) {
                    ForEach(WidgetStyle.backgroundImageNames.indices, id: \.self) { index in
                        Rectangle()
                            .fill(Color.color(hexString: WidgetStyle.backgroundImageNames[index]))
                            .frame(width: ViewLayout.S_W_55(), height: ViewLayout.S_W_55())
                            .cornerRadius(ViewLayout.S_W_10())
                            .overlay {
                                Image("selected_color")
                                    .fixedSize()
                                    .frame(width: 30, height: 30)
                                    .visibility(hidden: .constant(config.backgroundColor != WidgetStyle.backgroundImageNames[index]) )
                            }
                            .onTapGesture {
                                config.backgroundColor = WidgetStyle.backgroundImageNames[index]
                            }
                    }
                }
            }            
        }
    }
}


// ImageString

struct EditorBackgroundImageString: View {
    
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: ViewLayout.S_W_5()){
            HStack {
                Text("Background")
                    .foregroundColor(Color.Color_393672)
                    .font(.S_Pro_14())
                Spacer()
            }
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ViewLayout.S_W_20()) {
                    ForEach(WidgetStyle.backgroundImageNames.indices, id: \.self) { index in
                        if index == 0 {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: ViewLayout.S_W_55(), height: ViewLayout.S_W_55())
                                .cornerRadius(ViewLayout.S_W_10())
                                .overlay {
                                    Image(WidgetStyle.backgroundImageNames[index])
                                        .frame(width: ViewLayout.S_W_55(), height: ViewLayout.S_W_55())
                                        .cornerRadius(ViewLayout.S_W_10())
                                        .overlay {
                                            Image("selected_color")
                                                .fixedSize()
                                                .frame(width: 30, height: 30)
                                                .visibility(hidden: .constant(config.backgroundColor != WidgetStyle.backgroundImageNames[index]) )
                                        }
                                }
                                .onTapGesture {
                                    config.backgroundColor = WidgetStyle.backgroundImageNames[index]
                                }
                        }
                        else {
                            Rectangle()
                                .fill(((index == 0) || (index == 1)) ? Color.gray: Color.clear)
                                .frame(width: ViewLayout.S_W_55(), height: ViewLayout.S_W_55())
                                .cornerRadius(ViewLayout.S_W_10())
                                .overlay {
                                    Image(WidgetStyle.backgroundImageNames[index])
                                        .frame(width: ViewLayout.S_W_55(), height: ViewLayout.S_W_55())
                                        .cornerRadius(ViewLayout.S_W_10())
                                        .overlay {
                                            Image("selected_color")
                                                .fixedSize()
                                                .frame(width: 30, height: 30)
                                                .visibility(hidden: .constant(config.backgroundColor != WidgetStyle.backgroundImageNames[index]) )
                                        }
                                }
                                .onTapGesture {
                                    config.backgroundColor = WidgetStyle.backgroundImageNames[index]
                                }
                        }
                    }
                }
            }
        }
    }
}


struct EditorBackground_Previews: PreviewProvider {
    static var previews: some View {
        EditorBackground(config: JRWidgetConfigure())
    }
}
