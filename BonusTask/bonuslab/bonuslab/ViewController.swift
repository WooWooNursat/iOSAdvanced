//
//  ViewController.swift
//  bonuslab
//
//  Created by Nursat on 11.03.2021.
//

import UIKit
import AVKit
import Vision
import CoreML

class ViewController: UIViewController {
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSession()
        // Do any additional setup after loading the view.
    }
}

// MARK: - AVCaptureSession
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func setupSession() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return}
        
        let session = AVCaptureSession()
        session.sessionPreset = .hd4K3840x2160
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        imageView.layer.addSublayer(previewLayer)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        session.addOutput(output)
        session.addInput(input)
        session.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: image_classifier(configuration: MLModelConfiguration()).model) else { return }
        let request = VNCoreMLRequest(model: model) { (data, error) in
            guard let results = data.results as? [VNClassificationObservation] else { return }
            guard let firstObject = results.first else { return }
            if firstObject.confidence * 100 >= 20 {
                // display observation and confidence
                DispatchQueue.main.async {
                    // UI update here
                    self.predictionLabel.text = firstObject.identifier.capitalized
                    self.confidenceLabel.text = String(firstObject.confidence * 100) + "%"
                }
            } else {
                // display placeholders
                DispatchQueue.main.async {
                    self.predictionLabel.text = "--"
                    self.confidenceLabel.text = "--"
                    // UI update here
                }
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}

