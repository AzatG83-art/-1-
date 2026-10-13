import SwiftUI
import UIKit

struct FunnelDestination: View {
    let step: FunnelStep
    @Binding var debt: DebtCase
    let onContinue: () -> Void
    let onReviseEvidence: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            if step.showsProgress {
                let progress = FunnelStep.progress(for: step, debt: debt)
                FunnelProgress(current: progress.current, total: progress.total)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
            }
            screen
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle(step.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var screen: some View {
        switch step {
        case .debtorKind:
            DebtorKindStep(debt: $debt, onContinue: onContinue)
        case .origin:
            OriginStep(debt: $debt, onContinue: onContinue)
        case .amount:
            AmountStep(debt: $debt, onContinue: onContinue)
        case .transfer:
            TransferStep(debt: $debt, onContinue: onContinue)
        case .cardDetails:
            CardDetailsStep(debt: $debt, onContinue: onContinue)
        case .cashDetails:
            CashDetailsStep(debt: $debt, onContinue: onContinue)
        case .document:
            DocumentStep(debt: $debt, onContinue: onContinue)
        case .documentTerms:
            DocumentTermsStep(debt: $debt, onContinue: onContinue)
        case .admission:
            AdmissionStep(debt: $debt, onContinue: onContinue)
        case .calls:
            CallsStep(debt: $debt, onContinue: onContinue)
        case .noEvidence:
            NoEvidenceStep(debt: debt, onRevise: onReviseEvidence)
        case .dates:
            DatesStep(debt: $debt, onContinue: onContinue)
        case .lastEvent:
            LastEventStep(debt: $debt, onContinue: onContinue)
        case .partial:
            PartialStep(debt: $debt, onContinue: onContinue)
        case .actions:
            ActionsStep(debt: $debt, onContinue: onContinue)
        case .reply:
            ReplyStep(debt: $debt, onContinue: onContinue)
        case .debtor:
            DebtorInfoStep(debt: $debt, onContinue: onContinue)
        case .creditor:
            CreditorInfoStep(debt: $debt, onContinue: onContinue)
        case .delivery:
            DeliveryStep(debt: $debt, onContinue: onContinue)
        case .summary:
            SummaryStep(debt: debt, onContinue: onContinue)
        case .ready:
            ReadyStep(debt: debt)
        }
    }
}

struct WelcomeStep: View {
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 12)
            VStack(spacing: 22) {
                ZStack {
                    Circle()
                        .fill(Color.accentColor.opacity(0.12))
                        .frame(width: 128, height: 128)
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(Color.accentColor)
                        .accessibilityHidden(true)
                }
                Text("Верните долг без юриста")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                Text("Ответьте на вопросы по шагам — соберём претензию о возврате денег и подскажем, как её отправить.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 28)
            Spacer(minLength: 20)
            VStack(spacing: 12) {
                PrimaryButton(title: "Начать", action: onStart)
                Text("Конструктор текста претензии, не юрист и не суд.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [Color.accentColor.opacity(colorScheme == .dark ? 0.22 : 0.16), Color(.systemGroupedBackground)],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
        )
        .toolbar(.hidden, for: .navigationBar)
    }

    @Environment(\.colorScheme) private var colorScheme
}

struct DebtorKindStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Кто должник?",
            subtitle: "От этого зависит, как написать шапку претензии.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.debtorKind),
            action: onContinue
        ) {
            VStack(spacing: 12) {
                ForEach(DebtorKind.allCases) { kind in
                    SelectCard(
                        title: kind.title,
                        subtitle: kind.subtitle,
                        systemImage: kind.symbol,
                        isSelected: debt.debtorKind == kind
                    ) {
                        debt.debtorKind = kind
                    }
                }
            }
        }
        .sensoryFeedback(.selection, trigger: debt.debtorKind)
    }
}

struct OriginStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Как возник долг?",
            subtitle: "Выберите ближайший вариант. Детали можно будет проверить в тексте.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.origin),
            action: onContinue
        ) {
            VStack(spacing: 12) {
                ForEach(DebtOrigin.allCases) { origin in
                    SelectCard(
                        title: origin.title,
                        subtitle: origin.subtitle,
                        systemImage: origin.symbol,
                        isSelected: debt.origin == origin
                    ) {
                        debt.origin = origin
                    }
                }
            }
        }
        .sensoryFeedback(.selection, trigger: debt.origin)
    }
}

