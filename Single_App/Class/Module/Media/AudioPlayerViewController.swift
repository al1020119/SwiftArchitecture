//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//                  http://www.icocos.cn                       //
//                 https://icocos.github.io                    //
//                https://al1020119.github.io                  //
// **************************************************************
//  ************  😂🤔 曹理鹏(梦工厂@iCocos) 🤔😂  ************  //
// **************************************************************
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//
//  Single_App
//  SwiftImport.swift
//
//  Created by iCocos on 2019/01/03.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract 音频播放控制器
// @discussion 实现和显示音频播放，非背景
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
import UIKit
import SwiftySound

class AudioPlayerViewController: UIViewController, UITextFieldDelegate {

    //@IBOutlet weak var switchSoundEnabled: UISwitch!
    //@IBOutlet weak var switchBackgroundMusic: UISwitch!
    //@IBOutlet weak var textFieldNumberOfLoops: UITextField!
    //@IBOutlet weak var buttonDog: UIButton!
    //@IBOutlet weak var buttonCat: UIButton!
    //@IBOutlet weak var buttonStop: UIButton!
    //@IBOutlet weak var labelVolume: UILabel!
    //@IBOutlet weak var sliderVolume: UISlider!
    //@IBOutlet weak var buttonDogWithVolume: UIButton!

    private var backgroundSound: Sound?
    private var dogSound: Sound?

    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //switchSoundEnabled.isOn = Sound.enabled
        if let dogUrl = Bundle.main.url(forResource: "dog", withExtension: "wav") {
            dogSound = Sound(url: dogUrl)
        }
        if let pianoUrl = Bundle.main.url(forResource: "piano", withExtension: "wav") {
            backgroundSound = Sound(url: pianoUrl)
            backgroundSound?.volume = 0.8
            backgroundSound?.prepare()
        }
        Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: numberOfLoops())
        Sound.play(file: "cat", fileExtension: "wav", numberOfLoops: numberOfLoops())
        
        let url = "http://video.zhihuishu.com/zhs_yufa_150820/zhsmanage/image/201712/ae70d4513f244edba6a4973f73de54c6_64.mp3"
        SingleBgmAudioPlayer.shared.play(audioUrl: url)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "d返回", style: .done, handler: {
            self.dismiss(animated: true, completion: nil)
        })
    }

    /// 循环次数
    ///
    /// - Returns: 整形次数
    private func numberOfLoops() -> Int {
        //if let str = textFieldNumberOfLoops.text, let result = Int(str) {
        //    return result
        //}
        return 10
    }

    // MARK: - Actions
    @IBAction func buttonDogClicked(_ sender: Any) {
        Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: numberOfLoops())
    }

    /// Cat按钮播放点击
    ///
    /// - Parameter sender: Cat按钮
    @IBAction func buttonCatClicked(_ sender: Any) {
        Sound.play(file: "cat", fileExtension: "wav", numberOfLoops: numberOfLoops())
    }

    /// 播放音量控制
    ///
    /// - Parameter sender: 控制按钮
    @IBAction func buttonDogWithVolumeClicked(_ sender: Any) {
        dogSound?.play { completed in
            print("completed: \(completed)")
        }
    }

    /// 暂停按钮点击
    ///
    /// - Parameter sender: 暂停按钮
    @IBAction func buttonStopClicked(_ sender: Any) {
        Sound.stopAll()
        //switchBackgroundMusic.isOn = false
    }

    /// 音频开关切换
    ///
    /// - Parameter sender: 切换按钮
    @IBAction func switchSoundEnabledValueChanged(_ sender: UISwitch) {
        Sound.enabled = sender.isOn
        //if switchBackgroundMusic.isOn {
        //    enableBackgroundMusic()
        //}
    }

    /// 背景音乐切换
    ///
    /// - Parameter sender: 切换按钮
    @IBAction func switchBackgroundMusicValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            enableBackgroundMusic()
        }
        else {
            disableBackgroundMusic()
        }
    }

    /// 音量变化
    ///
    /// - Parameter sender: 滑动条
    @IBAction func sliderVolumeValueChanged(_ sender: UISlider) {
        dogSound?.volume = sender.value
        //labelVolume.text = "volume: \(String(format: "%0.0f", (sender.value * 100)))%"
    }

    // MARK: - Background music
    private func enableBackgroundMusic() {
        guard let backgroundSound = backgroundSound else { return }
        if !backgroundSound.resume() { // trying to resume
            backgroundSound.play(numberOfLoops: -1) // couldn't resume. most likely because it hasn't been played yet. playing the background sound from start. negative number of loops will cause the sound to loop infinitely
        }
    }

    private func disableBackgroundMusic() {
        backgroundSound?.pause()
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }

}
