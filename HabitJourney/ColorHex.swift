// Responsável pelo uso do HEX e extensão do Colors como um todo não somente o UIColors

import SwiftUI

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        let alpha = hexString.count == 8 ? Double((rgbValue & 0xFF000000) >> 24) / 255.0 : 1.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
