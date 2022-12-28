import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let rgb = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: rgb.R, green: rgb.G, blue: rgb.B, alpha: 1)
    }
}
