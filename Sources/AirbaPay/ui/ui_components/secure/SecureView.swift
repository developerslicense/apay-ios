//
//  SecureView.swift
//
//  Created by Mikhail Belikov on 26.04.2024.
//

import Foundation
import SwiftUI
import UIKit

struct SecureView<Content: View>: UIViewControllerRepresentable {

    private var preventScreenCapture: Bool
    private let content: () -> Content

    init(preventScreenCapture: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.preventScreenCapture = preventScreenCapture
        self.content = content
    }

    func makeUIViewController(context: Context) -> SecureViewHostingViewController<Content> {
        SecureViewHostingViewController(preventScreenCapture: preventScreenCapture, content: content)
    }

    func updateUIViewController(_ uiViewController: SecureViewHostingViewController<Content>, context: Context) {
        uiViewController.preventScreenCapture = preventScreenCapture
    }
}

final class SecureViewHostingViewController<Content: View>: UIViewController {

    private let content: () -> Content
    
    private let secureView = ScreenshotPreventingView()

    var preventScreenCapture: Bool = true {
        didSet {
            secureView.preventScreenCapture = preventScreenCapture
        }
    }

    init(preventScreenCapture: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.preventScreenCapture = preventScreenCapture
        self.content = content
        super.init(nibName: nil, bundle: nil)

        setupUI()
        secureView.preventScreenCapture = preventScreenCapture
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        view.addSubview(secureView)
        secureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secureView.topAnchor.constraint(equalTo: view.topAnchor),
            secureView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let hostVC = UIHostingController(rootView: content())
        hostVC.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostVC)
        secureView.setup(contentView: hostVC.view)
        hostVC.didMove(toParent: self)
    }
}
