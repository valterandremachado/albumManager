//
//  CameraVCExtension.swift
//  AlbumCollector
//
//  Created by Valter Andre Machado on 10/27/19.
//  Copyright © 2019 Valter Andre Machado. All rights reserved.
//

import UIKit
import AVFoundation
import LBTATools

 //MARK: Camera View Controller Extension
extension CameraViewController: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! DidTakePhotoViewController

            if newCameraLayer?.position == AVCaptureDevice.Position.front
            {
                print("front camera enabled")
            let flippedImage = UIImage(cgImage: (image?.cgImage!)!, scale: image!.scale, orientation: .leftMirrored)
            // Here you have got flipped image you can pass it wherever you are using the image
            previewVC.image = flippedImage
            }
            else
            {
                print("back camera enabled")
                previewVC.image = self.image

            }
//            previewVC.image = self.image
        }
    }
    
    //: TURN OFF THE SHUTTER SOUND
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        // dispose system shutter sound
        AudioServicesDisposeSystemSoundID(1108)
    }
    
    func setupCaptureSession() {
           captureSession.sessionPreset = AVCaptureSession.Preset.photo
       }
    //: SETUP THE CAMERA VIEW (1st)
    func setupDevice() {
       
           let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
           let devices = deviceDiscoverySession.devices
           for device in devices {
               if device.position == AVCaptureDevice.Position.back {
                   backCamera = device
               } else if device.position == AVCaptureDevice.Position.front {
                   frontCamera = device
               }
           }
           
           currentCamera = backCamera
       }
    
    //: SETUP THE CAMERA VIEW (2nd)
    func setupInputOutput() {
           do {
               let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
               captureSession.addInput(captureDeviceInput)
               photoOutput = AVCapturePhotoOutput()
               photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
               captureSession.addOutput(photoOutput!)
           } catch {
               print(error)
           }
       }
       
    func setupPreviewLayer() {
           cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
           cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
           cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
           cameraPreviewLayer?.frame = self.view.frame
           self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
       }
       
    func startRunningCaptureSession() {
           captureSession.startRunning()
       }
    // FUNCTION IN CHARGE TO SWITCH CAMERA (FRONT AND BACK CAMERA)
    func switchCamera(){
        guard let input = captureSession.inputs[0] as? AVCaptureDeviceInput else { return }

            // Begin new session configuration and defer commit
            captureSession.beginConfiguration()
            defer { captureSession.commitConfiguration() }

            // Create new capture device
            if input.device.position == .back
            {
                newCameraLayer = captureDevice(with: .front)
            }
            else
            {
                newCameraLayer = captureDevice(with: .back)
            }

            // Create new capture input
            var deviceInput: AVCaptureDeviceInput!
            do {
                deviceInput = try AVCaptureDeviceInput(device: newCameraLayer!)
            } catch let error {
                print(error.localizedDescription)
                return
            }

            // Swap capture device inputs
            captureSession.removeInput(input)
            captureSession.addInput(deviceInput)
        }

        /// Create new capture device with requested position
        fileprivate func captureDevice(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {

            let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [ .builtInWideAngleCamera, .builtInMicrophone, .builtInDualCamera, .builtInTelephotoCamera ], mediaType: AVMediaType.video, position: .unspecified).devices

            //if let devices = devices {
                for device in devices {
                    if device.position == position {
                        return device
                    }
                }
            //}

            return nil
           }

           // Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
           func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
           let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
           for device in discoverySession.devices {
               if device.position == position {
                   return device
               }
           }

           return nil
    }
    
    func toggleFlash() {
            //flashEnabled = !flashEnabled
//                   if flashMode == .auto{
//                       flashMode = .on
//    //                   flashBtn.setImage(#imageLiteral(resourceName: "flash"), for: UIControl.State())
//                   }else if flashMode == .on{
//                       flashMode = .off
//    //                   flashBtn.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControl.State())
//                   }else if flashMode == .off{
//                       flashMode = .auto
//    //                   flashBtn.setImage(#imageLiteral(resourceName: "flashauto"), for: UIControl.State())
//                   }
        }
}

