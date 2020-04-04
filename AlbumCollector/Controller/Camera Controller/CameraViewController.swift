//
//  ViewController.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/24/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import LBTATools

class CameraViewController: UIViewController {
//  CAMERA BUTTONS
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var switchCameraBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var closeCameraBtn: UIButton!
    
    //   VARIABLES MOT BEING USED
    var flashMode = AVCaptureDevice.FlashMode.off
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
//   VARIABLES BEING USED
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var newCameraLayer: AVCaptureDevice?
    var image: UIImage?
    
    var zoomFactor: Float = 1.0
    
    
//    let minimumZoom: CGFloat = 1.0
//    let maximumZoom: CGFloat = 3.0
//    var lastZoomFactor: CGFloat = 1.0
    
    //    HIDING THE STATUS BAR
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let screenSize = view.bounds.size
////            self.frame.bounds.size
//        if let touchPoint = touches.first {
//            let x = touchPoint.location(in: view).y / screenSize.height
//            let y = 1.0 - touchPoint.location(in: view).x / screenSize.width
//            let focusPoint = CGPoint(x: x, y: y)
//
//            if let device = currentCamera {
//                do {
//                    try device.lockForConfiguration()
//
//                    device.focusPointOfInterest = focusPoint
//                    //device.focusMode = .continuousAutoFocus
//                    device.focusMode = .autoFocus
//                    //device.focusMode = .locked
//                    device.exposurePointOfInterest = focusPoint
//                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
//                    device.unlockForConfiguration()
//                }
//                catch {
//                    // just ignore
//                }
//            }
//        }
//    }
    //MARK: INITIALIZES autoFocus/Expose and continuousAutoFocus/Exposure at the same ***
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let bounds = UIScreen.main.bounds

        let touchPoint = touches.first! as UITouch
        let screenSize = bounds.size
        let focusPoint = CGPoint(x: touchPoint.location(in: view).y / screenSize.height, y: 1.0 - touchPoint.location(in: view).x / screenSize.width)

        if let device = AVCaptureDevice.default(for:AVMediaType.video) {
            do {
                try device.lockForConfiguration()
                if device.isFocusPointOfInterestSupported {
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = AVCaptureDevice.FocusMode.autoFocus
                }
                if device.isExposurePointOfInterestSupported {
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.autoExpose
                }
                device.unlockForConfiguration()

            } catch {
                // Handle errors here
                print("There was an error focusing the device's camera")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchToZoom(sender:)))
        view.addGestureRecognizer(pinch)
        
        // AUTO FOCUS SELECTOR
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.setDefaultFocusAndExposure), name: NSNotification.Name.AVCaptureDeviceSubjectAreaDidChange, object: nil)
        
        // Do any additional setup after loading the view.
        buttonsTintColor()
        
        DispatchQueue.global(qos: .default).async {
            self.setupCaptureSession()
            self.setupDevice()
            self.setupInputOutput()
            
            self.startRunningCaptureSession()
        }
        DispatchQueue.main.async {
        self.setupPreviewLayer()
        self.captureSession.sessionPreset = .high
        }
//        setupCaptureSession()
//        setupDevice()
//        setupInputOutput()
//        setupPreviewLayer()
//        startRunningCaptureSession()
        
//        flashMode = .on
        
        // HIGH QUALITY OUTPUT

//        self.target(forAction: Selector, withSender: any)
//        takePhotoBtn.layer.borderColor = UIColor.white.cgColor
//        takePhotoBtn.layer.borderWidth = 5
//        takePhotoBtn.clipsToBounds = true
    }
