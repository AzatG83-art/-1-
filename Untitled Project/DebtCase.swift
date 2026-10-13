import Foundation

nonisolated enum DebtorKind: String, CaseIterable, Identifiable, Sendable {
    case person
    case soleProprietor
    case company

    var id: String { rawValue }

    var title: String {
        switch self {
        case .person: "Знакомый, родственник или коллега"
        case .soleProprietor: "ИП"
        case .company: "Компания"
        }
    }

    var subtitle: String {
        switch self {
        case .person: "Человек, а не фирма"
        case .soleProprietor: "Индивидуальный предприниматель"
        case .company: "ООО или другая организация"
        }
    }

    var symbol: String {
        switch self {
        case .person: "person.2.fill"
        case .soleProprietor: "person.text.rectangle.fill"
        case .company: "building.2.fill"
        }
    }

    var namePlaceholder: String {
        switch self {
        case .person: "Иванов Иван Иванович"
        case .soleProprietor: "ИП Иванов Иван Иванович"
        case .company: "ООО «Ромашка»"
        }
    }

    var nameTitle: String {
        switch self {
        case .person: "ФИО"
        case .soleProprietor: "ФИО предпринимателя"
        case .company: "Название"
        }
    }

    var letterLine: String {
        switch self {
        case .person: "Физическое лицо"
        case .soleProprietor: "Индивидуальный предприниматель"
        case .company: "Организация"
        }
    }
}

nonisolated enum DebtOrigin: String, CaseIterable, Identifiable, Sendable {
    case loan
    case unpaidWork
    case prepaidWork
    case rent

    var id: String { rawValue }

    var title: String {
        switch self {
        case .loan: "Занял деньги"
        case .unpaidWork: "Не заплатил за работу"
        case .prepaidWork: "Предоплата, работу не сделал"
        case .rent: "Аренда"
        }
    }

    var subtitle: String {
        switch self {
        case .loan: "Передали сумму в долг"
        case .unpaidWork: "Работу сделали, оплаты нет"
        case .prepaidWork: "Деньги внесли, результата нет"
        case .rent: "Не платит за аренду"
        }
    }

    var symbol: String {
        switch self {
        case .loan: "banknote.fill"
        case .unpaidWork: "briefcase.fill"
        case .prepaidWork: "clock.badge.exclamationmark"
        case .rent: "house.fill"
        }
    }
}

nonisolated enum TransferMethod: String, CaseIterable, Identifiable, Sendable {
    case card
    case cash
    case other

    var id: String { rawValue }

    var title: String {
        switch self {
        case .card: "Перевод на карту"
        case .cash: "Наличными"
        case .other: "Другое"
        }
    }

    var subtitle: String {
        switch self {
        case .card: "Сбер, Т-Банк или любой другой банк"
        case .cash: "Отдали деньги из рук в руки"
        case .other: "На счёт, через знакомого, иным способом"
        }
    }

    var symbol: String {
        switch self {
        case .card: "creditcard.fill"
        case .cash: "banknote.fill"
        case .other: "ellipsis.circle.fill"
        }
    }
}

nonisolated enum AdmissionChannel: String, CaseIterable, Identifiable, Sendable {
    case whatsApp
    case telegram
    case sms
    case email

    var id: String { rawValue }

    var title: String {
        switch self {
        case .whatsApp: "WhatsApp"
        case .telegram: "Telegram"
        case .sms: "SMS"
        case .email: "Email"
        }
    }

    var symbol: String {
        switch self {
        case .whatsApp: "message.fill"
        case .telegram: "paperplane.fill"
        case .sms: "message.badge.fill"
        case .email: "envelope.fill"
        }
    }
}

