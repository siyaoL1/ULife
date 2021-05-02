//
//  NoteNew.swift
//  Note
//
//  Created by Siyao Li on 3/19/21.
//

import SwiftUI


struct NoteDetail : View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode

    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == modelData.currNote })!
    }

    func actionSheet() {
        guard let data = URL(string: "https://www.google.com") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(
            av, animated: true, completion: nil
        )
    }

    var body: some View {
        let time = "\(modelData.notes[noteIndex].dateComponents.year!)/\(modelData.notes[noteIndex].dateComponents.month!)/\(modelData.notes[noteIndex].dateComponents.day!)"
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        }

                        Spacer()

                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(.yellow)
                        }
                    }

                    HStack {
                        TextField("I feel like ...", text: $modelData.notes[noteIndex].title)
                            .font(.title)
                        Spacer()
                        Button(
                            action: {
                                let image = body.snapshot()
                                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            }
                        ){
                            Image(systemName: "square.and.arrow.up")
                        }.padding()
                        FavoriteButton(isSet: $modelData.notes[noteIndex].isFavorite)
                    }
                    Text(time)
                        .font(.subheadline)
                    Divider()

                    TextEditor(text: $modelData.notes[noteIndex].content)
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
//                MultilineTextView(text: $input)
            }
            .padding()
            .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            .background(modelData.colorThemes[modelData.themeID]["Primary"])

        }
    }
}


extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.8)

        //print(type(of: controller.view.intrinsicContentSize))
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct NoteDetail_Previews: PreviewProvider {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    static var modelData = ModelData()

    static var previews: some View {
        VStack {
            Button(action: {

            }) {
                Text("AddNote")
                    .foregroundColor(.yellow)
            }
//            NoteDetail(noteID: modelData.notes[0].id)
//                .environmentObject(modelData)
        }
    }
}
