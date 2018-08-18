
import UIKit

extension Array {
    func safeIndex(i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
}

class ViewController: UICollectionViewController {
    private struct Storyboard {
        static let CellIdentifier = String("AnimationCollectionViewCell")
        static let NibName = String("AnimationCollectionViewCell")
    }
    
    private struct Constants {
        static let AnimationDuration: Double = 0.5
        static let AnimationDelay: Double = 0.0
        static let AnimationSpringDamping: CGFloat = 1.0
        static let AnimationInitialSpringVelocity: CGFloat = 1.0
    }

    @IBOutlet var testCollectionView: UICollectionView!
    
    var imageCollection: AnimationImageCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollection = AnimationImageCollection()
        
        collectionView?.register(UINib(nibName: Storyboard.NibName!, bundle: nil), forCellWithReuseIdentifier: Storyboard.CellIdentifier!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection?.images.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier!, for: indexPath) as? AnimationCollectionViewCell, let viewModel = imageCollection?.images.safeIndex(i: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.prepareCell(viewModel: viewModel)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimationCollectionViewCell else {
            return
        }
        self.handleAnimationCellSelected(collectionView: collectionView, cell: cell)
    }
    
    private func handleAnimationCellSelected(collectionView: UICollectionView, cell: AnimationCollectionViewCell) {
        cell.handleCellSelected()
        cell.backButtonTapped = self.backButtonDidTouch
        
        let animations: () -> () = {
            cell.frame = collectionView.bounds
            cell.frame.origin.y += 20
        }

        let completion: (_ finished: Bool) -> () = { _ in
            collectionView.isScrollEnabled = false
        }

        UIView.animate(withDuration: Constants.AnimationDuration, delay: Constants.AnimationDelay, usingSpringWithDamping: Constants.AnimationSpringDamping, initialSpringVelocity: Constants.AnimationInitialSpringVelocity, options: [], animations: animations, completion: completion)
    }
    
    func backButtonDidTouch() {
        guard let indexPaths = self.collectionView?.indexPathsForSelectedItems else {
            return
        }
        collectionView?.isScrollEnabled = true
        collectionView?.reloadItems(at: indexPaths)
    }
}
