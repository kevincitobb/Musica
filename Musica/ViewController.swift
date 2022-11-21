//
//  ViewController.swift
//  Musica
//
//  Created by Kevin Hernández on 19/11/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
 
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var sliderDuration: UISlider!
    @IBOutlet var sliderVolume: UISlider!
    
    var audioPlayer : AVAudioPlayer! = nil
    var timer : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cargarAudio()
    }
    
    func cargarAudio(){
        guard let laURL = Bundle.main.url(forResource: "brawl", withExtension: "mp3")
        else{
            print("error")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: laURL)
            inicializarInterfaz()
        }
        catch{
            print("Error al reproducir")
        }
    }
    
    func inicializarInterfaz(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizarSlider), userInfo: nil, repeats: true)
        sliderDuration.value = 0
        sliderDuration.maximumValue = Float(audioPlayer.duration)
        
        btnStop.isEnabled = false
        btnPlay.isEnabled = true
        audioPlayer.prepareToPlay()
        audioPlayer.delegate = self
        audioPlayer.volume = 1
        sliderVolume.value = 1
    }
    
    @objc func actualizarSlider(){
        let posicion = audioPlayer.currentTime
        sliderDuration.value = Float(posicion)
    }
    @IBAction func btnPlayTouch(_ sender: Any) {
        audioPlayer.play()
        btnPlay.isEnabled = false
        btnStop.isEnabled = true

    }
    @IBAction func btnStopTouch(_ sender: Any) {
        btnPlay.isEnabled = true
        btnStop.isEnabled = false
        audioPlayer.stop()
    }
    
    @IBAction func sldReproChange(_ sender: Any) {
        audioPlayer.currentTime = Double(sliderDuration.value)
    }
    @IBAction func sldVolumeChange(_ sender: UISlider) {
        audioPlayer.volume = sender.value
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.invalidate()
        inicializarInterfaz()
    }
    
    
    
}


