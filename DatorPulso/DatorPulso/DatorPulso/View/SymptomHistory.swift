//
//  SymptomHistory.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
struct SymptomHistoryView: View {
    @EnvironmentObject var store: UIPreviewStore
    var onProfileTap: () -> Void
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                DashboardTopBar(title: "Symptom History", onProfileTap:
                                    onProfileTap)
                if store.history.isEmpty {
                    emptyState
                } else {
                    VStack(spacing: 14) {
                        ForEach(store.history) { entry in
                            recordCard(entry)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Spacer(minLength: 40)
            }
        }
        .background(Color.pulsoBackground.ignoresSafeArea())
    }
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 40))
                .foregroundColor(.pulsoSecondaryText)
            Text("No symptom records yet")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            Text("Log your symptoms from the Home tab to start building your history.")
                .font(.footnote)
                .foregroundColor(.pulsoSecondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.top, 60)
    }
    @ViewBuilder
    private func recordCard(_ entry: SymptomEntry) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(entry.formattedDate)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Text(entry.conditionName)
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(entry.tagColor)
                    .cornerRadius(8)
            }
            Text("Symptoms: \(entry.symptoms.joined(separator: ", "))")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.85))
            Text("Temperature: \(entry.temperature)")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.85))
            HStack(spacing: 6) {
                Image(systemName: "bandage")
                    .font(.caption)
                    .foregroundColor(.pulsoSecondaryText)
                Text("Remedy: \(entry.remedy)")
                    .font(.footnote)
                    .foregroundColor(.pulsoSecondaryText)
            }
        }
        .padding(16)
        .background(Color.pulsoCard)
        .cornerRadius(14)
    }
}

#Preview{
    ProfileView(onLogout: {})
        .environmentObject(UIPreviewStore())
}
