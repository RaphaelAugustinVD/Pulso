//
//  ProfileView.swift
//  DatorPulso
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
import PhotosUI
struct ProfileView: View {
    @EnvironmentObject var store: UIPreviewStore
    @Environment(\.dismiss) private var dismiss
    var onLogout: () -> Void
    @State private var pickerItem: PhotosPickerItem?
    @State private var showResetConfirmation = false
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 4) {
                    Text("User Profile")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    Text(todayString)
                        .font(.footnote)
                        .foregroundColor(.pulsoSecondaryText)
                }
                .padding(.top, 12)
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    ZStack {
                        Circle()
                            .fill(Color.pulsoCard)
                            .frame(width: 140, height: 140)
                        if let image = store.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.pulsoSecondaryText)
                        }
                        Circle()
                            .stroke(store.selectedTheme.accentColor,
                                    lineWidth: 2)
                            .frame(width: 140, height: 140)
                    }
                }
                .onChange(of: pickerItem) {_, newItem in Task { await loadImage(from: newItem) }
                }
                VStack(spacing: 6) {
                    Text(store.fullName.isEmpty ? "Guest" :
                            store.fullName)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    Text("Age: \(store.age)")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                    Text("Sex: \(store.sex)")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Color Theme:")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.pulsoSecondaryText)
                    HStack(spacing: 16) {
                        ForEach(AppTheme.allCases) { theme in
                            themeSwatch(theme)
                        }
                    }
                }
                .padding(16)
                .background(Color.pulsoCard)
                .cornerRadius(16)
                PrimaryButton(title: "Reset User Data", accentColor:
                                store.selectedTheme.accentColor) {
                    showResetConfirmation = true
                }
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 24)
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
        .navigationBarBackButtonHidden(true)
        .alert("Are you sure you want to reset your data?", isPresented:
                $showResetConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                store.history.removeAll()
            }
        } message: {
            Text("This will erase your calendar history and symptom records. This action cannot be undone.")
        }
    }
    private var todayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "'Today' - MMMM d, yyyy"
        return formatter.string(from: Date())
    }
    private func themeSwatch(_ theme: AppTheme) -> some View {
        Button(action: { store.selectedTheme = theme }) {
            Circle()
                .fill(theme.accentColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Circle().stroke(Color.white, lineWidth:
                                        store.selectedTheme == theme ? 3 : 0)
                )
                .overlay(
                    Group {
                        if store.selectedTheme == theme {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .bold))
                        }
                    }
                )
        }
    }
    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        if let data = try? await item.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            store.profileImage = uiImage
        }
    }
}
