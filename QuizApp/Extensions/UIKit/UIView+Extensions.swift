import UIKit

extension UIView {
    func applyGradientWith(_ colors: [CGColor]) {
        let layer0 = CAGradientLayer()
        layer0.colors = colors
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: -1.95, b: 1.41, c: -1.41, d: -0.41, tx: 2.02, ty: -0.01))
        layer0.frame = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        layer0.position = center
        layer.insertSublayer(layer0, at: 0)
    }
}
