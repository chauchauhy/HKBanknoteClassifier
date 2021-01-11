//
//  ViewController.swift
//  HongKong_banknote_Classifier
//
//  Created by Hok yung Chau on 29/4/2020.
//  Copyright © 2020 Hok yung Chau. All rights reserved.
//

import UIKit
import Vision
import ImageIO
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var classifierLabel : String? = nil;
    var confidenceLabel : Int? = nil ;
    var result_All :[String] = [];

   
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func Select(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController();
            imagePicker.delegate = self;
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            self.classifierLabel = nil;
            self.confidenceLabel = nil;
        }
        
    }
    @IBAction func Classifier(_ sender: Any) {
        if result_All.count > 2{
            label.text? = "\(result_All[0]) \n \(result_All[1])" ;
            self.label.isHidden = false
        }else if result_All.count == 1{
            label.text? = result_All[0] ;
            self.label.isHidden = false
        }else {
            label.text? = "Unable to the Model";
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.isHidden = true;
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            label.text = "Please press the button to classifier...";
            imageView.image = pickedImage;
            imageView.contentMode = .scaleToFill
            
            // note:
                   // during import the model(MLModel)
                   // it needs press "copy item if needed" and create the fold line(reference)
                guard let model = try? VNCoreMLModel(for: banknotes_re().model) else {
                             fatalError("Unable to the Model")
                         }
            
                let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                    guard let results = request.results as? [VNClassificationObservation],
                    let topResult = results.first
                    else{
                        fatalError("Unexpected results")
                }
                
                // note:
                // in the internet, i found that the dispatcch quenue .main.sync meaning
                //  put the task into the thread(mulit)
                
                DispatchQueue.main.async {
//                    [weak self] in self?.label.text = "\(topResult.identifier) with \(Int(topResult.confidence * 100)) % confidence"
                    


                    for result in results{
                        var confidence_result = ((Int)(result.confidence * 100));
                        var identifier_result = result.identifier;
                        if confidence_result > 0{
                            self?.result_All.append("The Image show be \(identifier_result) with \(confidence_result) % confidence")
                        }
//                        self?.result_All.append("The Image show be \(identifier_result) with \(confidence_result) % confidence")
                    }
                    self?.classifierLabel = topResult.identifier;
                    self?.confidenceLabel = (Int(topResult.confidence * 100));

                }
                

                
            }
                guard let ciimage = CIImage(image: pickedImage) else {
                          fatalError("cannot read the image")}
            
                let handler = VNImageRequestHandler(ciImage: ciimage)
            DispatchQueue.global().async {
                do{
                    try handler.perform([request])
                }catch{
                    print(error)
                }
            }
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ShowResultVC{
            nextVC.results = self.result_All;
        }
    }

    }

    
    
    
    

    
    
    
    




