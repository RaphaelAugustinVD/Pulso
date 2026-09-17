//
//  PreviewData.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
import Combine

struct SymptomEntry: Identifiable {
    let id = UUID()
    let date: Date
    let symptoms: [String]
    let temperature: String
    let conditionName: String
    let remedy: String
    let tagColor: Color
    var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "MMMM d, yyyy"
        return f.string(from: date)
    }
}

struct SicknessMatch: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let matchLabel: String
    let remedy: String
    let selfCare: String
}
let sampleSymptomOptions = [
"Sore Throat", "Headache", "Cough", "Fatigue",
"Chills", "Nausea", "Runny Nose", "Body Aches"
]
let sampleMatches: [SicknessMatch] = [
    SicknessMatch(
        name: "Common Cold",
        icon: "cross.case.fill",
        matchLabel: "High match based on 3 symptoms",
        remedy: "OTC antihistamines, saline nasal spray, cough drops.",
        selfCare: "Rest, stay hydrated with warm water, isolate to protect others."),
    SicknessMatch(
        name: "Mild Flu",
        icon: "thermometer.medium",
        matchLabel: "Moderate match! Monitor fever closely",
        remedy: "Acetaminophen or ibuprofen, fluids, plenty of rest.",
        selfCare: "Monitor your temperature closely and rest as much as possible."),
    SicknessMatch(
        name: "Allergies",
        icon: "leaf.fill",
        matchLabel: "Low match! Correlates with local pollen index",
        remedy: "Antihistamines, saline nasal spray.",
        selfCare: "Avoid known triggers and keep windows closed when pollen is high.")
]
final class UIPreviewStore: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var age: String = "00"
    @Published var sex: String = "Male"
    @Published var profileImage: UIImage?
    @Published var selectedTheme: AppTheme = .green
    @Published var history: [SymptomEntry] = [SymptomEntry(
        date: Calendar.current.date(byAdding: .day, value: -3, to:Date()) ?? Date(),
        symptoms: ["Sore Throat", "Fatigue"],
        temperature: "99.1°F",
        conditionName: "Common Cold",
        remedy: "Cough Drops, Warm tea",tagColor: .pulsoGreenDefault),
                                              SymptomEntry(
                                                date: Calendar.current.date(byAdding: .day, value: -6, to:Date()) ?? Date(),
                                                symptoms: ["Runny Nose", "Cough"],
                                                temperature: "98.6°F",
                                                conditionName: "Allergies",
                                                remedy: "Cetirizine 10mg",
                                                tagColor: .yellow)
    ]
}
