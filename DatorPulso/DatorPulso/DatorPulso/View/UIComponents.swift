import SwiftUI
// MARK: - Palette
extension Color {
static let pulsoBackground = Color(red: 0.04, green: 0.05, blue: 0.07)
static let pulsoCard = Color(red: 0.09, green: 0.11, blue: 0.14)
static let pulsoBorder = Color(red: 0.18, green: 0.20, blue: 0.24)
static let pulsoSecondaryText = Color(white: 0.6)
}

enum AppTheme: String, CaseIterable, Identifiable {
    case green, blue, red
    var id: String { rawValue }
    var accentColor: Color {
        switch self {
        case .green: return Color(red: 0.20, green: 0.85, blue: 0.45)
        case .blue: return Color(red: 0.30, green: 0.55, blue: 0.95)
        case .red: return Color(red: 0.95, green: 0.32, blue: 0.32)
        }
    }
}
struct DateBox: Identifiable {
    let id = UUID()
    let date: Date
}
struct PrimaryButton: View {
    let title: String
    var isEnabled: Bool = true
    var accentColor: Color = .pulsoGreenDefault
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(isEnabled ? accentColor :accentColor.opacity(0.4))
                .cornerRadius(14)
        }
        .disabled(!isEnabled)
    }
}
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.pulsoCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.pulsoBorder, lineWidth: 1)
                )
                .cornerRadius(14)
        }
    }
}
extension Color {
    
    static let pulsoGreenDefault = Color(red: 0.20, green: 0.85, blue:0.45)
}

struct PulsoTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        Group {
            if isSecure {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.pulsoSecondaryText))
            } else {
                TextField("", text: $text, prompt:Text(placeholder).foregroundColor(.pulsoSecondaryText))
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.pulsoCard)
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(Color.pulsoBorder, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}
struct FieldLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.pulsoSecondaryText)
    }
}

struct DashboardTopBar: View {
    let title: String
    var subtitle: String? = nil
    let onProfileTap: () -> Void
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {Text(title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.pulsoSecondaryText)
                }
            }
            Spacer()
            Button(action: onProfileTap) {
                Image(systemName: "person.fill")
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.pulsoCard)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}
