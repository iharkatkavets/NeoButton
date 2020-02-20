//
//  NeoButton.swift
//  NeoButton
//
//  Created by Igor Kotkovets on 2/20/20.
//

import UIKit

@IBDesignable public class NeoButton: UIButton {
    let shadow0 = CALayer()
    let shadow1 = CALayer()
    let shape = CALayer()

    var radiusInternal: CGFloat = 0
    @IBInspectable public var radius: CGFloat {
        set {
            radiusInternal = max(0, newValue)
            radiusInternal = min(radiusInternal, min(bounds.size.width, bounds.size.height)/2)
            update()
        }
        get { return radiusInternal }
    }

    var distanceInternal: CGFloat = 5
    @IBInspectable public var distance: CGFloat {
        set {
            distanceInternal = max(3, newValue)
            distanceInternal = min(distanceInternal, 50)

            blurInternal = 2*newValue

            update()
        }
        get { return distanceInternal }
    }

    var blurInternal: CGFloat = 3
    @IBInspectable public var blur: CGFloat {
        set {
            blurInternal = newValue
            update()
        }
        get { return blurInternal }
    }

    var intensityInternal: Float = 0.4
    @IBInspectable public var intensity: Float {
        set {
            intensityInternal = max(0.01, newValue)
            intensityInternal = min(intensityInternal, 0.6)
            update()
        }
        get { return intensityInternal }
    }


    @IBInspectable public var color: UIColor {
        set {
            shape.backgroundColor = newValue.cgColor
            update()
        }
        get { return UIColor(cgColor: shape.backgroundColor!) }
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
        layer.addSublayer(shadow0)
        layer.addSublayer(shadow1)

        shape.masksToBounds = true
        layer.addSublayer(shape)
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        update()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        update()
    }

    func update() {
        shadow0.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radiusInternal).cgPath
        shadow0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.44).cgColor
        shadow0.shadowOpacity = intensityInternal
        shadow0.shadowRadius = blurInternal
        shadow0.shadowOffset = CGSize(width: distanceInternal, height: distanceInternal)
        shadow0.bounds = bounds
        shadow0.position = CGPoint(x: bounds.midX, y: bounds.midY)

        shadow1.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radiusInternal).cgPath
        shadow1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shadow1.shadowOpacity = intensityInternal
        shadow1.shadowRadius = blurInternal
        shadow1.shadowOffset = CGSize(width: -distanceInternal, height: -distanceInternal)
        shadow1.bounds = bounds
        shadow1.position = CGPoint(x: bounds.midX, y: bounds.midY)

        shape.cornerRadius = radiusInternal
        shape.bounds = bounds
        shape.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }


}
