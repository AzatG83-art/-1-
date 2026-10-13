import SwiftUI

struct ContentView: View {
    @State private var debt = DebtCase()
    @State private var path: [FunnelStep] = []

    var body: some View {
        NavigationStack(path: $path) {
            WelcomeStep {
                path.append(.debtorKind)
            }
            .navigationDestination(for: FunnelStep.self) { step in
                FunnelDestination(
                    step: step,
                    debt: $debt,
                    onContinue: { advance(from: step) },
                    onReviseEvidence: reviseEvidence
                )
            }
        }
    }

    private func advance(from step: FunnelStep) {
        if step == .summary {
            debt.claimCreatedAt = Date()
        }
        guard let next = FunnelStep.following(step, debt: debt) else { return }
        // Убираем из стека всё, что после текущего шага, и шаги, которых больше нет
        // в последовательности, чтобы после смены ответа не оставались устаревшие экраны.
        if let index = path.lastIndex(of: step) {
            path.removeSubrange(path.index(after: index)..<path.endIndex)
        }
        let valid = Set(FunnelStep.sequence(for: debt) + [.ready])
        path.removeAll { $0 != step && !valid.contains($0) }
        path.append(next)
    }

    private func reviseEvidence() {
        if let index = path.lastIndex(of: .document) {
            path.removeSubrange(path.index(after: index)..<path.endIndex)
        } else if !path.isEmpty {
            path.removeLast()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.locale, Locale(identifier: "ru_RU"))
}

#Preview("Тёмная тема") {
    ContentView()
        .environment(\.locale, Locale(identifier: "ru_RU"))
        .preferredColorScheme(.dark)
}
