//
//  ViewController.swift
//  Tarea_uno
//
//  Created by Antonio Olvera on 13/04/16.
//  Copyright © 2016 Antonio Olvera. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private var reproductor:AVAudioPlayer!
    
    
    var posicion = 0
    var status = 0
    let pickerData = ["calvin harris - blame","Drake - Hotline Bling","ed-sheeran-thinking-out-loud","hotel-california-the-eagles"]
    
    let imagenes = ["Calvin_Harris_-_Motion_opt.png","Drake_-_Hotline_Bling_opt.png","81iAXmZi7CL_opt.jpg","1208902_opt.jpg"]
    
    
    @IBOutlet var myLabel: UILabel!
    
    @IBOutlet var myPicker: UIPickerView!
    
    @IBOutlet var imagen: UIImageView!
   // private var sonidoURL = NSBundle.mainBundle().URLForResource(pickerData[posicion], withExtension: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myPicker.dataSource = self;
        self.myPicker.delegate = self;
        
        myLabel.text = pickerData[posicion]
        let image : UIImage = UIImage(named:imagenes[0])!
        imagen = UIImageView(image: image)
        imagen.frame = CGRect(x: 86, y: 28, width: 148, height: 148)
        view.addSubview(imagen)
        
       
        
    }
    
    
    func seleccionar(pos: Int){
        let sonidoURL = NSBundle.mainBundle().URLForResource(pickerData[pos], withExtension: "mp3")
        
        do {
            try reproductor = AVAudioPlayer (contentsOfURL: sonidoURL!)
        }
        catch{
            print("Error al cargar el archivo de sonido")
        }
        
        let image : UIImage = UIImage(named:imagenes[pos])!
        imagen = UIImageView(image: image)
        imagen.frame = CGRect(x: 86, y: 28, width: 148, height: 148)
        view.addSubview(imagen)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // myPicker.animationDidStart(yes)
        
        
        myPicker.selectRow(row, inComponent: 0, animated: true)
        
        
        seleccionar(row)
        
       
        myLabel.text = pickerData[row]
        
        if !reproductor.playing{
            reproductor.play()
            myLabel.text = pickerData[row]
        }
        myLabel.text = pickerData[row]
        posicion=row
        
       
        
        
    }
    
    @IBAction func Play() {
        
        
     seleccionar(posicion)
        myLabel.text = pickerData[posicion]
        
        
        
        
        if !reproductor.playing{
            reproductor.play()
            myLabel.text = pickerData[posicion]
        }
        
        
        
    }
    @IBAction func Pause() {
        
        
        if reproductor.playing{
            reproductor.pause()
        }
        
        
    }
    
    @IBAction func Stop() {
        
        if reproductor.playing{
            reproductor.stop()
        }
        
        
    }
    
   
    @IBAction func Back() {
        posicion--
        if posicion < 0 {
        posicion=0
        }
        seleccionar(posicion)
        myLabel.text = pickerData[posicion]
        reproductor.play()
       myPicker.selectRow(posicion, inComponent: 0, animated: true)
        
    }
    
    
    @IBAction func Next() {
        posicion++
        if posicion > 3{
            posicion=3
        }
        seleccionar(posicion)
        myLabel.text = pickerData[posicion]
        reproductor.play()
        myPicker.selectRow(posicion, inComponent: 0, animated: true)
        
    }
    
    @IBAction func Volumen(sender: UISlider) {
        if status != 0 {
        reproductor.volume = sender.value
        }
        else {
        seleccionar(status)
        status=1
        }
        
        
        
    }
    
    @IBAction func Random() {
        
        posicion =  random() % 4;
        seleccionar(posicion)
        myLabel.text = pickerData[posicion]
        reproductor.play()
        myPicker.selectRow(posicion, inComponent: 0, animated: true)
    }
    

}

