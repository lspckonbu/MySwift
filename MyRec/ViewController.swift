//
//  ViewController.swift
//  MyRec
//
//  Created by 若狭　健太 on 2017/07/11.
//  Copyright © 2017年 wakasa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let fileManager = FileManager()
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //　再生録音の初期化関数を呼び出す
        self.setupAudioRecorder()
        
        // アクセス許可
        if status == AVAuthorizationStatus.authorized {
            // アクセス許可あり
            print("アクセス許可あり")
        } else if status == AVAuthorizationStatus.restricted {
            // ユーザー自身にカメラへのアクセスが許可されていない
            print("ユーザー自身にカメラへのアクセスが許可されていない")
        } else if status == AVAuthorizationStatus.notDetermined {
            // まだアクセス許可を聞いていない
            print("まだアクセス許可を聞いていない")
        } else if status == AVAuthorizationStatus.denied {
            // アクセス許可されていない
            print("アクセス許可されていない")
        }
        
    }

    @IBAction func pushRecordButton(_ sender: Any) {
        audioRecorder?.record()
        // アクセス許可
        if status == AVAuthorizationStatus.authorized {
            // アクセス許可あり
            print("アクセス許可あり")
        } else if status == AVAuthorizationStatus.restricted {
            // ユーザー自身にカメラへのアクセスが許可されていない
            print("ユーザー自身にカメラへのアクセスが許可されていない")
        } else if status == AVAuthorizationStatus.notDetermined {
            // まだアクセス許可を聞いていない
            print("まだアクセス許可を聞いていない")
        } else if status == AVAuthorizationStatus.denied {
            // アクセス許可されていない
            print("アクセス許可されていない")
        }

    }
    
    @IBAction func pushStopButton(_ sender: Any) {
        audioRecorder?.stop()
    }
    
    @IBAction func pushPlayButton(_ sender: Any) {
        self.play()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //　録音のための初期設定
    func setupAudioRecorder(){
        //　再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.setActive(true)
        let recordSetting : [String : Any] = [
            AVEncoderAudioQualityKey : AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey : 16,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey: 44100.0
        ]
        do {
            try audioRecorder = AVAudioRecorder(url: self.documentFilePath(), settings: recordSetting)
        } catch {
            print("初期設定時にerror")
        }
    }
    
    // 再生
    func play(){
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: self.documentFilePath())
        }catch {
            print("再生時にerror")
        }
        audioPlayer?.play()
    }

    func documentFilePath()-> URL {
        // URLの指定
        let thePath = NSHomeDirectory() + "/Documents/sample.caf"
        // pathをURLに変更
        let fileURL = URL(fileURLWithPath: thePath)
        print(fileURL)
        return fileURL
    }

}

