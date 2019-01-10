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
//  SingleBgmAudioPlayer
//
//  Created by iCocos on 2019/01/03.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SingleBgmAudioPlayer.swift
// @abstract 单品背景音频播放
// @discussion 实现全局背景音乐的播放，任意时刻只会有一个背景音乐在播放
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation
import AVFoundation

// 背景音乐
//let url = http://video.zhihuishu.com/zhs_yufa_150820/zhsmanage/image/201712/ae70d4513f244edba6a4973f73de54c6_64.mp3;
//SingleBgmAudioPlayer.shared.play(audioUrl: url)

// 音效音乐
//https://github.com/adamcichy/SwiftySound

/// 背景音乐播放模型单例
class SingleBgmAudioPlayer: NSObject {
    var player: AVPlayer?
    static let shared: SingleBgmAudioPlayer = SingleBgmAudioPlayer.init()
    
    /// 播放操作
    ///
    /// - Parameter audioUrl: 播放地址：网络或本地
    func play(audioUrl: String) {
        
        guard let url = URL(string: audioUrl) else {
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        
        if let currentPlayer = player {
            currentPlayer.replaceCurrentItem(with: playerItem)
        }else {
            player = AVPlayer(playerItem: playerItem)
        }
        
        player?.play()
    }
    
    /// 暂停操作
    func pause() {
        player?.pause()
    }
}
