//
//  CircularProgressBarView.swift
//  ZPMAPP
//
//  Created by Gabriela Sillis on 28/09/21.
//

import UIKit

class CircularProgressBarView: UIView {

    // MARK: - Private Properties

        private var circleLayer = CAShapeLayer()
        private var progressLayer = CAShapeLayer()
        private var startAnimation = CGFloat(-Double.pi / 2)
        private var endAnimation = CGFloat(3 * Double.pi / 2)

    // MARK: - Private functions

    private func circularPath() {
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 1.0, y: frame.size.height / 1.0), radius: 25, startAngle: startAnimation, endAngle: endAnimation, clockwise: true)

            // setup circleLayer

            circleLayer.path = circularPath.cgPath
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.lineCap = .round
            circleLayer.lineWidth = 7.0
            circleLayer.strokeEnd = 1.0
            circleLayer.strokeColor = UIColor.customDarkGray.cgColor
            layer.addSublayer(circleLayer)

            // setup progressLayer

            progressLayer.path = circularPath.cgPath
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = .round
            progressLayer.lineWidth = 5.0
            progressLayer.strokeEnd = 2.0
            progressLayer.strokeColor = UIColor.customRed.cgColor
            layer.addSublayer(progressLayer)
        }


    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        circularPath()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
