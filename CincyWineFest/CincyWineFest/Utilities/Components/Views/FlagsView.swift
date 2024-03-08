//
//  FlagsView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct FlagsView: View {
    
    var countries: Countries
    var onCountryTapped: ((_ country: Country) -> Void)?
    
    var body: some View {
        HStack {
            ForEach(countries, id: \.self) { country in
                AnyView(country.flag)
                    .frame(height: 22)
                    .onTapGesture {
                        onCountryTapped?(country)
                    }
            }
        }
        .padding(.leading, 0)
    }
}

#Preview {
    FlagsView(countries: [Country.unitedstates, Country.argentina])
}
