//
//  EnterCvvBottomSheet.swift
//
//  Created by Mikhail Belikov on 19.01.2024.
//

import Foundation
import SwiftUI
import SimpleToast

struct EnterCvvBottomSheet: View {
    var actionClose: () -> Void
    var isLoading: (Bool) -> Void
    var toggleCvv: () -> Void

    var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()
    @StateObject var editTextViewModel: CoreEditTextViewModel
    @State var cvvToast: Bool = false
    @State var cvvError: String? = nil

    private let toastOptions = SimpleToastOptions(hideAfter: 5)

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
                    Text(viewModel.selectedCard?.getMaskedPanClearedWithPoint() ?? "")
                            .textStyleSemiBold()
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 16)

                }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
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
                    .padding(.top, 24)
                    .padding(.horizontal, 16)

            ViewButton(
                    title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                    actionClick: {
                        if editTextViewModel.text.count == 3 {
                            toggleCvv()
                            startSavedCard(
                                    cardId: viewModel.selectedCard?.id ?? "",
                                    cvv: editTextViewModel.text,
                                    isLoading: isLoading,
                                    showCvv: toggleCvv,
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
                .simpleToast(isPresented: $cvvToast, options: toastOptions) {
                    Label(cvvInfo(), systemImage: "icAdd")
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.top)
                }
//        }
    }
}
