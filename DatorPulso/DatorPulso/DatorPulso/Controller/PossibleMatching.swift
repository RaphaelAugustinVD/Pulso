//
//  PossibleMatching.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
struct PossibleMatchView: View {
    @EnvironmentObject var store: UIPreviewStore
    @Environment(\.dismiss) private var dismiss
    let date: Date
    let symptoms: [String]
    let temperature: String
    var onFinish: () -> Void
    @State private var selectedMatchID: UUID? = sampleMatches.first?.id
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Possible Match")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                VStack(spacing: 14) {
                    ForEach(sampleMatches) { match in
                        matchCard(match)
                    }
                }
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.pulsoSecondaryText)
                    Text("This is not a substitute for professional medical advice. If symptoms worsen, consult a doctor immediately.")
                        .font(.footnote)
                        .foregroundColor(.pulsoSecondaryText)
                }
                .padding(14)
                .background(Color.pulsoCard)
                .cornerRadius(12)
                PrimaryButton(
                    title: "Acknowledge & Save",
                    isEnabled: selectedMatchID != nil,
                    accentColor: store.selectedTheme.accentColor,
                    action: acknowledgeAndSave
                )
                .padding(.top, 4)
            }
            .padding(20)
        }
        .background(Color.pulsoBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName:
                            "chevron.left").foregroundColor(.white)
                }
            }
        }
    }
    @ViewBuilder
    private func matchCard(_ match: SicknessMatch) -> some View {
        let isSelected = selectedMatchID == match.id
        Button(action: { selectedMatchID = match.id }) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    Image(systemName: match.icon)
                        .foregroundColor(isSelected ? .black :
                                            store.selectedTheme.accentColor)
                        .frame(width: 32, height: 32)
                        .background(isSelected ?
                                    store.selectedTheme.accentColor : Color.pulsoBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(match.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        Text(match.matchLabel)
                            .font(.footnote)
                            .foregroundColor(.pulsoSecondaryText)
                    }
                    Spacer()
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(store.selectedTheme.accentColor)
                    }
                }
                if isSelected {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("SUGGESTED REMEDIES")
                            .font(.caption2)
                            .foregroundColor(.pulsoSecondaryText)
                        Text(match.remedy)
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.85))
                        Text("SELF-CARE & PRECAUTIONS")
                            .font(.caption2)
                            .foregroundColor(.pulsoSecondaryText)
                            .padding(.top, 4)
                        Text(match.selfCare)
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.85))
                    }
                }
            }
            .padding(16)
            .background(Color.pulsoCard)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? store.selectedTheme.accentColor :
                                Color.pulsoBorder, lineWidth: isSelected ? 2 : 1)
            )
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
    private func acknowledgeAndSave() {
        guard let match = sampleMatches.first(where: { $0.id ==
            selectedMatchID }) else { return }
        let entry = SymptomEntry(
            date: date,
            symptoms: symptoms,
            temperature: "\(temperature)°F",
            conditionName: match.name,
            remedy: match.remedy,
            tagColor: store.selectedTheme.accentColor
        )
        store.history.insert(entry, at: 0)
        onFinish()
    }
}

#Preview{
    PossibleMatchView(
        date: Date(),
        symptoms: ["Sore Throat", "Cough"],
        temperature: "99.1",
        onFinish: {}
    )
    .environmentObject(UIPreviewStore())
}
