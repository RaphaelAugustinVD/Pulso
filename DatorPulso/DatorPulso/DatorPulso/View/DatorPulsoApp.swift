//
//  DatorPulsoApp.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/3/26.
//

import SwiftUI
@main
struct PulsoApp: App {
    @StateObject private var store = UIPreviewStore()
    init() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(red: 0.04, green: 0.05,
                                                blue: 0.07, alpha: 1)
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(red: 0.04, green: 0.05,
                                                blue: 0.07, alpha: 1)
        navAppearance.titleTextAttributes = [.foregroundColor:
                                                UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor:
                                                    UIColor.white]
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
        }
    }
}

    

