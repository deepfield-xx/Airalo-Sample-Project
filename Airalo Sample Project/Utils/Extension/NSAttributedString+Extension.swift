import UIKit

extension String {
    func range(of str: String) -> NSRange {
        return (self as NSString).range(of: str)
    }
}

extension NSMutableAttributedString {
    func lineHeight(_ height: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = height
        paragraphStyle.maximumLineHeight = height
        
        addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: string.count))
        
        return self
    }
    
    func font(_ font: UIFont, for range: NSRange? = nil) -> Self {
        if let range = range {
            addAttributes([.font: font], range: range)
        } else {
            addAttributes([.font: font], range: string.range(of: string))
        }
        
        return self
    }
    
    func font(_ font: UIFont, for str: String? = nil) -> Self {
        if let str = str {
            addAttributes([.font: font], range: string.range(of: str))
        }
        
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        addAttributes([.font: font], range: string.range(of: string))
        
        return self
    }
    
    func kern(_ kern: CGFloat) -> Self {
        let range = string.range(of: string)
        addAttributes([.kern: kern], range: range)
        
        return self
    }
    
    func color(_ color: UIColor) -> Self {
        let range = string.range(of: string)
        addAttributes([.foregroundColor: color], range: range)
        
        return self
    }
}
