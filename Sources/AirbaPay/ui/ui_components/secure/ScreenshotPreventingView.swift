//
//  ScreenshotPreventingView.swift
//
//  Created by Mikhail Belikov on 26.04.2024.
//

import Foundation
import UIKit

public final class ScreenshotPreventingView: UIView {

    public var preventScreenCapture = true {
        didSet {
            textField.isSecureTextEntry = preventScreenCapture
        }
    }

    public override var isUserInteractionEnabled: Bool {
        didSet {
            secureViewContainer?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    private var contentView: UIView?
    private let textField = UITextField()

    private lazy var secureViewContainer: UIView? = try? getSecureContainer()

    func getSecureContainer() throws -> UIView? {
        return textField.subviews.filter { subview in
            type(of: subview).description() == "_UITextLayoutCanvasView"
        }.first
    }
    
    public init(contentView: UIView? = nil) {
        self.contentView = contentView
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false

        guard let viewContainer = secureViewContainer else { return }
        
        addSubview(viewContainer)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func setup(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView

        guard let viewContainer = secureViewContainer else { return }

        viewContainer.addSubview(contentView)
        viewContainer.isUserInteractionEnabled = isUserInteractionEnabled
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor)
        bottomConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            bottomConstraint
        ])
    }
}
