//
// Created by Mikhail Belikov on 24.08.2023.
//

import Foundation
import SwiftUI
import SimpleToast
import LocalAuthentication

struct StartProcessingPage: View {
    var navigateCoordinator: AirbaPayCoordinator
    @StateObject var viewModel = StartProcessingViewModel()
    @StateObject var cvvEditTextViewModel = CoreEditTextViewModel()

    @State var presentSheet: Bool = false
    @State var needShowProgressBar: Bool = true
    var backgroundColor: Color = ColorsSdk.bgBlock

    @State private var showToast: Bool = false
    @State var detentHeight: CGFloat = 0

    var applePay: ApplePayManager

    init(
            navigateCoordinator: AirbaPayCoordinator,
            applePay: ApplePayManager
    ) {
        self.applePay = applePay
        self.navigateCoordinator = navigateCoordinator
    }

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


                                TopInfoView(
                                        purchaseAmount: DataHolder.purchaseAmountFormatted,
                                        purchaseNumber: viewModel.purchaseNumber
                                )
                                        .padding(.horizontal, 16)
                                        .padding(.top, 16)


                                if DataHolder.isRenderApplePay()
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
                                    } else if viewModel.applePayUrl != nil {
                                        ApplePayWebViewInternal(
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
                                        showCvv: {
                                            showBottomSheetEnterCvv(
                                                    airbaPaySdk: AirbaPaySdk.sdk!,
                                                    selectedCard: viewModel.selectedCard
                                            )
                                        },
                                        isLoading: { b in
                                            viewModel.isLoading = b
                                        },
                                        needTopPadding: !viewModel.savedCards.isEmpty
                                )
                            }
                                    .frame(height: .infinity)


                            if (viewModel.isLoading) {
                                ColorsSdk.bgMain
                                        .onTapGesture(perform: {})
                                ProgressBarView()
                            }
                        }
                                .frame(height: .infinity)

                )
                .onAppear {
                    viewModel.isLoading = true

                    fetchMerchantsWithNextStep(
                            viewModel: viewModel,
                            navigateCoordinator: navigateCoordinator
                    )
                }
                .screenshotProtected(isProtected: DataHolder.needDisableScreenShot)

    }
}