struct AmountStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Какая сумма долга?",
            subtitle: "Полная сумма, без вычета того, что уже вернули. Частичный возврат спросим отдельно.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.amount),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 14) {
                TextField("Например, 15 000", text: $debt.amountText)
                    .keyboardType(.decimalPad)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                    .background(
                        Color(.secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 16, style: .continuous)
                    )
                if !DebtCase.trimmed(debt.amountText).isEmpty, debt.parsedAmount == nil {
                    Text("Введите сумму цифрами")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                if let amount = debt.parsedAmount {
                    Text(DebtCase.formatMoney(amount))
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(Color.accentColor)
                    if amount < DebtCase.smallAmount {
                        InfoBanner(
                            tone: .warning,
                            text: "Сумма меньше 3 000 ₽. Стоит ли игра свеч: почта, время и нервы могут обойтись дороже самого долга."
                        )
                    }
                    if amount > DebtCase.courtOrderLimit {
                        InfoBanner(
                            tone: .warning,
                            text: "Сумма больше 500 000 ₽. Судебный приказ недоступен — понадобится исковое заявление."
                        )
                    }
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.parsedAmount)
        }
    }
}

struct TransferStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Как передали деньги?",
            subtitle: debt.origin == .unpaidWork
                ? "Если вам должны за работу, отметьте, как обычно должны были заплатить."
                : "Способ передачи потом попадёт в текст претензии.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.transfer),
            action: onContinue
        ) {
            VStack(spacing: 12) {
                ForEach(TransferMethod.allCases) { method in
                    SelectCard(
                        title: method.title,
                        subtitle: method.subtitle,
                        systemImage: method.symbol,
                        isSelected: debt.transferMethod == method
                    ) {
                        debt.transferMethod = method
                    }
                }
                if debt.transferMethod == .other {
                    LabeledField(
                        title: "Как именно",
                        placeholder: "Например, перевод на счёт организации",
                        text: $debt.transferNote,
                        axis: .vertical
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.transferMethod)
        }
    }
}

struct CardDetailsStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Что видно в переводе?",
            subtitle: "Назначение платежа и выписка сильно помогают, если должник начнёт отрицать долг.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.cardDetails),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 22) {
                YesNoRow(question: "В назначении есть «заём» или «в долг»?", answer: $debt.purposeMentionsLoan)
                YesNoRow(question: "Можно скачать выписку из банка?", answer: $debt.canDownloadStatement)
                if debt.canDownloadStatement == true {
                    InfoBanner(
                        tone: .info,
                        text: "Сохраните PDF выписки, где видны дата, сумма, получатель и назначение. Скриншота из приложения банка обычно мало."
                    )
                }
                if debt.purposeMentionsLoan == false {
                    InfoBanner(
                        tone: .warning,
                        text: "Без слов «заём» или «в долг» перевод проще выдать за подарок или оплату. Ищите другие подтверждения: переписку или расписку."
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.purposeMentionsLoan)
            .animation(.easeInOut(duration: 0.25), value: debt.canDownloadStatement)
        }
    }
}

struct CashDetailsStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Как прошла передача наличных?",
            subtitle: "Наличные без следа сложнее доказать. Отметьте, что осталось.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.cashDetails),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 22) {
                YesNoRow(question: "Кто-то был рядом и видел передачу?", answer: $debt.witnessPresent)
                YesNoRow(question: "Есть переписка про эти наличные?", answer: $debt.hasCashCorrespondence)
                if debt.witnessPresent == false, debt.hasCashCorrespondence == false {
                    InfoBanner(
                        tone: .warning,
                        text: "Если никто не видел передачу и переписки нет, одних слов в суде обычно недостаточно."
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.witnessPresent)
            .animation(.easeInOut(duration: 0.25), value: debt.hasCashCorrespondence)
        }
    }
}

struct DocumentStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Есть расписка или договор?",
            subtitle: "Подойдёт бумага, фото подписанного документа или договор в переписке, если его явно согласовали.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.document),
            action: onContinue
        ) {
            YesNoRow(question: "Документ на руках или в переписке есть?", answer: $debt.hasDocument)
        }
    }
}

