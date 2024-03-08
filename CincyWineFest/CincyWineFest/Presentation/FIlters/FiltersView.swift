//
//  FiltersView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct FiltersView: View {
    @Environment (\.dismiss) private var dismiss
    
    @Binding var filters: Filters
    
    var body: some View {
        NavigationStack {
            PageBackground {
                VStack {
                    renderMedalOptions()
                    AppDivider()
                    renderBoothTypeOptions()
                    Spacer()
                }
            }
            .appNavBar(title: "Filters", trailing: renderCloseButton())
            .foregroundStyle(.textPrimary)
            .padding()
        }
    }
    
    @ViewBuilder private func renderMedalOptions() -> some View {
        Text("Medals Options")
            .font(.appTitle)
            .foregroundStyle(Color.textSecondary)
        renderOption(text: "Show Gold Medals", isOn: $filters.showGoldMedals, color: Color.medalGold)
        renderOption(text: "Show Silver Medals", isOn: $filters.showSilverMedals, color: Color.medalSilver)
        renderOption(text: "Show Bronze Medals", isOn: $filters.showBronzeMedals, color: Color.medalBronze)
    }
    
    @ViewBuilder private func renderBoothTypeOptions() -> some View {
        Text("Booth Types")
            .font(.appTitle)
            .foregroundStyle(Color.textSecondary)
        renderOption(text: "Wine", isOn: $filters.showWineBooths, color: Color.app)
        renderOption(text: "Sponsor", isOn: $filters.showSponsorBooths, color: Color.sponsor)
        renderOption(text: "Food", isOn: $filters.showFoodBooths, color: Color.food)
        renderOption(text: "Exhibit", isOn: $filters.showExhibitBooths, color: Color.exhibit)
        renderOption(text: "Water/Non-Alcoholic", isOn: $filters.showWaterNonAlcoholicBooths, color: Color.waterNonAlcoholic)
    }
    
    @ViewBuilder private func renderOption(text: String, isOn: Binding<Bool>, color: Color) -> some View {
        HStack {
            Text(text)
                .font(.appBoldText)
            Spacer()
            Toggle("", isOn: isOn)
                .tint(color)
        }
    }
    
    @ViewBuilder private func renderCloseButton() -> some View {
        HStack {
            Image(systemName: "xmark")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: 22)
        }
        .frame(width: 35, height: 35)
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    FiltersView(filters: .constant(Filters()))
}