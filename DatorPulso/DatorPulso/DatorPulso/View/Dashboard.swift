//
//  Dashboard.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
struct DashboardView: View {
    var onLogout: () -> Void
    @State private var selectedTab = 0
    @State private var sheetDate: DateBox?
    @State private var showProfile = false
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeTabView(
                    onSelectDay: { date in sheetDate = DateBox(date: date)
                    },
                    onProfileTap: { showProfile = true }
                )
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
                SymptomHistoryView(onProfileTap: { showProfile = true })
                    .tabItem { Label("History", systemImage:
                                        "calendar.badge.clock") }
                    .tag(1)
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(onLogout: onLogout)
            }
        }
        .sheet(item: $sheetDate) { box in
            SymptomFlowView(date: box.date) {
                sheetDate = nil
                selectedTab = 1
            }
        }
    }
}


#Preview{
    DashboardView(onLogout: {})
        .environmentObject(UIPreviewStore())
}
