
import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var animationTextView: UITextView!
    
    var backButtonTapped: (() -> Void)?
    
    func prepareCell(viewModel: AnimationCellModel) {
        animationImageView.image = UIImage(named: viewModel.imagePath)
        animationTextView.isScrollEnabled = false
        backButton.isHidden = true
        addTapEventHandler()
    }
    
    func handleCellSelected() {
        animationTextView.isScrollEnabled = false
        backButton.isHidden = false
        self.superview?.bringSubview(toFront: self)
    }
    
    private func addTapEventHandler() {
        backButton.addTarget(self, action: #selector(AnimationCollectionViewCell.backButtonDidTouch), for: .touchUpInside)
    }
    
    func backButtonDidTouch(_ sender: UIButton) {
        backButtonTapped?()
    }
}