//    lazy var focusGesture: UITapGestureRecognizer = {
//        let instance = UITapGestureRecognizer(target: self, action: #selector(tapToFocus(_:)))
//        instance.cancelsTouchesInView = false
//        instance.numberOfTapsRequired = 1
//        instance.numberOfTouchesRequired = 1
//        return instance
//    }()
//
//    @objc func tapToFocus(_ gesture: UITapGestureRecognizer) {
//        guard let previewLayer = cameraPreviewLayer else {
//            print("Expected a previewLayer")
//            return
//        }
//        guard let device = currentCamera else {
//            print("Expected a device")
//            return
//        }
//
//        let touchPoint: CGPoint = gesture.location(in: self.view)
//        let convertedPoint: CGPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: touchPoint)
//        if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(AVCaptureDevice.FocusMode.autoFocus) {
//            do {
//                try device.lockForConfiguration()
//                device.focusPointOfInterest = convertedPoint
//                device.focusMode = AVCaptureDevice.FocusMode.autoFocus
//                device.unlockForConfiguration()
//            } catch {
//                print("unable to focus")
//            }
//        }
//    }
    
    //REMOVING AUTO FOCUS OBSERVER
    deinit {NotificationCenter.default.removeObserver(self)}
    
    @objc func setDefaultFocusAndExposure() {

        if let device = AVCaptureDevice.default(for:AVMediaType.video) {
            do {
                try device.lockForConfiguration()
                    device.isSubjectAreaChangeMonitoringEnabled = true
                    device.focusMode = AVCaptureDevice.FocusMode.continuousAutoFocus
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()

            } catch {
                // Handle errors here
                print("There was an error focusing the device's camera")
            }
        }
    }
    
     @objc func pinchToZoom(sender: UIPinchGestureRecognizer) {

        if newCameraLayer?.position == AVCaptureDevice.Position.front
        {
            let device = frontCamera
            func minMaxZoom(_ factor: CGFloat) -> CGFloat { return min(max(factor, 1.0), (device?.activeFormat.videoMaxZoomFactor)!) }

             func update(scale factor: CGFloat) {
               do {
                try device!.lockForConfiguration()
                defer { device!.unlockForConfiguration() }
                 device!.videoZoomFactor = factor
               } catch {
                 debugPrint(error)
               }
             }

              let newScaleFactor = minMaxZoom(sender.scale * CGFloat(zoomFactor))

             switch sender.state {
               case .began: fallthrough
               case .changed: update(scale: newScaleFactor)
               case .ended:
                  zoomFactor = Float(minMaxZoom(newScaleFactor))
                  update(scale: CGFloat(zoomFactor))
              default: break
            }
            print("back camera")
        }
        else
        {
            let device = AVCaptureDevice.default(for: .video)
            func minMaxZoom(_ factor: CGFloat) -> CGFloat { return min(max(factor, 1.0), (device?.activeFormat.videoMaxZoomFactor)!) }

             func update(scale factor: CGFloat) {
               do {
                try device!.lockForConfiguration()
                defer { device!.unlockForConfiguration() }
                 device!.videoZoomFactor = factor
               } catch {
                 debugPrint(error)
               }
             }

              let newScaleFactor = minMaxZoom(sender.scale * CGFloat(zoomFactor))

             switch sender.state {
               case .began: fallthrough
               case .changed: update(scale: newScaleFactor)
               case .ended:
                  zoomFactor = Float(minMaxZoom(newScaleFactor))
                  update(scale: CGFloat(zoomFactor))
              default: break
            }
            print("front camera")
        }
    }
    
    fileprivate func buttonsTintColor(){
        flashBtn.tintColor = .white
        flashBtn.layer.shadowColor? = .init(srgbRed: 255, green: 255, blue: 255, alpha: 2)
        switchCameraBtn.tintColor = .white
        settingsBtn.tintColor = .white
        closeCameraBtn.tintColor = .white
    }
   
    @IBAction func flashModePressed(_ sender: Any) {
        toggleFlash()
    }
    
    @IBAction func closeCameraPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func takePhotoBtn(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)

    }
    
    @IBAction func cameraSwitchBtn(_ sender: Any) {
        switchCamera()
    }
    
    
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 1:
//            let vc = VideoVC()
            print("123")
        default:
            break
        }
    }
}
