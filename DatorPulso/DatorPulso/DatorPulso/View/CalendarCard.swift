//
//  CalendarCard.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct CalendarCardView: View {
    @EnvironmentObject var store: UIPreviewStore
    var onSelectDay: (Date) -> Void
    @State private var displayedMonth: Date = Date()
    private let calendar = Calendar.current
    private let weekdaySymbols = ["S", "M", "T", "W", "T", "F", "S"]
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(monthTitle)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName:"chevron.left").foregroundColor(.pulsoSecondaryText)
                }
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right").foregroundColor(.pulsoSecondaryText)
                }
            }
            HStack {
                ForEach(weekdaySymbols.indices, id: \.self) { index in Text(weekdaySymbols[index])
                        .font(.caption)
                        .foregroundColor(.pulsoSecondaryText)
                        .frame(maxWidth: .infinity)
                }
            }
            let days = daysInMonthGrid()
            let columns = Array(repeating: GridItem(.flexible()), count:7)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(days.indices, id: \.self) { index in
                    if let date = days[index] {dayCell(for: date)
                            .onTapGesture { onSelectDay(date) }
                    } else {
                        Color.clear.frame(height: 34)
                    }
                }
            }
        }
        .padding(18)
        .background(Color.pulsoCard)
        .cornerRadius(18)
    }
    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: displayedMonth)
    }
    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value,to: displayedMonth) {
            displayedMonth = newMonth
        }
    }
    private func daysInMonthGrid() -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for:displayedMonth),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return []
        }
        let leadingBlanks = firstWeekday - 1
        var days: [Date?] = Array(repeating: nil, count: leadingBlanks)
        var current = monthInterval.start
        while current < monthInterval.end {
            days.append(current)
            guard let next = calendar.date(byAdding: .day, value: 1, to:current) else { break }
            current = next
        }
        return days
    }
    private func hasRecord(on date: Date) -> Bool {
        store.history.contains { calendar.isDate($0.date, inSameDayAs:date) }
    }
    @ViewBuilder
    private func dayCell(for date: Date) -> some View {
        let isToday = calendar.isDateInToday(date)
        let dayNumber = calendar.component(.day, from: date)
        VStack(spacing: 4) {
            Text("\(dayNumber)")
                .font(.system(size: 15, weight: isToday ? .bold :
                        .regular))
                .foregroundColor(isToday ? .black : .white)
                .frame(width: 34, height: 34)
                .background(isToday ? store.selectedTheme.accentColor :Color.clear)
                .clipShape(Circle())
            Circle()
                .fill(hasRecord(on: date) ?store.selectedTheme.accentColor : Color.clear)
                .frame(width: 5, height: 5)
        }
    }
}

#Preview{
    CalendarCardView(onSelectDay: { _ in})
            .environmentObject(UIPreviewStore())
            .padding()
            .background(Color.pulsoBackground)
}