struct DocumentTermsStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Что написано в документе?",
            subtitle: "Срок, проценты и неустойка попадут в претензию только если вы их подтвердите.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.documentTerms),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 22) {
                YesNoRow(question: "В документе указан срок возврата?", answer: $debt.hasDeadlineInDocument)
                if debt.hasDeadlineInDocument == true {
                    DatePicker(
                        "Дата из документа",
                        selection: $debt.documentDeadline,
                        in: Self.wideRange,
                        displayedComponents: .date
                    )
                    .padding(16)
                    .background(
                        Color(.secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                    )
                }
                YesNoRow(question: "Есть проценты?", answer: $debt.hasInterest)
                if debt.hasInterest == true {
                    LabeledField(
                        title: "Какие проценты",
                        placeholder: "Например, 1% в месяц",
                        text: $debt.interestNote
                    )
                }
                YesNoRow(question: "Есть неустойка?", answer: $debt.hasPenalty)
                if debt.hasPenalty == true {
                    LabeledField(
                        title: "Какая неустойка",
                        placeholder: "Например, 0,1% в день от суммы",
                        text: $debt.penaltyNote,
                        axis: .vertical
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.hasDeadlineInDocument)
            .animation(.easeInOut(duration: 0.25), value: debt.hasInterest)
            .animation(.easeInOut(duration: 0.25), value: debt.hasPenalty)
        }
    }

    private static var wideRange: ClosedRange<Date> {
        let start = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
        let end = Calendar.current.date(byAdding: .year, value: 10, to: Date()) ?? Date()
        return start...end
    }
}

struct AdmissionStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Должник признавал долг письменно?",
            subtitle: "Сообщение своими словами сильнее, чем ваше «ты должен».",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.admission),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 16) {
                YesNoRow(question: "Есть сообщение, где он признаёт долг?", answer: admissionBinding)
                if debt.hasWrittenAdmission == true {
                    VStack(spacing: 12) {
                        ForEach(AdmissionChannel.allCases) { channel in
                            SelectCard(
                                title: channel.title,
                                systemImage: channel.symbol,
                                isSelected: debt.admissionChannels.contains(channel),
                                multiple: true
                            ) {
                                debt.toggleAdmission(channel)
                            }
                        }
                    }
                    GuideCard(title: "Как сохранить скриншот с датой", items: Self.screenshotGuide)
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.hasWrittenAdmission)
        }
    }

    private var admissionBinding: Binding<Bool?> {
        Binding(
            get: { debt.hasWrittenAdmission },
            set: { newValue in
                debt.hasWrittenAdmission = newValue
                if newValue == false {
                    debt.admissionChannels = []
                }
            }
        )
    }

    private static let screenshotGuide = [
        "Откройте чат и найдите сообщение, где должник признаёт долг.",
        "В кадр должны попасть имя отправителя, текст и дата. В WhatsApp и Telegram дата стоит над группой сообщений — прокрутите к ней.",
        "Не обрезайте шапку чата: по ней видно, с кем переписка.",
        "Экспортируйте чат целиком. WhatsApp: имя контакта → Экспорт чата. Telegram: меню чата → Экспорт истории.",
        "Сразу положите копию в «Файлы». Сообщение в мессенджере могут удалить."
    ]
}

struct CallsStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Есть запись звонка, где долг признают?",
            subtitle: "Запись не заменяет расписку, но вместе с перепиской помогает.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.calls),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 16) {
                YesNoRow(question: "Такая запись есть?", answer: $debt.hasCallRecordings)
                if debt.hasCallRecordings == true {
                    InfoBanner(
                        tone: .info,
                        text: "Сохраните файл, дату разговора и номер. Запись разговора, в котором вы сами участвовали, суд смотрит вместе с другими доказательствами, а не вместо них."
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.hasCallRecordings)
        }
    }
}

struct NoEvidenceStep: View {
    let debt: DebtCase
    let onRevise: () -> Void

