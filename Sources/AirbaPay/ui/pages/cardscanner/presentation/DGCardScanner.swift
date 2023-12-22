
import AVFoundation
import CoreImage
import UIKit
import Vision

public class DGCardScanner: UIViewController, TorchProtocol {

    // MARK: - Private Properties
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: self.captureSession)
        preview.videoGravity = .resizeAspect
        return preview
    }()

    private let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera,
                          .builtInDualCamera,
                          .builtInTrueDepthCamera],
            mediaType: .video,
            position: .back).devices.first ?? AVCaptureDevice.default(for: .video)


    private var viewGuide: PartialTransparentView!

    private var creditCardNumber: String?
    private var creditCardName: String?
    private var creditCardDate: String?
    private var matchedCount = 0

    private let videoOutput = AVCaptureVideoDataOutput()
    private var torch: Torch?

    // MARK: - Instance dependencies
    private let resultsHandler: (_ number: String, _ date: String, _ name: String) -> Void

    // MARK: - Initializers
    init(resultsHandler: @escaping (_ number: String, _ date: String, _ name: String) -> Void) {
        self.resultsHandler = resultsHandler
        super.init(nibName: nil, bundle: nil)
        TorchHolder.observer = self
    }

    public class func getScanner(resultsHandler: @escaping (_ number: String, _ date: String, _ name: String) -> Void) -> UIViewController {
        DGCardScanner(resultsHandler: resultsHandler)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = UIView()
    }

    deinit {
        stop()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
//        DispatchQueue.global(qos: .background).async { // перестает работать
        self.captureSession.startRunning()
//        }
    }

    func clickOnTorch() {
        Task {
            torch?.toggle()
        }
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }

    // MARK: - Add Views
    private func setupCaptureSession() {
        addCameraInput()
        addPreviewLayer()
        addVideoOutput()
        addGuideView()
    }

    private func addCameraInput() {
        guard let device = device else { return }
        torch = Torch(device: device)

        let cameraInput = try! AVCaptureDeviceInput(device: device)
        captureSession.addInput(cameraInput)
    }

    private func addPreviewLayer() {
        view.layer.addSublayer(previewLayer)
    }

    private func addVideoOutput() {
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as NSString: NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "my.image.handling.queue"))
        captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(with: AVMediaType.video),
              connection.isVideoOrientationSupported else {
            return
        }
        connection.videoOrientation = .portrait
    }

    private func addGuideView() {
        let widht = UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.2)
        let height = widht - (widht * 0.45)
        let viewX = (UIScreen.main.bounds.width / 2) - (widht / 2)
        let viewY = (UIScreen.main.bounds.height / 2) - (height / 2) - 100

        viewGuide = PartialTransparentView(rectsArray: [CGRect(x: viewX, y: viewY, width: widht, height: height)])

        view.addSubview(viewGuide)
        viewGuide.translatesAutoresizingMaskIntoConstraints = false
        viewGuide.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        viewGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        viewGuide.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        viewGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        view.bringSubviewToFront(viewGuide)

        view.backgroundColor = .black
    }


    // MARK: - Completed process
    @objc func scanCompleted(creditCardNumber: String, creditCardDate: String, creditCardName: String) {
        resultsHandler(creditCardNumber, creditCardDate, creditCardName)
        stop()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }

    }

    private func stop() {
        captureSession.stopRunning()
    }
}
