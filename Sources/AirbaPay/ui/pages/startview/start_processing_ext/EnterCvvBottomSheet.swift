//
//  EnterCvvBottomSheet.swift
//
//  Created by Mikhail Belikov on 19.01.2024.
//

import Foundation
import SwiftUI
import UIKit
import SimpleToast
import FINNBottomSheet

func showBottomSheetEnterCvv(
        airbaPaySdk: AirbaPaySdk,
        selectedCard: BankCard?
) {
    DispatchQueue.main.async {
// https://stackoverflow.com/questions/65784294/how-to-detect-if-keyboard-is-present-in-swiftui

        let transitioningDelegate = BottomSheetTransitioningDelegate(
                contentHeights: [/*.bottomSheetAutomatic, */UIScreen.main.bounds.size.height - 300],
                startTargetIndex: 0
        )
        let viewController = EnterCvvBottomSheetViewController(
                navigateCoordinator: airbaPaySdk.navigateCoordinator,
                selectedCard: selectedCard
        )
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalPresentationStyle = .custom

        airbaPaySdk.navigateCoordinator.present(viewController, animated: true)

    }
}



class EnterCvvBottomSheetViewController: UIViewController {

    var navigateCoordinator: AirbaPayCoordinator
    private var editTextVM = CoreEditTextViewModel()
    var selectedCard: BankCard?

    var rootView: BottomSheetView? {
        view as? BottomSheetView
    }

    init(navigateCoordinator: AirbaPayCoordinator, selectedCard: BankCard?) {
        self.navigateCoordinator = navigateCoordinator
        self.selectedCard = selectedCard
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = BottomSheetView(
                frame: CGRect(x: 0, y: 0, width: .max, height: 300),// navigateCoordinator.view.frame,
                enterCvvBottomSheet: EnterCvvBottomSheet(
                        actionClose: {
                            self.navigateCoordinator.dismiss(animated: true)
                        },
                        isLoading: { b in

                        },
                        navigateCoordinator: navigateCoordinator,
                        selectedCard: self.selectedCard,
                        editTextViewModel: CoreEditTextViewModel()
                )
        )
    }

}

struct EnterCvvBottomSheet: View {
    var actionClose: () -> Void
    var isLoading: (Bool) -> Void

    var navigateCoordinator: AirbaPayCoordinator
    var selectedCard: BankCard?
    @StateObject var editTextViewModel: CoreEditTextViewModel
    @State var cvvToast: Bool = false
    @State var cvvError: String? = nil

    private let toastOptions = SimpleToastOptions(
            alignment: .bottom,
            hideAfter: 5
    )

    var body: some View {

        VStack(alignment: .leading) {

            InitHeader(
                    title: cvvEnter(),
                    actionClose: actionClose
            )

            VStack {
                HStack {
                    Text(cardNumber()).textStyleRegular()
                            .padding(.leading, 16)

                    Spacer()
                    Text(selectedCard?.getMaskedPanClearedWithPoint() ?? "")
                            .textStyleSemiBold()
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 16)

                }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(ColorsSdk.bgMain)
                        .cornerRadius(8)
            }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)


            ViewEditText(
                    viewModel: editTextViewModel,
                    errorTitle: cvvError,
                    placeholder: cvv(),
                    isCvvMask: true,
                    actionOnTextChanged: { cvv in },
                    actionClickInfo: {
                        cvvToast = true
                    }
            )
                    .padding(.top, 12)
                    .padding(.horizontal, 16)


            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        UIApplication.shared.endEditing()

                        if editTextViewModel.text.count >= 3 && editTextViewModel.text.count < 5 {
                            actionClose()
                            blProcessSavedCard(
                                    cardId: selectedCard?.id ?? "",
                                    cvv: editTextViewModel.text,
                                    isLoading: isLoading,
                                    navigateCoordinator: navigateCoordinator
                            )

                        } else {
                            cvvError = wrongCvv()
                        }
                    }
            )
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 32)

            Spacer()
        }
                .background(ColorsSdk.bgBlock)
                .simpleToast(isPresented: $cvvToast, options: toastOptions) {
                    Label(cvvInfo(), systemImage: "icAdd")
                            .padding()
                            .background(ColorsSdk.bgAccent.opacity(0.8))
                            .foregroundColor(ColorsSdk.bgBlock)
                            .cornerRadius(10)
                            .padding(.top)
                }
    }
}
