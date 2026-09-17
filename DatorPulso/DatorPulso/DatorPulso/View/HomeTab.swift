//
//  HomeTab.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
struct HomeTabView: View {
    @EnvironmentObject var store: UIPreviewStore
    var onSelectDay: (Date) -> Void
    var onProfileTap: () -> Void
    private var firstName: String {
        store.fullName.isEmpty ? "User" :
        (store.fullName.components(separatedBy: " ").first ?? "User")
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                DashboardTopBar(
                    title: "Welcome, \(firstName)",
                    subtitle: "How are you feeling today?",
                    onProfileTap: onProfileTap
                )
                CalendarCardView(onSelectDay: onSelectDay)
                    .padding(.horizontal, 20)
                Button(action: { onSelectDay(Date()) }) {
                    HStack(spacing: 14) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Log symptoms for today")
                                .font(.system(size: 16, weight:
                                        .semibold))
                                .foregroundColor(.black)
                            Text("Keep your personal record up to date")
                                .font(.footnote)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        Spacer()
                    }
                    .padding(16)
                    .background(store.selectedTheme.accentColor)
                    .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                Spacer(minLength: 40)
            }
        }
        .background(Color.pulsoBackground.ignoresSafeArea())
    }
}

#Preview{
    HomeTabView(onSelectDay: { _ in }, onProfileTap: {})
        .environmentObject(UIPreviewStore())
}
