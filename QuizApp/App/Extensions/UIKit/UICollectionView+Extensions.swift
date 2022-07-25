import UIKit

extension UICollectionView {

    static func makeCollectionView(direction: ScrollDirection, spacing: CGFloat) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        layout.scrollDirection = direction
        layout.minimumLineSpacing = spacing
        return view
    }

}
