import Foundation
import AVFoundation

struct Torch {
    enum State {
        case off
        case on
    }
    let device: AVCaptureDevice?
    var state: State
    var lastStateChange: Date
    var level: Float

    init(device: AVCaptureDevice) {
        state = .off
        lastStateChange = Date()
        if device.hasTorch {
            self.device = device
            if device.isTorchActive { state = .on }
        } else {
            self.device = nil
        }
        level = 1.0
    }

    mutating func toggle() {
        state = state == .on ? .off : .on
        do {
            try device?.lockForConfiguration()
            if state == .on {
                do { try device?.setTorchModeOn(level: level) } catch { print("could not set torch mode on") }
            } else {
                device?.torchMode = .off
            }
            device?.unlockForConfiguration()
        } catch {
            print("error setting torch level")
        }
    }

}
