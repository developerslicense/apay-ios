//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SimpleToast
import LocalAuthentication

struct StartProcessingView: View {
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()
    @StateObject var cvvEditTextViewModel = CoreEditTextViewModel()

    @State var presentSheet: Bool = false
    @State var needShowProgressBar: Bool = true
    var backgroundColor: Color = ColorsSdk.bgBlock

    @State private var showToast: Bool = false
    @State private var sheetState = false

    @State var detentHeight: CGFloat = 0

    var applePay: ApplePayManager


    var body: some View {
        let context = LAContext()

        ColorsSdk.bgBlock.overlay(
                        ZStack {
                            VStack {

                                ViewToolbar(
                                        title: paymentByCard(),
                                        actionClickBack: {
                                            navigateCoordinator.backToApp()
                                        }
                                )
                                        .frame(maxWidth: .infinity, alignment: .leading)


                                TopInfoView(purchaseAmount: DataHolder.purchaseAmountFormatted)
                                        .padding(.horizontal, 16)
                                        .padding(.top, 16)


                                if DataHolder.featureApplePay
                                           && viewModel.applePayUrl != nil
                                           && context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
                                {

                                    if DataHolder.isApplePayNative {

                                        if DataHolder.applePayMerchantId != nil {
                                            VStack {
                                                Image("icAPayWhite", bundle: DataHolder.moduleBundle)
                                            }

                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 48)
                                                    .background(ColorsSdk.bgAPAY)
                                                    .cornerRadius(8)
                                                    .padding(.vertical, 16)
                                                    .padding(.horizontal, 16)
                                                    .onTapGesture {
                                                        applePay.buyBtnTapped()
                                                    }
                                        }
                                    } else {
                                        ApplePayPage(
                                                redirectUrl: viewModel.applePayUrl,
                                                navigateCoordinator: navigateCoordinator
                                        )
                                                .frame(width: .infinity, height: 48)
                                                .padding(.top, 8)
                                                .padding(.horizontal, 16)
                                    }
                                }


                                if (!viewModel.savedCards.isEmpty) {
                                    InitViewStartProcessingCards(
                                            navigateCoordinator: navigateCoordinator,
                                            viewModel: viewModel
                                    )
                                            .padding(.horizontal, 16)

                                }

                                Spacer()

                                InitViewStartProcessingButtonNext(
                                        navigateCoordinator: navigateCoordinator,
                                        viewModel: viewModel,
                                        toggleCvv: { sheetState.toggle() },
                                        isLoading: { b in
                                            viewModel.isLoading = b
                                        },
                                        needTopPadding: !viewModel.savedCards.isEmpty
                                )
                            }
                                    .frame(height: .infinity)


                            if (viewModel.isLoading) {
                                ColorsSdk.bgMain
                                ProgressBarView()
                            }
                        }
                                .frame(height: .infinity)

                )
                .onAppear {
                    DataHolder.isApplePayFlow = true
                    Task {
                        await viewModel.startAuth(
                                onSuccess: {
                                    fetchMerchantsWithNextStep(
                                            viewModel: viewModel,
                                            navigateCoordinator: navigateCoordinator
                                    )
                                },
                                onError: {
                                    navigateCoordinator.openErrorPageWithCondition(errorCode: ErrorsCode().error_1.code)

                                }
                        )

                    }


                }
                .sheet(isPresented: $sheetState) {
                    if #available(iOS 16.0, *) {
                        EnterCvvBottomSheet(
                                actionClose: {
                                    sheetState.toggle()
                                },
                                isLoading: { b in viewModel.isLoading = b },
                                navigateCoordinator: navigateCoordinator,
                                viewModel: viewModel,
                                editTextViewModel: cvvEditTextViewModel
                        )
                                .presentationDetents([.height(315)])


                    } else {
                        EnterCvvBottomSheet(
                                actionClose: {
                                    sheetState.toggle()
                                },
                                isLoading: { b in viewModel.isLoading = b },
                                navigateCoordinator: navigateCoordinator,
                                viewModel: viewModel,
                                editTextViewModel: cvvEditTextViewModel
                        )
                    }

                }

    }
}

