import SwiftUI

struct SymptomLoggingView: View {
    @EnvironmentObject var store: UIPreviewStore
    @Environment(\.dismiss) private var dismiss

    let date: Date
    @Binding var selectedSymptoms: Set<String>
    @Binding var temperature: String
    var onSubmit: () -> Void

    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Symptom Logging")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text(formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.pulsoSecondaryText)
                }

                Text("SELECT YOUR SYMPTOMS")
                    .font(.caption)
                    .foregroundColor(.pulsoSecondaryText)

                VStack(spacing: 12) {
                    ForEach(sampleSymptomOptions, id: \.self) { symptom in
                        symptomRow(symptom)
                    }
                }

                Text("BODY TEMPERATURE")
                    .font(.caption)
                    .foregroundColor(.pulsoSecondaryText)
                    .padding(.top, 8)

                temperatureField

                if let errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                }

                PrimaryButton(
                    title: "Submit Symptoms",
                    accentColor: store.selectedTheme.accentColor,
                    action: submit
                )
                .padding(.top, 8)
            }
            .padding(20)
        }
        .background(Color.pulsoBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }

    private var temperatureField: some View {
        HStack {
            TextField(
                "",
                text: $temperature,
                prompt: Text("e.g. 98.6").foregroundColor(.pulsoSecondaryText)
            )
            .keyboardType(.decimalPad)
            .foregroundColor(.white)

            Text("F")
                .foregroundColor(.pulsoSecondaryText)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.pulsoCard)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.pulsoBorder, lineWidth: 1)
        )
        .cornerRadius(12)
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "'Today' MMMM d, yyyy"
        return formatter.string(from: date)
    }

    @ViewBuilder
    private func symptomRow(_ symptom: String) -> some View {
        let isSelected = selectedSymptoms.contains(symptom)
        Button(action: { toggle(symptom) }) {
            HStack {
                Text(symptom)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? store.selectedTheme.accentColor : .pulsoSecondaryText)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.pulsoCard)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? store.selectedTheme.accentColor : Color.pulsoBorder, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }

    private func toggle(_ symptom: String) {
        if selectedSymptoms.contains(symptom) {
            selectedSymptoms.remove(symptom)
        } else {
            selectedSymptoms.insert(symptom)
        }
    }

    private func submit() {
        guard !selectedSymptoms.isEmpty else {
            errorMessage = "Please select at least one symptom."
            return
        }
        guard let tempValue = Double(temperature), tempValue >= 90, tempValue <= 110 else {
            errorMessage = "Please enter a valid body temperature (90-110F)."
            return
        }
        errorMessage = nil
        onSubmit()
    }
}

#Preview{
    SymptomLoggingView(
        date: Date(),
        selectedSymptoms: .constant(["Sore Throat"]),
        temperature: .constant("98.6"),
        onSubmit: {}
    )
    .environmentObject(UIPreviewStore())
}
