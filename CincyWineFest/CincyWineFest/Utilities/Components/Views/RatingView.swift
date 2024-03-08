//
//  RatingView.swift
//  CincyWineFest
//
//  Created by Eric Ziegler on 3/8/24.
//

import SwiftUI

struct RatingView: View {
    
    @State var rating: Int = 0
    var onRatingUpdated: ((_ rating: Int) -> Void)?
    private let stars = [0, 1, 2, 3, 4]
    
    var body: some View {
        HStack {
            ForEach(stars, id: \.self) { star in
                Image(systemName: rating <= star ? "star" : "star.fill")
                    .resizeAndFit()
                    .frame(width: 35, height: 35)
                    .onTapGesture(perform: {
                        rating = star + 1
                        onRatingUpdated?(rating)
                    })
                    .foregroundStyle(rating <= star ? Color.textSecondary : Color.yellow)
            }
        }
    }
}

#Preview {
    RatingView()
}