    var body: some View {
        StepScaffold(
            title: "Сначала соберите доказательства",
            subtitle: "Сейчас претензию лучше не отправлять и не оплачивать: опираться почти не на что.",
            buttonTitle: "Вернуться и дополнить ответы",
            action: onRevise
        ) {
            VStack(alignment: .leading, spacing: 16) {
                InfoBanner(
                    tone: .danger,
                    text: "Если отправить пустую претензию, должник может всё отрицать. Суд тогда, скорее всего, откажет, а срок давности всё равно будет идти. Платить 555 ₽ за текст без опоры не стоит."
                )
                GuideCard(
                    title: "Что собрать хотя бы в одном виде",
                    items: [
                        "Расписку или договор: сумма, дата, срок и подпись должника.",
                        "Переписку, где долг признают своими словами — WhatsApp, Telegram, SMS или почта.",
                        "Скриншоты с датой, именем и текстом и экспорт чата в «Файлы».",
                        "Выписку из банка. В назначении лучше, если есть «заём» или «в долг».",
                        "Если отдавали наличные — человека, который это видел.",
                        "Запись звонка с признанием: файл, дату и номер."
                    ]
                )
                if debt.transferMethod == .card, debt.canDownloadStatement != true {
                    InfoBanner(
                        tone: .info,
                        text: "Перевод уже след. Зайдите в банк и скачайте выписку — часто этого достаточно, чтобы двинуться дальше."
                    )
                }
            }
        }
    }
}

struct DatesStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Когда это было?",
            subtitle: "Дата передачи и срок возврата нужны и для претензии, и для проверки исковой давности.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.dates),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 18) {
                dateCard("Когда передали деньги", selection: $debt.transferDate, range: Self.pastRange)
                YesNoRow(question: "Был срок, до какого числа вернуть?", answer: $debt.hasAgreedDeadline)
                if debt.hasAgreedDeadline == true {
                    dateCard("До какого числа", selection: $debt.agreedReturnDate, range: dueRange)
                    if !DebtCase.isOnOrAfter(debt.agreedReturnDate, than: debt.transferDate) {
                        InfoBanner(
                            tone: .warning,
                            text: "Срок возврата не может быть раньше дня, когда вы передали деньги."
                        )
                    }
                } else if debt.hasAgreedDeadline == false {
                    InfoBanner(
                        tone: .info,
                        text: "Срока нет — в претензии поставим 30 дней с момента требования. Отсчёт пойдёт с дня, когда должник получит претензию, а не с сегодняшнего."
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.hasAgreedDeadline)
        }
        .onAppear {
            guard debt.hasAgreedDeadline == nil, debt.hasDeadlineInDocument == true else { return }
            debt.hasAgreedDeadline = true
            debt.agreedReturnDate = debt.documentDeadline
        }
    }

    private var dueRange: ClosedRange<Date> {
        let end = Calendar.current.date(byAdding: .year, value: 10, to: Date()) ?? Date()
        let start = min(debt.transferDate, debt.agreedReturnDate, end)
        return start...max(start, end)
    }

    private static var pastRange: ClosedRange<Date> {
        let start = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
        return start...Date()
    }

    private func dateCard(_ title: String, selection: Binding<Date>, range: ClosedRange<Date>) -> some View {
        DatePicker(title, selection: selection, in: range, displayedComponents: .date)
            .padding(16)
            .background(
                Color(.secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
    }
}

struct LastEventStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Когда должник последний раз обещал вернуть или частично платил?",
            subtitle: "Если такого не было, так и отметьте. Сумму частичного возврата спросим на следующем шаге.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.lastEvent),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 16) {
                YesNoRow(question: "Такое было?", answer: $debt.hadLastEvent)
                if debt.hadLastEvent == true {
                    DatePicker(
                        "Дата",
                        selection: $debt.lastEventDate,
                        in: eventRange,
                        displayedComponents: .date
                    )
                    .padding(16)
                    .background(
                        Color(.secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                    )
                    if !DebtCase.isOnOrAfter(debt.lastEventDate, than: debt.transferDate) {
                        InfoBanner(tone: .warning, text: "Эта дата раньше передачи денег. Поправьте её или дату передачи.")
                    }
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.hadLastEvent)
        }
    }

    private var eventRange: ClosedRange<Date> {
        let start = min(debt.transferDate, Date())
        return start...Date()
    }
}

