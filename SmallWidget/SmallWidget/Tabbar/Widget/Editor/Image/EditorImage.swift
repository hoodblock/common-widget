//
//  EditorImage.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/11.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    var onSelectImageBlock: ((UIImage) -> Void)?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_: UIImagePickerController, context _: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.onSelectImageBlock?(uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct EditorImage: View {
    
    // 控制选择添加图片类型的ActionSheet弹出
    @State private var showImagePicker = false
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    @State private var selectedImage: UIImage? = nil
    @State var selectedTag: Int = 0

    var onSelectBlock: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: ViewLayout.S_W_5()) {
            HStack() {
                Text("Select Photo")
                    .foregroundColor(Color.Color_393672)
                    .font(.S_Pro_14())
            }
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    Button(action:{
                        self.showImagePicker.toggle()
                    }){
                        ZStack(alignment: .center) {
                            Image("image_add_available")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Image(uiImage: config.fillingImageStringArray[selectedTag]?.count ?? 0 > 0 ? UIImage(data: Data(base64Encoded: config.fillingImageStringArray[selectedTag] ?? "") ?? Data())! : selectedImage ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(width: 40, height: 40)
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker { uiImage in
                        withAnimation {
                            selectedImage = uiImage
                            if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                                // 因为初始化时设置了最大默认数，所以这里可以不用判断，但是以防特殊情况，加入兜底限制
                                if config.fillingImageStringArray.count <= (selectedTag - 1) {
                                    for item in 0...selectedTag {
                                        if config.fillingImageStringArray.count <= item {
                                            config.fillingImageStringArray.append("")
                                        }
                                    }
                                }
                                config.fillingImageStringArray[selectedTag] = imageData.base64EncodedString()
                                config.backgroundColor = config.backgroundColor
                                onSelectBlock?()
                            }
                        }
                    }
                }
                .frame(height: 40)
            }
        }
    }
    
}
