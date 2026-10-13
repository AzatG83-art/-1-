import Foundation

nonisolated enum FunnelStep: Hashable, Sendable {
    case debtorKind
    case origin
    case amount
    case transfer
    case cardDetails
    case cashDetails
    case document
    case documentTerms
    case admission
    case calls
    case noEvidence
    case dates
    case lastEvent
    case partial
    case actions
    case reply
    case debtor
    case creditor
    case delivery
    case summary
    case ready

    var navigationTitle: String {
        switch self {
        case .debtorKind: "Кто должник"
        case .origin: "Как возник долг"
        case .amount: "Сумма"
        case .transfer: "Передача"
        case .cardDetails: "Перевод"
        case .cashDetails: "Наличные"
        case .document: "Документ"
        case .documentTerms: "Условия"
        case .admission: "Признание"
        case .calls: "Звонки"
        case .noEvidence: "Доказательства"
        case .dates: "Даты"
        case .lastEvent: "Обещание"
        case .partial: "Частично"
        case .actions: "Что делали"
        case .reply: "Ответ"
        case .debtor: "Должник"
        case .creditor: "Ваши данные"
        case .delivery: "Вручение"
        case .summary: "Сводка"
        case .ready: "Готово"
        }
    }

    var showsProgress: Bool {
        self != .ready
    }

    static func sequence(for debt: DebtCase) -> [FunnelStep] {
        var steps: [FunnelStep] = [.debtorKind, .origin, .amount, .transfer]
        switch debt.transferMethod {
        case .card:
            steps.append(.cardDetails)
        case .cash:
            steps.append(.cashDetails)
        case .other, .none:
            break
        }
        steps.append(.document)
        if debt.hasDocument == true {
            steps.append(.documentTerms)
        }
        steps.append(contentsOf: [.admission, .calls])
        if debt.hasCallRecordings != nil, debt.hasNoEvidence {
            steps.append(.noEvidence)
            return steps
        }
        steps.append(contentsOf: [
            .dates, .lastEvent, .partial, .actions, .reply,
            .debtor, .creditor, .delivery, .summary
        ])
        return steps
    }

    static func following(_ step: FunnelStep, debt: DebtCase) -> FunnelStep? {
        if step == .summary { return .ready }
        let steps = sequence(for: debt)
        guard let index = steps.firstIndex(of: step) else { return nil }
        let next = steps.index(after: index)
        guard next < steps.endIndex else { return nil }
        return steps[next]
    }

    static func progress(for step: FunnelStep, debt: DebtCase) -> (current: Int, total: Int) {
        let steps = sequence(for: debt)
        let index = steps.firstIndex(of: step) ?? 0
        return (index + 1, max(steps.count, 1))
    }
}

extension DebtCase {
    func canContinue(_ step: FunnelStep) -> Bool {
        switch step {
        case .debtorKind:
            return debtorKind != nil
        case .origin:
            return origin != nil
        case .amount:
            return parsedAmount != nil
        case .transfer:
            guard let transferMethod else { return false }
            if transferMethod == .other {
                return Self.trimmed(transferNote).count >= 3
            }
            return true
        case .cardDetails:
            return purposeMentionsLoan != nil && canDownloadStatement != nil
        case .cashDetails:
            return witnessPresent != nil && hasCashCorrespondence != nil
        case .document:
            return hasDocument != nil
        case .documentTerms:
            guard hasDeadlineInDocument != nil, hasInterest != nil, hasPenalty != nil else { return false }
            if hasInterest == true, Self.trimmed(interestNote).isEmpty { return false }
            if hasPenalty == true, Self.trimmed(penaltyNote).isEmpty { return false }
            return true
        case .admission:
            guard let hasWrittenAdmission else { return false }
            return hasWrittenAdmission ? !admissionChannels.isEmpty : true
        case .calls:
            return hasCallRecordings != nil
        case .dates:
            guard hasAgreedDeadline != nil else { return false }
            if hasAgreedDeadline == true {
                return Self.isOnOrAfter(agreedReturnDate, than: transferDate)
            }
            return true
        case .lastEvent:
            guard let hadLastEvent else { return false }
            if hadLastEvent {
                return Self.isNotAfterToday(lastEventDate)
            }
            return true
        case .partial:
            guard let didPayPartial else { return false }
            if !didPayPartial { return true }
            guard let partial = parsedPartial, let total = parsedAmount else { return false }
            guard partial > 0, partial < total else { return false }
            return Self.isNotAfterToday(partialDate)
        case .actions:
            return !actions.isEmpty
        case .reply:
            return reply != nil
        case .debtor:
            return Self.isNamed(debtorName)
                && Self.isNamed(debtorCity)
                && Self.digitCount(debtorPhone) >= 10
                && Self.trimmed(debtorMessenger).count >= 2
        case .creditor:
            guard Self.isNamed(creditorName),
                  Self.digitCount(creditorPhone) >= 10,
                  Self.isValidEmail(creditorEmail),
                  let payoutKind else { return false }
            switch payoutKind {
            case .card:
                return (16...19).contains(Self.digitCount(cardNumber))
            case .account:
                return Self.digitCount(accountNumber) >= 20 && Self.isNamed(bankName)
            }
        case .delivery:
            return delivery != nil
        case .noEvidence, .summary, .ready:
            return true
        }
    }

    private static func isNamed(_ text: String) -> Bool {
        let value = trimmed(text)
        return value.count >= 2 && hasLetter(value)
    }
}
