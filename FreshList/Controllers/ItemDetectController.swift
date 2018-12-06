//
//  ItemDetectController.swift
//  CoreMLCustomModel
//  Created by Team 7

import UIKit
import CoreML
import Vision

class ItemDetectController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let GuessTextField: UILabel = {
        let guessTxt = UILabel()
        guessTxt.textColor = UIColor.black
        guessTxt.text =  "Ingredient Name"
        guessTxt.translatesAutoresizingMaskIntoConstraints = false
        
        return guessTxt
    }()
    let imgview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let img = UIImage(named: "detect")
        iv.image = img
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        
        return iv
    }()
    let takePhotoButton: UIButton = {
        let tpPhoto = UIButton(type: .system)
        tpPhoto.translatesAutoresizingMaskIntoConstraints = false
        tpPhoto.setTitle("Take Photo", for: UIControlState.normal)
        tpPhoto.setTitleColor(UIColor.black, for: UIControlState.normal)
        tpPhoto.addTarget(self, action: #selector(handleTakePhoto), for: .touchUpInside)
        return tpPhoto
    }()
    
    @objc func handleTakePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
            }
    }
    
    let chooseFromLibrary: UIButton = {
        let clPhoto = UIButton(type: .system)
        clPhoto.translatesAutoresizingMaskIntoConstraints = false
        clPhoto.setTitle("Choose from photo library", for: UIControlState.normal)
        clPhoto.setTitleColor(UIColor.black, for: UIControlState.normal)
        clPhoto.addTarget(self, action: #selector(handleChooseFromLibrary), for: .touchUpInside)
        return clPhoto
    }()
    
    @objc func handleChooseFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imgview)
        view.addSubview(takePhotoButton)
        view.addSubview(chooseFromLibrary)
        view.addSubview(GuessTextField)
        setupSubViews()
        // Do any additional setup after loading the view.
    }
    
    func setupSubViews() {
        imgview.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        imgview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        chooseFromLibrary.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseFromLibrary.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePhotoButton.bottomAnchor.constraint(equalTo: chooseFromLibrary.topAnchor, constant: -8).isActive = true
        GuessTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        GuessTextField.topAnchor.constraint(equalTo: chooseFromLibrary.bottomAnchor,constant: 8).isActive = true
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.GuessTextField.text = "FreshList is thinking!"
            
            // Set the image view
            imgview.contentMode = .scaleAspectFill
            imgview.clipsToBounds = true
            imgview.image = pickedImage
            

            
            // Get the model
            guard let model = try? VNCoreMLModel(for: fruits().model) else {
                fatalError("Unable to load model")
            }
            
            // Create vision request
            let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                    let topResult = results.first
                    else {
                        fatalError("Unexpected results")
                }
                
                // Update the main UI thread with our result
                DispatchQueue.main.async {[weak self] in
                    self!.GuessTextField.text = "\(topResult.identifier) with \(Int(topResult.confidence * 100))% confidence"
                }
            }
            
            guard let ciImage = CIImage(image: pickedImage)
                else { fatalError("FreshList Cannot read picked image")}
            
            // Running the classifier
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
            picker.dismiss(animated: true, completion: nil)

        }
        
    }
}
