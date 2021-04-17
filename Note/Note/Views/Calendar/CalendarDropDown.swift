//
//  CalendarDropDown.swift
//  Note
//
//  Created by Hongyang Lin on 4/16/21.
//

import SwiftUI

struct CalendarDropDown: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var monthsList: [Date] = []
    @State var selectedDay: Date = Date()
    init() {
        let modelData = ModelData()
        let firstNote = modelData.notes.first
        if firstNote != nil {
            let dateComponentsOfFirstNote: DateComponents = firstNote!.dateComponents
            let startDate: Date = Calendar(identifier: .gregorian).date(from: dateComponentsOfFirstNote)!
            let interval = DateInterval(start: startDate, end: Date())
            self.monthsList = Calendar.current.generateDates(interval: interval, components: DateComponents(day:1))
        } else {
            let interval = Calendar.current.dateInterval(of: .year, for: Date())!
            self.monthsList = Calendar.current.generateDates(interval: interval, components: DateComponents(day:1))
        }
    }
    
    /*
     Return an array of dates of all days in the month
     */
    func getDays(dayInMonth: Date) -> [Date] {
        var days: [Date] = []
        if let monthInterval = Calendar.current.dateInterval(of: .month, for: dayInMonth) {
            let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start)
            let monthLastWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.end-1)
            if monthFirstWeek != nil && monthLastWeek != nil {
                let weekInterval = DateInterval(start: (monthFirstWeek!).start, end: (monthLastWeek!).end)
                for i in Calendar.current.generateDates(interval: weekInterval, components: DateComponents(hour:0)) {
                    days.append(i)
                }
            }
        }
        return days
    }
    
    /*
     Return an array of dates which ...
     */
    func datesOfNotes() -> [DateComponents]{
        var dates: [DateComponents] = []
        for note in modelData.notes {
            dates.append(DateComponents(year: note.dateComponents.year,
                                        month: note.dateComponents.month,
                                        day: note.dateComponents.day))
        }
        return dates
    }
    
    func hasNote(date: Date) -> Bool {
        datesOfNotes().contains(Calendar.current.dateComponents([.year,.month,.day], from: date))
    }
    
    func dayForegroundColor(date: Date) -> Color {
        if hasNote(date: date) {
            return self.selectedDay == date ? Color.white : Color.black
        }
        return Color.gray
    }
    
    func dayBackgroundColor(date: Date) -> Color {
        let dateOfToday = Calendar.current.dateComponents([.year,.month,.day], from: Date())
        let dateOfTheDay = Calendar.current.dateComponents([.year,.month,.day], from: date)
        if dateOfTheDay == dateOfToday {
            return modelData.colorThemes[modelData.themeID]["Primary"]!
        }
        return DateFormatter.monthDayYear.string(from: self.selectedDay) == DateFormatter.monthDayYear.string(from: date) ? Color.green : Color.white
    }
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollViewReader { item in
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                            ForEach(monthsList, id: \.self) { month in
                                Section (header: Text(DateFormatter.monthAndYearF.string(from: month)).foregroundColor(.gray)) {
                                    ForEach(getDays(dayInMonth: month), id: \.self) { day in
                                        if Calendar.current.isDate(day, equalTo: month, toGranularity: .month) {
                                            NavigationLink(
                                                destination: NoteViewInDropDown(date: day).edgesIgnoringSafeArea(.bottom),
                                                label: {
                                                    Text(DateFormatter.dayFormatter.string(from: day))
                                                }
                                            )
                                            .simultaneousGesture(TapGesture().onEnded {
                                                self.selectedDay = day
                                            })
                                            .frame(width: 25, height: 25)
                                            .padding(10)
                                            .background(dayBackgroundColor(date: day))
                                            .cornerRadius(30)
                                            .foregroundColor(dayForegroundColor(date: day))
                                            .disabled( hasNote(date: day) ? false : true)
                                            .id(
                                                Calendar.current.dateComponents([.year,.month,.day], from: day)
                                            ).navigationBarBackButtonHidden(true)
                                        } else {
                                            Text(DateFormatter.dayFormatter.string(from: day)).hidden()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                    .navigationBarHidden(true)
                    .onAppear {
                        item.scrollTo(Calendar.current.dateComponents([.year,.month,.day], from: Date()), anchor: .bottom)
                    }
                    .background(modelData.colorThemes[modelData.themeID]["Primary"])
                }
            }
        }
    }
}

struct CalendarDropDown_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDropDown().environmentObject(ModelData())
    }
}
