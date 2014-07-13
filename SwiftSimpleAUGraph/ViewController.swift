//
//  ViewController.swift
//  SwiftSimpleAUGraph
//
//  Created by Gene De Lisa on 6/8/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var soundGenerator:SoundGenerator
    
    @IBOutlet var targetLabel: UILabel
    @IBOutlet var startingLabel: UILabel
    @IBOutlet var slider: UISlider
    var targetSet: Bool = false
    
    var targetNote: UInt32?
    var startingNote: UInt32?
    var currentNote: UInt32?
    
    init(coder aDecoder: NSCoder!) {
        self.soundGenerator = SoundGenerator()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playNoteOn(b:UIButton) {
        let note:UInt32 = UInt32(b.tag)
        playThatNote(note)
        if targetSet {
            startingLabel.text = b.currentTitle
            if !startingNote {
                startingNote = UInt32(b.tag)
                setupSlider()
            }
        } else {
            targetLabel.text = b.currentTitle
            targetNote = UInt32(b.tag)
            targetSet = true
            setupSlider() 
        }
        
    }
    
    func playThatNote(note:UInt32) {
        let velocity:UInt32 = 100
        soundGenerator.playNoteOn(note, velocity: velocity)
    }
    
    @IBAction func playNoteOff(b:UIButton) {
        let note:UInt32 = UInt32(b.tag)
        soundGenerator.playNoteOff(note)
    }

    @IBAction func sliderChanged(sender : AnyObject) {
        if let note = currentNote {
            soundGenerator.playNoteOff(note)
            currentNote = UInt32(slider.value)
            playThatNote(currentNote!)
        }
        
    }
    
    func setupSlider() {
        if let target = targetNote {
            slider.maximumValue = Float(target)
        }
        if let starting = startingNote {
            slider.minimumValue = Float(starting)
            currentNote = starting
        }
    }
    
}

