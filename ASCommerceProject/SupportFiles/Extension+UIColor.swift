import UIKit

extension UIColor {

    convenience init(hex: String) {
        let hex: String = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner     = Scanner(string: hex as String)

        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    public var hexCode: String {
        guard let components = cgColor.components else {
            return "#"
        }

        if components.count == 2 {
            let white = lroundf(Float(components[0] * 255))

            return String(
                format: "#%02X%02X%02X", white, white, white
            )
        }

        let red = components[0]
        let green = components[1]
        let blue = components[2]

        return String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
    }
}
