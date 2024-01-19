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
    var actionClickInfo: () -> Void

    var cardMasked: String = ""
    
    var navigateCoordinator: AirbaPayCoordinator
    @StateObject var editTextViewModel: CoreEditTextViewModel

    var body: some View {

            VStack(alignment: .leading) {
                InitHeader(
                    title: cvvEnter(),
                    actionClose: actionClose
                )
                
                HStack {
                    Text(cardNumber()).textStyleRegular()
                    Spacer()
                    Text(cardMasked)
                            .textStyleSemiBold()
                            .multilineTextAlignment(.trailing)

                }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                        .padding(.horizontal, 16)

               
                ViewEditText(
                        viewModel: editTextViewModel,
                        errorTitle: nil,
                        placeholder: cvv(),
                        isCvvMask: true,
                        actionOnTextChanged: { cvv in
//                            viewModel.cvvText = cvv
                        },
                        actionClickInfo: actionClickInfo
                )
                
                ViewButton(
                        title: payAmount() + " " + DataHolder.purchaseAmountFormatted,
                        actionClick: {
//                            startSavedCard(
//                                    cardId: selectedCard?.id ?? "",
//                                    cvv: selectedCard?.cvv ?? "",
//                                    isLoading: isLoading,
//                                    showCvv: showCvv,
//                                    navigateCoordinator: navigateCoordinator
//                            )
                        }
                )
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                
                Spacer()
            }
//        }
    }
}
