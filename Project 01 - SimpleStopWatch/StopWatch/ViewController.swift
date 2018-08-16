//
//  ViewController.swift
//  StopWatch
//
//  Created by Allen on 16/1/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var counter = 0.0
    var isPlaying = false
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(counter)
    }
    
    @IBAction func playButtonDidTouch(_ sender: UIButton) {
        if(isPlaying) {
            return
        }
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(ViewController.UpdateTimer),
                                     userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pauseButtonDidTouch(_ sender: UIButton) {
        timer.invalidate()
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        isPlaying = false
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIButton) {
        timer.invalidate()
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true
        isPlaying = false
        counter = 0
        timeLabel.text = String(counter)
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }
}
