//
//  ViewController.swift
//  NANO_Moving Door
//
//  Created by Risma Fadillah on 19/05/19.
//  Copyright © 2019 Risma Fadillah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // imageView pintu
    @IBOutlet weak var doorImageView: UIImageView!
    
    // inisialisasi jumlah tap
    var numberOfClick = 0
    
    // variabel untuk audio player
    var backsoundPlayer: AVAudioPlayer?
    var lidCreakPlayer: AVAudioPlayer?
    var bellPlayer: AVAudioPlayer?
    var effectsPlayer: AVAudioPlayer?
    var screamPlayer: AVAudioPlayer?
    var childWhisper: AVAudioPlayer?
    
    

    
    // durasi animasi (detik)
    let animationDuration = 1.0
    
    // variabel untuk array gambar pintu kebuka dan menjauh dari pintu
    var openDoorImages: [UIImage] = []
    var scaleDoorImages: [UIImage] = []
    var farDoorImages: [UIImage] = []
    var closeDoorImages: [UIImage] = []
    var endDoorImages: [UIImage] = []
    
    
    // fungsi untuk menambahkan gambar ke variabel array diatas
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage]{
        var imageArray: [UIImage] = []
        
        for imageCount in 1..<total {
            
            // nama file gambar (e.g. "frame_1" atau "scale_1)
            let imageName = "\(imagePrefix)_\(imageCount)"
            let image = UIImage(named: imageName)!
            
            // tambahkan pada variabel array (openDoorImages atau scaleDoorImages)
            imageArray.append(image)
        }
        
        // produk dari fungsi ini adalah array yang sudah lengkap terisi gambar
        return imageArray
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        playBacksound()
        
        // inisialisasi gambar2 pada variabel array
        closeDoorImages = createImageArray(total: 7, imagePrefix: "close")
        farDoorImages = createImageArray(total: 7, imagePrefix: "far")
        scaleDoorImages = createImageArray(total: 7, imagePrefix: "scale")
        openDoorImages = createImageArray(total: 7, imagePrefix: "bigger")
        endDoorImages = createImageArray(total: 7, imagePrefix: "end")
        //endDoorImages = createImageArray(total: 12, imagePrefix: "end")
    }

    // fungsi untuk menggerakkan gambar pada array
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationDuration = 1
        imageView.animationRepeatCount = 1
        imageView.animationImages = images
        imageView.startAnimating()
        
    }
    
    func animateCloseDoor(imageView: UIImageView, images: [UIImage]) {
        imageView.animationDuration = 0.1
        imageView.animationRepeatCount = 1
        imageView.animationImages = images
        imageView.startAnimating()
        
    }
    
    // invisible button pada layar untuk memanggil fungsi animasi
    @IBAction func doorButton(_ sender: UIButton) {
        
        // saat pertama aplikasi dibuka, maka jalankan animasi pintu terbuka
        if numberOfClick == 0 {
            playLidCreak()
            animate(imageView: doorImageView, images: closeDoorImages)
            doorImageView.image = UIImage(named: "close_7")
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            
            numberOfClick = 1
        }
        // jika animasi pintu terbuka sudah dijalankan, maka tap berikutnya jalankan animasi menjauh
        else if numberOfClick == 1 {
            playBellSound()
            animate(imageView: doorImageView, images: farDoorImages)
            doorImageView.image = UIImage(named: "far_7")
            
            numberOfClick = 2
        } else if numberOfClick == 2 {
            playGirlSinging()
            playChildWhisper()
            animate(imageView: doorImageView, images: scaleDoorImages)
            doorImageView.image = UIImage(named: "scale_7")
            
            numberOfClick = 3
        } else if numberOfClick == 3 {
            //playGirlSinging()
            //playChildWhisper()
            //playSlamDoor()
            //backsoundPlayer?.stop()
            animate(imageView: doorImageView, images: openDoorImages)
            doorImageView.image = UIImage(named: "bigger_7")
        
            numberOfClick = 4
        } else {
            backsoundPlayer?.stop()
            bellPlayer?.stop()
            playSlamDoor()
            playScream()
            animateCloseDoor(imageView: doorImageView, images: endDoorImages)
            doorImageView.image = UIImage(named: "end_7")
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }

    }
    
    
    func playBacksound() {
        guard let url = Bundle.main.url(forResource: "backsound_horor_1", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            // For iOS 11
            backsoundPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            backsoundPlayer?.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    

    func playLidCreak() {
        guard let url = Bundle.main.url(forResource: "soundLidcreak", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // For iOS 11
            lidCreakPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            lidCreakPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func playGirlSinging() {
        guard let url = Bundle.main.url(forResource: "soundGirlSinging", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            // For iOS 11
            effectsPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            effectsPlayer?.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playBellSound() {
        guard let url = Bundle.main.url(forResource: "bellSound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // For iOS 11
            bellPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            bellPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSlamDoor() {
        guard let url = Bundle.main.url(forResource: "slamDoor", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // For iOS 11
            effectsPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            effectsPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playScream() {
        guard let url = Bundle.main.url(forResource: "scream", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // For iOS 11
            screamPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            screamPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playChildWhisper() {
        guard let url = Bundle.main.url(forResource: "childWhisper", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // For iOS 11
            childWhisper = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            childWhisper?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    
}


