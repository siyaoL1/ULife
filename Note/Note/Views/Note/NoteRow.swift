//
//  NoteRow.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteRow: View {
    @EnvironmentObject var modelData: ModelData
    let width : CGFloat = 60
    @State var offset = CGSize.zero
    @State var scale : CGFloat = 0.5
    @State private var showNoteDetail = false
    
    func actionSheet() {
        // If you want to use an image
        let image : UIImage = modelData.image
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [image], applicationActivities: nil)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        //self.present(activityViewController, animated: true, completion: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(
            activityViewController, animated: true, completion: nil
        )
    }
    
    var note: NoteType
    
    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == note.id })!
    }
    
    var body: some View {
        let time = "\(note.dateComponents.year!)/\(note.dateComponents.month!)/\(note.dateComponents.day!)"
        
        GeometryReader { geo in
            HStack (spacing : 0){
                HStack {
                    HStack {
                        Text(note.title)
                            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                            .fontWeight(.light)
                            .lineLimit(10)
                        Spacer()
                        Text(time).font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/).fontWeight(.light).foregroundColor(Color.gray).lineLimit(10)
                        Button(
                            action: {
                                actionSheet()
                            }
                        ){
                            Image(systemName: "square.and.arrow.up")
                        }
                        FavoriteButton(isSet: $modelData.notes[noteIndex].isFavorite)
                    }
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                    .padding()
                }
                .frame(width : geo.size.width, alignment: .leading)
                .cornerRadius(10)
                
                ZStack {
                    Image(systemName: "trash")
                        .font(.system(size: 20))
                        .scaleEffect(scale)
                }
                .frame(width: width, height: geo.size.height)
                .background(modelData.colorThemes[modelData.themeID]["Secondary"].opacity(0.15))
                .onTapGesture {
                    modelData.deleteNote(id: note.id)
                }
            }
        }
        .frame(height: 70)
        .offset(self.offset)
        .animation(.spring())
        .contentShape(Rectangle())
        .gesture(DragGesture()
                    .onChanged { gesture in
                        self.offset.width = gesture.translation.width
                    }
                    .onEnded { _ in
                        if self.offset.width < -50 {
                            self.scale = 1
                            self.offset.width = -60
                        } else {
                            self.scale = 0.5
                            self.offset = .zero
                        }
                    }
        )
        .onTapGesture() {
            showNoteDetail = true
            modelData.currNote = note.id
        }
        .sheet(isPresented: $showNoteDetail, content: { NoteDetail()})
        
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        NoteRow(note: modelData.notes[1])
            .environmentObject(modelData)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
