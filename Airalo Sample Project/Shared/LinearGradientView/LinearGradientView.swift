//
//  LinearGradientView.swift
//  Airalo Sample Project
//
//  Created by MyPlace on 28/12/2022.
//

import UIKit

class LinearGradientView: UIView {
    var startColor: UIColor?
    var endColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [(startColor ?? .clear).cgColor, (endColor ?? .clear).cgColor]
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        context.drawLinearGradient(gradient,
                                   start: CGPoint.zero,
                                   end: CGPoint(x: rect.width, y: 0),
                                   options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
    }
}
