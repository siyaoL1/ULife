//
//  DiaryDetail.swift
//  Note
//
//  Created by Siyao Li on 4/16/21.
//

import SwiftUI

struct DiaryDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var diaryIndex: Int {
        modelData.diaries.firstIndex(where: { $0.id == modelData.currDiary })!
    }
    
    var body: some View {
        let date = DateFormatter.monthDayYearWithComma.string(from: modelData.diaries[diaryIndex].rawDate)
        let weekday = DateFormatter.weekday.string(from: modelData.diaries[diaryIndex].rawDate)
        let time = DateFormatter.time.string(from: modelData.diaries[diaryIndex].rawDate)

        ZStack {
            ScrollView {
                ZStack(alignment: .topTrailing) {
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
                                modelData.diaries[diaryIndex].hasDeleted.toggle()
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Delete")
                                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(date)
                                .font(.system(size: 28, design: .rounded))
                                .padding(.bottom, 5)
                            Text(weekday)
                                .font(.system(size: 20, design: .rounded))
                            Text(time)
                                .font(.system(size: 20, design: .rounded))
                        }.padding(.top, 15)
                        .padding(.bottom, 30)
                        
                        HStack {
                            TextField("I feel like ...", text: $modelData.diaries[diaryIndex].title)
                                .font(.title)
                            Spacer()
                        }
                        
                        Divider()

                        TextEditor(text: $modelData.diaries[diaryIndex].content)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .frame(height: 500, alignment: .center)
                    }.zIndex(0.0)
                    EmotionPicker()
                        .offset(x: 9.0, y: 25.0)
                        .zIndex(1.0)
                        
                }
            }
            .padding()
            .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            .background(modelData.colorThemes[modelData.themeID]["Primary"])
            .ignoresSafeArea(edges: .bottom)

        }
    }

}

extension DateFormatter {
//    static var monthFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM"
//        return formatter
//    }
//
//    static var dayFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "d"
//        return formatter
//    }

    static var monthDayYearWithComma: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }
    
    static var weekday: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }
    
    static var time: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:m a"
        return formatter
    }
//
//    static var monthAndYearF: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }
}


struct DiaryDetail_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDetail()
    }
}
