//
//  NeoButton.swift
//  NeoButton
//
//  Created by Igor Kotkovets on 2/20/20.
//

import UIKit
import os.log

@IBDesignable public class NeoButton: UIButton {
    let darkShadowLayer = CALayer()
    let lightShadowLayer = CALayer()
    let shape = CALayer()
    let outLog = OSLog(subsystem: "NeoButton", category: String(describing: self))

    var radiusInternal: CGFloat = 3
    @IBInspectable
    public dynamic var radius: CGFloat {
        set {
            radiusInternal = newValue.clamped(to: 0...min(bounds.size.width, bounds.size.height)/2)
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setRadius: %{public}f", radiusInternal)
            }
            applyState()
        }
        get { return radiusInternal }
    }

    var distanceNormal: CGFloat = 3.0
    let distanceHighlighted: CGFloat = 1
    @IBInspectable
    public dynamic var distance: CGFloat {
        set {
            distanceNormal = newValue.clamped(to: 3...50)
            blurNormal = 2*newValue
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setDistance: %{public}f setBlur: %{public}f", distanceNormal, blurNormal)
            }
            applyState()
        }
        get { return distanceNormal }
    }

    var blurNormal: CGFloat = 3.4
    let blurHighlighted: CGFloat = 2
    @IBInspectable
    public dynamic var blur: CGFloat {
        set {
            blurNormal = newValue
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setBlur: %{public}f", blurNormal)
            }
            applyState()
        }
        get { return blurNormal }
    }

    var intensityNormal: Float = 0.6
    let intensityHighlighted: Float = 0.3

    @IBInspectable
    public dynamic var intensity: Float {
        set {
            intensityNormal = newValue.clamped(to: 0.01...1)
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setIntensity: %{public}f", intensityNormal)
            }
            applyState()
        }
        get { return intensityNormal }
    }

    var shapeColor = UIColor.gray
    @IBInspectable
    public dynamic var color: UIColor {
        set {
            shapeColor = newValue
            shape.backgroundColor = newValue.cgColor
            lightShadowLayer.shadowColor = newValue.lighter().cgColor
            darkShadowLayer.shadowColor = newValue.darker().cgColor
        }
        get { return shapeColor }
    }


    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)

        shape.masksToBounds = true
        layer.addSublayer(shape)
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        applyNormalStateDesign()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        applyNormalStateDesign()
    }

    func applyState() {
        if isSelected {
            applyHighlightedStateDesign()
        }
        else if isHighlighted {
            applyHighlightedStateDesign()
        }
        else {
            applyNormalStateDesign()
        }
    }

    func applyNormalStateDesign() {
        darkShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radiusInternal).cgPath
        darkShadowLayer.shadowColor = shapeColor.darker().cgColor
        darkShadowLayer.shadowOpacity = intensityNormal
        darkShadowLayer.shadowRadius = blurNormal
        darkShadowLayer.shadowOffset = CGSize(width: distanceNormal, height: distanceNormal)
        darkShadowLayer.bounds = bounds
        darkShadowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)

        lightShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radiusInternal).cgPath
        lightShadowLayer.shadowColor = shapeColor.lighter().cgColor
        lightShadowLayer.shadowOpacity = intensityNormal
        lightShadowLayer.shadowRadius = blurNormal
        lightShadowLayer.shadowOffset = CGSize(width: -distanceNormal, height: -distanceNormal)
        lightShadowLayer.bounds = bounds
        lightShadowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)

        shape.backgroundColor = shapeColor.cgColor
        shape.cornerRadius = radiusInternal
        shape.bounds = bounds
        shape.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }

    func applyHighlightedStateDesign() {
        darkShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radiusInternal).cgPath
        darkShadowLayer.shadowColor = shapeColor.darker().cgColor
        darkShadowLayer.shadowOpacity = intensityHighlighted
        darkShadowLayer.shadowRadius = blurHighlighted
        darkShadowLayer.shadowOffset = CGSize(width: distanceHighlighted, height: distanceHighlighted)
        darkShadowLayer.bounds = bounds
        darkShadowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)

        lightShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radiusInternal).cgPath
        lightShadowLayer.shadowColor = shapeColor.lighter().cgColor
        lightShadowLayer.shadowOpacity = intensityHighlighted
        lightShadowLayer.shadowRadius = blurHighlighted
        lightShadowLayer.shadowOffset = CGSize(width: -distanceHighlighted, height: -distanceHighlighted)
        lightShadowLayer.bounds = bounds
        lightShadowLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)

        shape.backgroundColor = shapeColor.cgColor
        shape.cornerRadius = radiusInternal
        shape.bounds = bounds
        shape.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }


    public override var isSelected: Bool {
        set {
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setSelected: %{public}s", newValue ? "true":"false")
            }
            super.isSelected = newValue
            applyState()
        }
        get {
            return super.isSelected
        }
    }

    public override var isHighlighted: Bool {
        set {
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setHighlighted: %{public}s", newValue ? "true":"false")
            }
            super.isHighlighted = newValue
            applyState()
        }
        get {
            return super.isHighlighted
        }
    }

    public override var isEnabled: Bool {
        set {
            if #available(iOS 12.0, *) {
                os_log(.info, log: outLog, "setEnabled:: %{public}s", newValue ? "true":"false")
            }
            super.isEnabled = newValue
            applyState()
        }
        get {
            return super.isEnabled
        }
    }

}

public extension UIColor {
    func lighter(by value: CGFloat = -0.5) -> UIColor {
//        return adjustSaturation(by: value)
        return adjustBrightness(by: value)
    }

    func darker(by value: CGFloat = 0.5) -> UIColor {
        return adjustBrightness(by: value)
    }

    func adjustSaturation(by value: CGFloat) -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            s = max(0,s-value)
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }

        return self
    }

    func adjustBrightness(by value: CGFloat) -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            b = (b-value).clamped(to: 0...1)
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }

        return self
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        if self > range.upperBound {
            return range.upperBound
        } else if self < range.lowerBound {
            return range.lowerBound
        } else {
            return self
        }
    }
}
