//
//
//  Created by Youhan Dou on 3/26/21.
//

import SwiftUI
extension Calendar {
    func generateDates(interval: DateInterval, components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) {date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}

extension DateFormatter {
    static var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    static var monthDayYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter
    }

    static var monthAndYearF: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

struct CalendarView: View {
    @EnvironmentObject var modelData: ModelData
   
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
            return .orange
        }
        return DateFormatter.monthDayYear.string(from: self.selectedDay) == DateFormatter.monthDayYear.string(from: date) ? Color.green : Color.white
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                    Text("S")
                    Text("M")
                    Text("T")
                    Text("W")
                    Text("T")
                    Text("F")
                    Text("S")
                }.padding().foregroundColor(.gray)
                
                
                ScrollViewReader { item in
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                            ForEach(monthsList, id: \.self) { month in
                                Section (header: Text(DateFormatter.monthAndYearF.string(from: month)).foregroundColor(.gray)) {
                                    ForEach(getDays(dayInMonth: month), id: \.self) { day in
                                        if Calendar.current.isDate(day, equalTo: month, toGranularity: .month) {
                                            
                                            NavigationLink(
                                                destination: ToNoteView(date: day),
                                                label: {
                                                    Text(DateFormatter.dayFormatter.string(from: day))
                                                })
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
                                                )
                                            
                                        } else {
                                            Text(DateFormatter.dayFormatter.string(from: day)).hidden()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .navigationBarTitle("Calendar", displayMode: .inline)
                    .onAppear {
                        item.scrollTo(Calendar.current.dateComponents([.year,.month,.day], from: Date()), anchor: .bottom)
                    }
                }
            }
        }
    }
}



struct ToNoteView : View {
    @EnvironmentObject var modelData: ModelData
    
    let date: Date
    var NotesOfTheDate: [NoteType] {
        modelData.notes.filter { note in
            (
                Calendar.current.dateComponents([.year,.month,.day], from: date)
                    == DateComponents(year: note.dateComponents.year,
                                      month: note.dateComponents.month,
                                      day: note.dateComponents.day)
            )
        }
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ForEach(NotesOfTheDate) { note in
                    NavigationLink(destination: NoteDetail(note: note)) {
                        NoteRow(note: note)
                    }
                }
                Spacer()
            }
            .background(Color(red: 249/255, green: 247/255, blue: 236/255))
            .navigationBarTitle("Notes", displayMode: .inline)
            Spacer()
        }
//        .frame(height: UIScreen.main.bounds.height*0.89)
//        .clipShape(RoundedRectangle(cornerRadius: 44))
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(ModelData())
    }
}