struct PartialStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Должник уже возвращал часть?",
            subtitle: "Если да, из полной суммы вычтем её и в претензии попросим остаток.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.partial),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 16) {
                YesNoRow(question: "Частичный возврат был?", answer: $debt.didPayPartial)
                if debt.didPayPartial == true {
                    LabeledField(
                        title: "Сколько вернул",
                        placeholder: "Например, 5 000",
                        text: $debt.partialAmountText,
                        keyboard: .decimalPad,
                        capitalization: .never
                    )
                    if let message = partialError {
                        Text(message)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    DatePicker(
                        "Дата возврата",
                        selection: $debt.partialDate,
                        in: eventRange,
                        displayedComponents: .date
                    )
                    .padding(16)
                    .background(
                        Color(.secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                    )
                    if let partial = debt.parsedPartial, let total = debt.parsedAmount, partial > 0, partial < total {
                        let rest = total - partial
                        Text("Остаток: \(DebtCase.formatMoney(rest))")
                            .font(.headline)
                            .foregroundStyle(Color.accentColor)
                        if rest < DebtCase.smallAmount {
                            InfoBanner(
                                tone: .warning,
                                text: "После вычета останется меньше 3 000 ₽. Стоит ли игра свеч — решите до оплаты претензии."
                            )
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.didPayPartial)
        }
    }

    private var eventRange: ClosedRange<Date> {
        let start = min(debt.transferDate, Date())
        return start...Date()
    }

    private var partialError: String? {
        let raw = DebtCase.trimmed(debt.partialAmountText)
        guard !raw.isEmpty else { return nil }
        guard let partial = debt.parsedPartial else { return "Введите сумму цифрами" }
        guard let total = debt.parsedAmount else { return nil }
        if partial >= total {
            return "Если всё уже вернули, претензия не нужна. Сумма должна быть меньше долга."
        }
        return nil
    }
}

struct ActionsStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Что вы уже делали?",
            subtitle: "Можно отметить несколько пунктов. «Ничего» сбрасывает остальные.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.actions),
            action: onContinue
        ) {
            VStack(spacing: 12) {
                ForEach(PriorAction.allCases) { action in
                    SelectCard(
                        title: action.title,
                        systemImage: action.symbol,
                        isSelected: debt.actions.contains(action),
                        multiple: true
                    ) {
                        debt.toggleAction(action)
                    }
                }
                if debt.actions.contains(.police) {
                    InfoBanner(
                        tone: .info,
                        text: "Полиция и эта претензия — разные дороги. Заявление в полицию само по себе деньги не возвращает. Претензию и суд можно вести отдельно, не дожидаясь ответа полиции."
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.actions)
        }
    }
}

struct ReplyStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Что отвечал должник?",
            subtitle: "Последняя понятная реакция, а не то, что вам хотелось бы услышать.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.reply),
            action: onContinue
        ) {
            VStack(spacing: 12) {
                ForEach(DebtorReply.allCases) { reply in
                    SelectCard(
                        title: reply.title,
                        subtitle: reply.subtitle,
                        systemImage: reply.symbol,
                        isSelected: debt.reply == reply
                    ) {
                        debt.reply = reply
                    }
                }
            }
        }
    }
}

struct DebtorInfoStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Данные должника",
            subtitle: "Город обязателен: без него претензию некуда отправить. Улицу добавьте, если знаете.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.debtor),
            action: onContinue
        ) {
            VStack(spacing: 16) {
                LabeledField(
                    title: debt.debtorKind?.nameTitle ?? "ФИО",
                    placeholder: debt.debtorKind?.namePlaceholder ?? "ФИО",
                    text: $debt.debtorName,
                    contentType: .name,
                    capitalization: .words
                )
                LabeledField(
                    title: "Город",
                    placeholder: "Казань",
                    text: $debt.debtorCity,
                    contentType: .addressCity,
                    capitalization: .words
                )
                LabeledField(
                    title: "Улица и дом",
                    placeholder: "Необязательно, но для письма лучше указать",
                    text: $debt.debtorStreet,
                    contentType: .fullStreetAddress,
                    capitalization: .words,
                    axis: .vertical
                )
                LabeledField(
                    title: "Телефон",
                    placeholder: "+7 900 000-00-00",
                    text: $debt.debtorPhone,
                    keyboard: .phonePad,
                    contentType: .telephoneNumber,
                    capitalization: .never,
                    error: phoneError(debt.debtorPhone)
                )
                LabeledField(
                    title: "Мессенджер",
                    placeholder: "Telegram @name или WhatsApp",
                    text: $debt.debtorMessenger,
                    capitalization: .never
                )
            }
        }
    }
}