nonisolated enum PriorAction: String, CaseIterable, Identifiable, Sendable {
    case verbal
    case messenger
    case letter
    case police
    case nothing

    var id: String { rawValue }

    var title: String {
        switch self {
        case .verbal: "Просил устно"
        case .messenger: "Писал в мессенджере"
        case .letter: "Отправлял письмо"
        case .police: "Обращался в полицию"
        case .nothing: "Ничего"
        }
    }

    var symbol: String {
        switch self {
        case .verbal: "quote.bubble.fill"
        case .messenger: "bubble.left.and.bubble.right.fill"
        case .letter: "envelope.fill"
        case .police: "shield.fill"
        case .nothing: "minus.circle.fill"
        }
    }
}

nonisolated enum DebtorReply: String, CaseIterable, Identifiable, Sendable {
    case promised
    case refused
    case silent

    var id: String { rawValue }

    var title: String {
        switch self {
        case .promised: "Обещал вернуть"
        case .refused: "Отказывался"
        case .silent: "Молчит"
        }
    }

    var subtitle: String {
        switch self {
        case .promised: "Называл срок или просто говорил «верну»"
        case .refused: "Сказал, что ничего не должен"
        case .silent: "Не отвечает на сообщения и звонки"
        }
    }

    var symbol: String {
        switch self {
        case .promised: "checkmark.bubble.fill"
        case .refused: "hand.raised.fill"
        case .silent: "speaker.slash.fill"
        }
    }

    var claimPhrase: String {
        switch self {
        case .promised: "Должник обещал вернуть деньги."
        case .refused: "Должник отказывался признавать долг."
        case .silent: "Должник на обращения не отвечает."
        }
    }
}

nonisolated enum PayoutKind: String, CaseIterable, Identifiable, Sendable {
    case card
    case account

    var id: String { rawValue }

    var title: String {
        switch self {
        case .card: "Карта"
        case .account: "Счёт"
        }
    }

    var symbol: String {
        switch self {
        case .card: "creditcard.fill"
        case .account: "building.columns.fill"
        }
    }
}

nonisolated enum DeliveryMethod: String, CaseIterable, Identifiable, Sendable {
    case registeredLetter
    case messenger
    case inPerson

    var id: String { rawValue }

    var title: String {
        switch self {
        case .registeredLetter: "Заказное письмо с уведомлением"
        case .messenger: "Мессенджер со скриншотом"
        case .inPerson: "Лично под роспись"
        }
    }

    var subtitle: String {
        switch self {
        case .registeredLetter: "На руках останется доказательство отправки"
        case .messenger: "Быстро, если сохранить скриншот доставки"
        case .inPerson: "Должник расписывается на вашем экземпляре"
        }
    }

    var symbol: String {
        switch self {
        case .registeredLetter: "mail.stack.fill"
        case .messenger: "message.fill"
        case .inPerson: "signature"
        }
    }

    var claimPhrase: String {
        switch self {
        case .registeredLetter: "Претензию направляю заказным письмом с уведомлением о вручении и описью вложения."
        case .messenger: "Претензию направляю в мессенджер. Скриншот отправки с датой сохраню."
        case .inPerson: "Претензию вручаю лично. Прошу расписаться на втором экземпляре: дата, ФИО и подпись."
        }
    }
}

nonisolated enum TrafficTone: String, Sendable {
    case green
    case yellow
    case red
}

nonisolated struct TrafficFlag: Identifiable, Equatable, Sendable {
    let id: String
    let tone: TrafficTone
    let title: String
    let detail: String
}

nonisolated enum LimitationState: Equatable, Sendable {
    case safe
    case close(due: Date, ends: Date)
    case expired(due: Date, ends: Date)
}

