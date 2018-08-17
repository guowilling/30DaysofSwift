
import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
    case resize
    case resizeAspect
    case resizeAspectFill
}

open class VideoSplashViewController: UIViewController {
    fileprivate let playerVC = AVPlayerViewController()
    fileprivate var playerSoundLevel: Float = 1.0
    
    open var videoFrame: CGRect = CGRect()
    open var startTime: CGFloat = 0.0
    open var duration: CGFloat = 0.0
    
    open var contentURL: URL? {
        didSet {
            if let _contentURL = contentURL {
                setVideoPlayer(_contentURL)
            }
        }
    }
    
    open var backgroundColor: UIColor = UIColor.black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    open var sound: Bool = true {
        didSet {
            if sound {
                playerSoundLevel = 1.0
            } else {
                playerSoundLevel = 0.0
            }
        }
    }
    
    open var alpha: CGFloat = CGFloat() {
        didSet {
            playerVC.view.alpha = alpha
        }
    }
    
    open var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(VideoSplashViewController.playerItemDidReachEnd),
                                                       name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                       object: playerVC.player?.currentItem)
            }
        }
    }
    
    open var fillMode: ScalingMode = .resizeAspectFill {
        didSet {
            switch fillMode {
            case .resize:
                playerVC.videoGravity = AVLayerVideoGravityResize
            case .resizeAspect:
                playerVC.videoGravity = AVLayerVideoGravityResizeAspect
            case .resizeAspectFill:
                playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill
            }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playerVC.view.frame = videoFrame
        playerVC.showsPlaybackControls = false
        view.addSubview(playerVC.view)
        view.sendSubview(toBack: playerVC.view)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setVideoPlayer(_ url: URL){
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            if let path = videoPath as URL? {
                self.playerVC.player = AVPlayer(url: path)
                self.playerVC.player?.play()
                self.playerVC.player?.volume = self.playerSoundLevel
            }
        }
    }
    
    func playerItemDidReachEnd() {
        playerVC.player?.seek(to: kCMTimeZero)
        playerVC.player?.play()
    }
}