struct CreditorInfoStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Ваши данные",
            subtitle: "Так претензия будет от вашего имени, а деньги — на ваши реквизиты.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.creditor),
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 16) {
                LabeledField(
                    title: "ФИО",
                    placeholder: "Петров Пётр Петрович",
                    text: $debt.creditorName,
                    contentType: .name,
                    capitalization: .words
                )
                LabeledField(
                    title: "Телефон",
                    placeholder: "+7 900 000-00-00",
                    text: $debt.creditorPhone,
                    keyboard: .phonePad,
                    contentType: .telephoneNumber,
                    capitalization: .never,
                    error: phoneError(debt.creditorPhone)
                )
                LabeledField(
                    title: "Email",
                    placeholder: "name@mail.ru",
                    text: $debt.creditorEmail,
                    keyboard: .emailAddress,
                    contentType: .emailAddress,
                    capitalization: .never,
                    error: emailError
                )
                Text("Куда вернуть деньги")
                    .font(.subheadline.weight(.semibold))
                HStack(spacing: 12) {
                    ForEach(PayoutKind.allCases) { kind in
                        SelectCard(
                            title: kind.title,
                            systemImage: kind.symbol,
                            isSelected: debt.payoutKind == kind
                        ) {
                            debt.payoutKind = kind
                        }
                    }
                }
                if debt.payoutKind == .card {
                    LabeledField(
                        title: "Номер карты",
                        placeholder: "0000 0000 0000 0000",
                        text: $debt.cardNumber,
                        keyboard: .numberPad,
                        contentType: .creditCardNumber,
                        capitalization: .never,
                        error: cardError
                    )
                }
                if debt.payoutKind == .account {
                    LabeledField(
                        title: "Расчётный счёт",
                        placeholder: "20 цифр",
                        text: $debt.accountNumber,
                        keyboard: .numberPad,
                        capitalization: .never,
                        error: accountError
                    )
                    LabeledField(
                        title: "Банк",
                        placeholder: "Название банка",
                        text: $debt.bankName,
                        capitalization: .words
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: debt.payoutKind)
        }
    }

    private var emailError: String? {
        let value = DebtCase.trimmed(debt.creditorEmail)
        guard !value.isEmpty, !DebtCase.isValidEmail(value) else { return nil }
        return "Похоже, в адресе почты ошибка"
    }

    private var cardError: String? {
        let count = DebtCase.digitCount(debt.cardNumber)
        guard count > 0, !(16...19).contains(count) else { return nil }
        return "В номере карты обычно 16 цифр"
    }

    private var accountError: String? {
        let count = DebtCase.digitCount(debt.accountNumber)
        guard count > 0, count < 20 else { return nil }
        return "В расчётном счёте 20 цифр"
    }
}

struct DeliveryStep: View {
    @Binding var debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Как вручите претензию?",
            subtitle: "Главное — чтобы потом можно было показать, что должник её получил.",
            buttonTitle: "Далее",
            isEnabled: debt.canContinue(.delivery),
            action: onContinue
        ) {
            VStack(spacing: 12) {
                ForEach(DeliveryMethod.allCases) { method in
                    SelectCard(
                        title: method.title,
                        subtitle: method.subtitle,
                        systemImage: method.symbol,
                        isSelected: debt.delivery == method
                    ) {
                        debt.delivery = method
                    }
                }
            }
        }
    }
}

struct SummaryStep: View {
    let debt: DebtCase
    let onContinue: () -> Void

