//
//  ProgressBar.swift
//  HabitJourney
//
//  Created by coltec on 11/06/24.
//

import SwiftUI

struct ProgressBar: View {
    
    var width: CGFloat = 200
    var height: CGFloat = 20
    var percent: CGFloat = 0
    
    var body: some View {
        
        let multiplier = width / 100
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: width, height: height)
                .foregroundColor(Color ("AppColor/MarginSecondary"))
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: percent * multiplier, height: height)
                .background{
                    (LinearGradient(gradient: Gradient(colors: [Color ("AppColor/MarginSecondary"), Color ("AppColor/TaskMain")]), startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                }
                .foregroundColor(.clear)
                
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider{
    static var previews: some View{
        ProgressBar()
    }
}