nonisolated struct DebtCase: Equatable, Sendable {
    var debtorKind: DebtorKind?
    var origin: DebtOrigin?
    var amountText = ""

    var transferMethod: TransferMethod?
    var transferNote = ""

    var purposeMentionsLoan: Bool?
    var canDownloadStatement: Bool?

    var witnessPresent: Bool?
    var hasCashCorrespondence: Bool?

    var hasDocument: Bool?
    var hasDeadlineInDocument: Bool?
    var documentDeadline = Date()
    var hasInterest: Bool?
    var interestNote = ""
    var hasPenalty: Bool?
    var penaltyNote = ""

    var hasWrittenAdmission: Bool?
    var admissionChannels: Set<AdmissionChannel> = []

    var hasCallRecordings: Bool?

    var transferDate = Date()
    var hasAgreedDeadline: Bool?
    var agreedReturnDate = Date()

    var hadLastEvent: Bool?
    var lastEventDate = Date()

    var didPayPartial: Bool?
    var partialAmountText = ""
    var partialDate = Date()

    var actions: Set<PriorAction> = []
    var reply: DebtorReply?

    var debtorName = ""
    var debtorCity = ""
    var debtorStreet = ""
    var debtorPhone = ""
    var debtorMessenger = ""

    var creditorName = ""
    var creditorPhone = ""
    var creditorEmail = ""
    var payoutKind: PayoutKind?
    var cardNumber = ""
    var accountNumber = ""
    var bankName = ""

    var delivery: DeliveryMethod?
    var claimCreatedAt: Date?

    static let smallAmount: Decimal = 3_000
    static let writtenThreshold: Decimal = 10_000
    static let courtOrderLimit: Decimal = 500_000

    var parsedAmount: Decimal? { Self.parseMoney(amountText) }
    var parsedPartial: Decimal? { Self.parseMoney(partialAmountText) }

    var remainingAmount: Decimal {
        let total = parsedAmount ?? 0
        guard didPayPartial == true, let partial = parsedPartial else { return total }
        return max(0, total - partial)
    }

    var debtorAddressLine: String {
        let city = Self.trimmed(debtorCity)
        let street = Self.trimmed(debtorStreet)
        if street.isEmpty { return city }
        if city.isEmpty { return street }
        return "\(city), \(street)"
    }

    var evidenceWeight: Int {
        var weight = 0
        if hasDocument == true { weight += 2 }
        if hasWrittenAdmission == true, !admissionChannels.isEmpty { weight += 2 }
        if canDownloadStatement == true { weight += 2 }
        if purposeMentionsLoan == true { weight += 1 }
        if witnessPresent == true { weight += 1 }
        if hasCashCorrespondence == true { weight += 1 }
        if hasCallRecordings == true { weight += 1 }
        return weight
    }

    var hasNoEvidence: Bool { evidenceWeight == 0 }

    var hasAlmostNoEvidence: Bool { evidenceWeight < 2 }

    var hasWrittenEvidence: Bool {
        if hasDocument == true { return true }
        if hasWrittenAdmission == true, !admissionChannels.isEmpty { return true }
        if canDownloadStatement == true { return true }
        return false
    }

    var allowsPurchase: Bool {
        !hasNoEvidence && !Self.trimmed(debtorCity).isEmpty && (parsedAmount ?? 0) > 0
    }

    var limitationState: LimitationState {
        guard hasAgreedDeadline == true else { return .safe }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: claimCreatedAt ?? Date())
        let due = calendar.startOfDay(for: agreedReturnDate)
        guard due <= today else { return .safe }
        guard let ends = calendar.date(byAdding: .year, value: 3, to: due) else { return .safe }
        if today > ends { return .expired(due: due, ends: ends) }
        if let closeFrom = calendar.date(byAdding: .month, value: -6, to: ends), today >= closeFrom {
            return .close(due: due, ends: ends)
        }
        return .safe
    }

    var trafficFlags: [TrafficFlag] {
        var flags: [TrafficFlag] = []

        switch limitationState {
        case .safe:
            break
        case .close(let due, let ends):
            flags.append(
                TrafficFlag(
                    id: "limitation-close",
                    tone: .yellow,
                    title: "Срок исковой давности близко",
                    detail: "Вернуть должны были \(Self.formatDate(due)). Три года истекают \(Self.formatDate(ends)) — осталось меньше полугода. Суд учитывает давность, если о ней заявит должник."
                )
            )
        case .expired(let due, let ends):
            flags.append(
                TrafficFlag(
                    id: "limitation-expired",
                    tone: .yellow,
                    title: "Срок исковой давности, похоже, прошёл",
                    detail: "С даты возврата \(Self.formatDate(due)) прошло больше трёх лет, срок истёк \(Self.formatDate(ends)). Суд применит давность, только если должник об этом попросит, но риск отказа высокий."
                )
            )
        }

        if let amount = parsedAmount, amount > Self.writtenThreshold, !hasWrittenEvidence {
            flags.append(
                TrafficFlag(
                    id: "no-writing",
                    tone: .yellow,
                    title: "Сумма больше 10 000 ₽ и нет письменных доказательств",
                    detail: "Расписки, признания в переписке или банковской выписки нет. Для такой суммы одних слов обычно мало."
                )
            )
        }

        if let amount = parsedAmount, amount > Self.courtOrderLimit {
            flags.append(
                TrafficFlag(
                    id: "needs-lawsuit",
                    tone: .yellow,
                    title: "Нужен иск, не судебный приказ",
                    detail: "Сумма больше 500 000 ₽. После претензии приказ недоступен — готовить исковое заявление."
                )
            )
        } else if let amount = parsedAmount, amount > 0 {
            flags.append(
                TrafficFlag(
                    id: "court-order",
                    tone: .green,
                    title: "Можно подать судебный приказ до 500 000 ₽",
                    detail: "После претензии можно просить судебный приказ. Если должник пришлёт возражения, приказ отменят — тогда подают иск."
                )
            )
        }

        if Self.trimmed(debtorCity).isEmpty {
            flags.append(
                TrafficFlag(
                    id: "no-address",
                    tone: .red,
                    title: "Нет адреса должника",
                    detail: "Без города претензию некуда отправлять. В судебном приказе и иске адрес ответчика тоже нужен."
                )
            )
        }

        if hasAlmostNoEvidence {
            flags.append(
                TrafficFlag(
                    id: "thin-evidence",
                    tone: .red,
                    title: "Почти нет доказательств",
                    detail: "Должник может сказать, что денег не брал. Без расписки, переписки или выписки суд часто отказывает."
                )
            )
        }

        return flags
    }

    var reminderDate: Date {
        let base = claimCreatedAt ?? Date()
        return Calendar.current.date(byAdding: .day, value: 10, to: base) ?? base
    }

    var evidenceTags: [String] {
        var tags: [String] = []
        if hasDocument == true { tags.append("расписка или договор") }
        if hasWrittenAdmission == true, !admissionChannels.isEmpty {
            let names = AdmissionChannel.allCases.filter { admissionChannels.contains($0) }.map(\.title).joined(separator: ", ")
            tags.append("признание: \(names)")
        }
        if canDownloadStatement == true { tags.append("выписка из банка") }
        if purposeMentionsLoan == true { tags.append("в назначении «заём» или «в долг»") }
        if witnessPresent == true { tags.append("был свидетель") }
        if hasCashCorrespondence == true { tags.append("переписка о наличных") }
        if hasCallRecordings == true { tags.append("запись звонка") }
        return tags
    }

    mutating func toggleAdmission(_ channel: AdmissionChannel) {
        if admissionChannels.contains(channel) {
            admissionChannels.remove(channel)
        } else {
            admissionChannels.insert(channel)
        }
        if !admissionChannels.isEmpty {
            hasWrittenAdmission = true
        }
    }

    mutating func toggleAction(_ action: PriorAction) {
        if action == .nothing {
            actions = actions == [.nothing] ? [] : [.nothing]
            return
        }
        actions.remove(.nothing)
        if actions.contains(action) {
            actions.remove(action)
        } else {
            actions.insert(action)
        }
    }

    var claimText: String {
        let created = claimCreatedAt ?? Date()
        var parts: [String] = []
        parts.append("ПРЕТЕНЗИЯ\nо возврате задолженности")
        parts.append(Self.formatDate(created))
        parts.append(partiesBlock)
        parts.append(storyParagraph)
        if let partial = partialParagraph {
            parts.append(partial)
        }
        parts.append(termParagraph)
        if let document = documentParagraph {
            parts.append(document)
        }
        parts.append(evidenceParagraph)
        parts.append(historyParagraph)
        parts.append(requestParagraph)
        if let delivery {
            parts.append(delivery.claimPhrase)
        }
        parts.append(Self.trimmed(creditorName))
        parts.append("Черновик собран из ответов в приложении. Перед отправкой проверьте ФИО, суммы, даты и адрес. Это не юридическая консультация.")
        return parts.joined(separator: "\n\n")
    }

    var deliverySteps: [String] {
        switch delivery {
        case .registeredLetter:
            return [
                "Распечатайте претензию в двух экземплярах.",
                "Отправьте заказным письмом с уведомлением о вручении и описью вложения.",
                "В адресе укажите город и улицу из претензии. Сохраните чек и трек-номер.",
                "Дата на уведомлении о вручении — точка отсчёта срока."
            ]
        case .messenger:
            return [
                "Отправьте текст претензии в тот мессенджер, где вы уже общаетесь.",
                "Сразу сделайте скриншот: имя чата, текст, время и статус «доставлено» или «прочитано».",
                "Экспортируйте чат в «Файлы». Сообщение не удаляйте."
            ]
        case .inPerson:
            return [
                "Распечатайте два экземпляра.",
                "Один отдайте должнику. На вашем он пишет: «претензию получил», дату, ФИО и подпись.",
                "Если подписать отказывается, не оставляйте единственный экземпляр — отправьте претензию ещё и заказным письмом."
            ]
        case .none:
            return ["Выберите способ вручения и сохраните подтверждение отправки."]
        }
    }

    var followUpText: String {
        let date = Self.formatDate(reminderDate)
        let court: String
        if let amount = parsedAmount, amount > Self.courtOrderLimit {
            court = "Сумма больше 500 000 ₽, судебный приказ недоступен — понадобится исковое заявление."
        } else {
            court = "Если сумма до 500 000 ₽, можно просить судебный приказ. Возражения должника приказ отменяют, тогда подают иск."
        }
        var text = "\(date) проверьте, дошла ли претензия и пришли ли деньги. Если ответа нет, готовьте суд. \(court)"
        if actions.contains(.police) {
            text += " Полиция долг не взыскивает: претензия и суд идут отдельно от заявления в полицию."
        }
        return text
    }

    private var partiesBlock: String {
        """
        Кому: \(Self.trimmed(debtorName))
        \(debtorKind?.letterLine ?? "Должник")
        Адрес: \(debtorAddressLine)
        Телефон: \(Self.trimmed(debtorPhone))
        Мессенджер: \(Self.trimmed(debtorMessenger))

        От кого: \(Self.trimmed(creditorName))
        Телефон: \(Self.trimmed(creditorPhone))
        Эл. почта: \(Self.trimmed(creditorEmail))
        """
    }

    private var storyParagraph: String {
        let date = Self.formatDate(transferDate)
        let sum = Self.formatMoney(parsedAmount ?? 0)
        let who = Self.trimmed(debtorName)
        let how = transferPhrase
        switch origin {
        case .loan:
            return "\(date) должнику \(who) переданы денежные средства в размере \(sum) в долг. Способ передачи: \(how)."
        case .unpaidWork:
            return "Должник \(who) не оплатил выполненную работу. Задолженность составляет \(sum). Дата, с которой считаю долг возникшим: \(date). Как должны были пройти расчёты: \(how)."
        case .prepaidWork:
            return "\(date) должнику \(who) передана предоплата \(sum). Способ передачи: \(how). Работа не выполнена, деньги не возвращены."
        case .rent:
            return "У должника \(who) задолженность по арендной плате в размере \(sum). Дата возникновения долга: \(date). Как должны были передать оплату: \(how)."
        case .none:
            return "Задолженность должника \(who) составляет \(sum). Дата: \(date). Способ передачи: \(how)."
        }
    }

    private var transferPhrase: String {
        switch transferMethod {
        case .card:
            var phrase = "перевод на карту"
            if purposeMentionsLoan == true {
                phrase += ", в назначении платежа есть «заём» или «в долг»"
            } else if purposeMentionsLoan == false {
                phrase += ", в назначении платежа слов «заём» или «в долг» не было"
            }
            if canDownloadStatement == true {
                phrase += ". Банковскую выписку могу приложить"
            }
            return phrase
        case .cash:
            var phrase = "наличные"
            if witnessPresent == true {
                phrase += ", при передаче был свидетель"
            }
            if hasCashCorrespondence == true {
                phrase += ", есть переписка об этой передаче"
            }
            return phrase
        case .other:
            let note = Self.trimmed(transferNote)
            return note.isEmpty ? "иной способ" : note
        case .none:
            return "способ уточняется"
        }
    }

    private var partialParagraph: String? {
        if didPayPartial == false {
            return "Частичных возвратов не было."
        }
        guard didPayPartial == true, let partial = parsedPartial, let total = parsedAmount else { return nil }
        return "Из \(Self.formatMoney(total)) должник уже вернул \(Self.formatMoney(partial)) \(Self.formatDate(partialDate)). Остаток к возврату — \(Self.formatMoney(remainingAmount))."
    }

    private var termParagraph: String {
        if hasAgreedDeadline == true {
            let due = Self.formatDate(agreedReturnDate)
            let today = Calendar.current.startOfDay(for: claimCreatedAt ?? Date())
            if Calendar.current.startOfDay(for: agreedReturnDate) <= today {
                return "Срок возврата был согласован до \(due) и уже наступил. Прошу погасить остаток в течение 10 календарных дней с момента получения этой претензии."
            }
            return "Срок возврата согласован до \(due). Прошу вернуть деньги не позднее этой даты."
        }
        return "Согласованного срока возврата не было. Эта претензия — требование вернуть долг. Прошу сделать это в течение 30 календарных дней с момента получения требования."
    }

    private var documentParagraph: String? {
        guard hasDocument == true else {
            return "Расписки или договора нет."
        }
        var lines = ["Есть расписка или договор."]
        if hasDeadlineInDocument == true {
            lines.append("В документе указан срок возврата: \(Self.formatDate(documentDeadline)).")
        } else if hasDeadlineInDocument == false {
            lines.append("В документе срок возврата не указан.")
        }
        if hasInterest == true {
            lines.append("Проценты: \(Self.trimmed(interestNote)).")
        } else if hasInterest == false {
            lines.append("Проценты не предусмотрены.")
        }
        if hasPenalty == true {
            lines.append("Неустойка: \(Self.trimmed(penaltyNote)).")
        } else if hasPenalty == false {
            lines.append("Неустойка не предусмотрена.")
        }
        if hasAgreedDeadline == false, hasDeadlineInDocument == true {
            lines.append("Проверьте, не разошлись ли дата в документе и ответ про срок: в требовании сейчас стоит срок 30 дней с момента получения претензии.")
        }
        return lines.joined(separator: " ")
    }

    private var evidenceParagraph: String {
        var lines = ["Чем подтверждаю долг:"]
        if evidenceTags.isEmpty {
            lines.append("отдельных подтверждений пока нет.")
        } else {
            lines.append(evidenceTags.joined(separator: "; ") + ".")
        }
        if hasWrittenAdmission == true, !admissionChannels.isEmpty {
            lines.append("Скриншоты переписки сохраню так, чтобы были видны имя отправителя, текст признания и дата сообщения.")
        }
        if hasAlmostNoEvidence {
            lines.append("Доказательств мало, к претензии приложу всё, что есть, и не буду удалять переписку.")
        } else {
            lines.append("Копии приложу к претензии.")
        }
        return lines.joined(separator: " ")
    }

    private var historyParagraph: String {
        var lines: [String] = []
        if actions == [.nothing] || actions.isEmpty {
            lines.append("До этой претензии отдельного требования должнику не направлялось.")
        } else {
            let done = PriorAction.allCases
                .filter { actions.contains($0) && $0 != .nothing }
                .map(\.title)
                .joined(separator: ", ")
                .lowercased()
            lines.append("До этой претензии уже было так: \(done).")
        }
        if hadLastEvent == true {
            lines.append("Последний раз должник обещал вернуть деньги или частично платил \(Self.formatDate(lastEventDate)).")
        } else if hadLastEvent == false {
            lines.append("После передачи денег обещаний вернуть и частичных оплат не было.")
        }
        if let reply {
            lines.append(reply.claimPhrase)
        }
        if actions.contains(.police) {
            lines.append("Обращение в полицию не заменяет эту претензию и не взыскивает деньги. Гражданское требование направляю отдельно.")
        }
        return lines.joined(separator: " ")
    }

    private var requestParagraph: String {
        let sum = Self.formatMoney(remainingAmount)
        return """
        На основании изложенного прошу вернуть задолженность в размере \(sum).
        Реквизиты для возврата: \(payoutLine).
        Если деньги не поступят в указанный срок, обращусь в суд за взысканием суммы долга и расходов на отправку претензии.
        """
    }

    private var payoutLine: String {
        switch payoutKind {
        case .card:
            return "карта \(Self.groupedDigits(cardNumber, stride: 4))"
        case .account:
            return "счёт \(Self.groupedDigits(accountNumber, stride: 4)) в \(Self.trimmed(bankName))"
        case .none:
            return "реквизиты сообщу дополнительно"
        }
    }

    static func trimmed(_ text: String) -> String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static func hasLetter(_ text: String) -> Bool {
        text.unicodeScalars.contains { CharacterSet.letters.contains($0) }
    }

    static func digitCount(_ text: String) -> Int {
        text.filter(\.isNumber).count
    }

    static func isValidEmail(_ text: String) -> Bool {
        let value = trimmed(text)
        guard let at = value.firstIndex(of: "@") else { return false }
        let name = value[..<at]
        let domain = value[value.index(after: at)...]
        return !name.isEmpty && domain.contains(".") && !domain.hasPrefix(".") && !domain.hasSuffix(".")
    }

    static func parseMoney(_ text: String) -> Decimal? {
        var cleaned = trimmed(text).lowercased()
        for token in [" ", "\u{00a0}", "\u{202f}", "₽", "руб.", "руб", "р."] {
            cleaned = cleaned.replacingOccurrences(of: token, with: "")
        }
        cleaned = cleaned.replacingOccurrences(of: ",", with: ".")
        guard let value = Decimal(string: cleaned, locale: Locale(identifier: "en_US_POSIX")), value > 0 else {
            return nil
        }
        return value
    }

    static func formatMoney(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let digits = formatter.string(from: NSDecimalNumber(decimal: amount))
            ?? NSDecimalNumber(decimal: amount).stringValue
        return digits + "\u{00a0}₽"
    }

    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    static func groupedDigits(_ text: String, stride width: Int) -> String {
        let digits = text.filter(\.isNumber)
        guard !digits.isEmpty else { return trimmed(text) }
        var groups: [String] = []
        var index = digits.startIndex
        while index < digits.endIndex {
            let end = digits.index(index, offsetBy: width, limitedBy: digits.endIndex) ?? digits.endIndex
            groups.append(String(digits[index..<end]))
            index = end
        }
        return groups.joined(separator: " ")
    }

    static func isOnOrAfter(_ date: Date, than other: Date) -> Bool {
        Calendar.current.startOfDay(for: date) >= Calendar.current.startOfDay(for: other)
    }

    static func isNotAfterToday(_ date: Date) -> Bool {
        Calendar.current.startOfDay(for: date) <= Calendar.current.startOfDay(for: Date())
    }
}
