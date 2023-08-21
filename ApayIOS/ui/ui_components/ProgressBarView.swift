//
// Created by Mikhail Belikov on 21.08.2023.
//

import Foundation
import SwiftUI

internal struct ProgressBarView: View {
    @State private var needInversedProgressBar = false
    @State private var progress = 0.0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            ProgressView(value: 1.0, total: 1.0)
                    .progressViewStyle(CircularProgressBarStyle(
                            strokeColor: needInversedProgressBar ? ColorsSdk.colorBrandMain : ColorsSdk.gray10)
                    )
                    .frame(width: 120, height: 120)
                    .contentShape(Rectangle())

            ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(CircularProgressBarStyle(
                            strokeColor: needInversedProgressBar ? ColorsSdk.gray10 : ColorsSdk.colorBrandMain)
                    )
                    .frame(width: 120, height: 120)
        }
                .onReceive(timer) { time in
                    if progress < 1.0 {
                        withAnimation {
                            progress += 0.1
                        }
                    } else {
                        needInversedProgressBar = !needInversedProgressBar
                        progress = 0.0
                    }
                }
    }
}

private struct CircularProgressBarStyle: ProgressViewStyle {
    var strokeWidth = 5.0
    var strokeColor = ColorsSdk.colorBrandMain

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {

            Circle()
                    .trim(from: 0, to: fractionCompleted)
                    .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
        }
    }
}
