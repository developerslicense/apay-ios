//
//  SweetCardScanner.swift
//  SweetCardScanner
//
//  Created by Aaron Lee on 2020-11-14.
//

import SwiftUI

public struct CardScanner: UIViewControllerRepresentable {

    private var onDismiss: (() -> Void)?
    private var onError: (() -> Void)?
    private var onSuccess: ((CreditCard) -> Void)?

    public func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = DGCardScanner { number, date, name in

            var card = CreditCard()
            card.number = number
//            card.expireDate = date
//            card.name = name

            onSuccess?(card)
        }

        return viewController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    public func onDismiss(perform callback: @escaping () -> ()) -> Self {
        var copy = self
        copy.onDismiss = callback
        return copy
    }

    public func onError(perform callback: @escaping () -> ()) -> Self {
        var copy = self
        copy.onError = callback
        return copy
    }

    public func onSuccess(perform callback: @escaping (CreditCard) -> ()) -> Self {
        var copy = self
        copy.onSuccess = callback
        return copy
    }

}
