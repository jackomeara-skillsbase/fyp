//
//  ManagerStatCardView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/03/2024.
//

import SwiftUI

struct ManagerStatCardView: View {
    var title: String
    var icon: String
    var value: Int
    var lastWeekValue: Int
    var colour: Color
    var percentChange: Int
    
    init(title: String, icon: String, value: Int, lastWeekValue: Int) {
        self.title = title
        self.icon = icon
        self.value = value
        self.lastWeekValue = lastWeekValue
//        let details = getChangeDetails(value: value, lastWeekValue: lastWeekValue)
        self.colour = Color.green
        self.percentChange = 16
    }
    
//    func getChangeDetails(value: Int, lastWeekValue: Int) -> (Color, Int) {
//        var colour: Color
//        var percentChange: Int
//        if value > lastWeekValue {
//            colour = Color.green
//        } else if value < lastWeekValue {
//            colour = Color.red
//        } else {
//            colour = Color.gray
//        }
//        percentChange = (value - lastWeekValue) / value
//        return (colour, percentChange)
//    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color.theme.secondaryText)
                Text("\(value)")
                    .font(.title)
                HStack {
                    Image(systemName: "chevron.up")
                        .foregroundStyle(self.colour)
                    Text("\(17)% since last week")
                        .foregroundStyle(self.colour)
                }
            }
            Spacer()
            Image(systemName: icon)
                .resizable()
                .scaledToFill()
                .frame(width:45, height: 50)
        }
        .padding()
    }
}

#Preview {
    ManagerStatCardView(title: "Players", icon: "person", value: 17, lastWeekValue: 12)
}