    var body: some View {
        StepScaffold(
            title: "Сводка перед претензией",
            subtitle: "Светофор собран из ваших ответов. Это ориентир, не заключение юриста.",
            buttonTitle: debt.allowsPurchase ? "Получить претензию за 555 рублей" : "Претензию пока не готовим",
            isEnabled: debt.allowsPurchase,
            action: onContinue
        ) {
            VStack(alignment: .leading, spacing: 16) {
                CardGroup {
                    FactRow(title: "Должник", value: debtorLine)
                    FactRow(title: "Сумма", value: amountLine)
                    FactRow(title: "Основание", value: debt.origin?.title ?? "—")
                    FactRow(title: "Передача", value: transferLine)
                    FactRow(title: "Срок", value: dueLine)
                    FactRow(title: "Доказательства", value: evidenceLine)
                    FactRow(title: "Вручение", value: debt.delivery?.title ?? "—")
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("Светофор")
                        .font(.headline)
                    if debt.trafficFlags.isEmpty {
                        InfoBanner(tone: .info, text: "По этим проверкам явных препятствий нет.")
                    } else {
                        ForEach(debt.trafficFlags) { flag in
                            TrafficRow(flag: flag)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 16, style: .continuous)
                )
                Text("В этой версии оплата не списывается: по кнопке сразу откроется текст претензии.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var debtorLine: String {
        let kind = debt.debtorKind?.title ?? ""
        let name = DebtCase.trimmed(debt.debtorName)
        return kind.isEmpty ? name : "\(name). \(kind)"
    }

    private var amountLine: String {
        guard let total = debt.parsedAmount else { return "—" }
        if debt.didPayPartial == true, debt.parsedPartial != nil {
            return "\(DebtCase.formatMoney(debt.remainingAmount)) осталось из \(DebtCase.formatMoney(total))"
        }
        return DebtCase.formatMoney(total)
    }

    private var transferLine: String {
        let date = DebtCase.formatDate(debt.transferDate)
        switch debt.transferMethod {
        case .card: return "\(date), перевод на карту"
        case .cash: return "\(date), наличные"
        case .other:
            let note = DebtCase.trimmed(debt.transferNote)
            return note.isEmpty ? date : "\(date), \(note)"
        case .none:
            return date
        }
    }

    private var dueLine: String {
        if debt.hasAgreedDeadline == true {
            return "До \(DebtCase.formatDate(debt.agreedReturnDate))"
        }
        return "Срок не согласован. В претензии — 30 дней с момента требования"
    }

    private var evidenceLine: String {
        let tags = debt.evidenceTags
        if tags.isEmpty { return "Почти ничего не отмечено" }
        return tags.joined(separator: ", ")
    }
}

struct ReadyStep: View {
    let debt: DebtCase
    @State private var showPDFStub = false
    @State private var copied = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(Color.accentColor)
                    Text("Претензия готова")
                        .font(.largeTitle.bold())
                    Text("Проверьте имена, суммы и даты. Потом отправьте текст способом, который выбрали.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Text(debt.claimText)
                    .font(.callout)
                    .foregroundStyle(.primary)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(
                        Color(.secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 16, style: .continuous)
                    )

                VStack(spacing: 10) {
                    PrimaryButton(title: "Скачать PDF") { showPDFStub = true }
                    SecondaryButton(
                        title: copied ? "Скопировано" : "Скопировать текст",
                        systemImage: copied ? "checkmark" : "doc.on.doc"
                    ) {
                        UIPasteboard.general.string = debt.claimText
                        copied = true
                    }
                    ShareLink(item: debt.claimText) {
                        Label("Поделиться текстом", systemImage: "square.and.arrow.up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 14))
                }

                GuideCard(title: "Как отправить", items: debt.deliverySteps)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Напоминание через 10 дней", systemImage: "bell.fill")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                    Text(DebtCase.formatDate(debt.reminderDate))
                        .font(.title3.bold())
                    Text(debt.followUpText)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.accentColor.opacity(0.12), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(20)
        }
        .alert("PDF пока недоступен", isPresented: $showPDFStub) {
            Button("Понятно", role: .cancel) {}
        } message: {
            Text("Скачивание PDF появится в следующем обновлении. Текст претензии уже можно скопировать или отправить через «Поделиться».")
        }
    }
}

private func phoneError(_ text: String) -> String? {
    let count = DebtCase.digitCount(text)
    guard count > 0, count < 10 else { return nil }
    return "Нужен номер хотя бы из 10 цифр"
}
