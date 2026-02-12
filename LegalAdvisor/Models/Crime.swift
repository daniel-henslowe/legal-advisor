import Foundation

struct Crime: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let section: String
    let category: CrimeCategory
    let description: String
    let minimumSentence: Sentence?
    let maximumSentence: Sentence
    let youthModifier: YouthModifier?
    let notes: String?
    let statute: Statute
    let canliiURL: String?

    var formattedSection: String {
        switch statute {
        case .criminalCode:
            return "CC s. \(section)"
        case .cdsa:
            return "CDSA s. \(section)"
        case .cannabisAct:
            return "Cannabis Act s. \(section)"
        case .firearmsAct:
            return "Firearms Act s. \(section)"
        case .youthCriminalJusticeAct:
            return "YCJA s. \(section)"
        case .immigrationAct:
            return "IRPA s. \(section)"
        case .customsAct:
            return "Customs Act s. \(section)"
        case .competitionAct:
            return "Competition Act s. \(section)"
        case .incomeTexAct:
            return "ITA s. \(section)"
        case .copyrightAct:
            return "Copyright Act s. \(section)"
        case .trademarkAct:
            return "Trademarks Act s. \(section)"
        case .environmentalProtectionAct:
            return "CEPA s. \(section)"
        case .fisheriesAct:
            return "Fisheries Act s. \(section)"
        case .speciesAtRiskAct:
            return "SARA s. \(section)"
        case .wildlifeAct:
            return "Wild Animal Act s. \(section)"
        case .explosivesAct:
            return "Explosives Act s. \(section)"
        case .securityOfInfoAct:
            return "SOIA s. \(section)"
        case .proceedsOfCrimeAct:
            return "PCMLTFA s. \(section)"
        }
    }

    init(
        name: String,
        section: String,
        category: CrimeCategory,
        description: String,
        minimumSentence: Sentence?,
        maximumSentence: Sentence,
        youthModifier: YouthModifier?,
        notes: String?,
        statute: Statute = .criminalCode,
        canliiURL: String? = nil
    ) {
        self.name = name
        self.section = section
        self.category = category
        self.description = description
        self.minimumSentence = minimumSentence
        self.maximumSentence = maximumSentence
        self.youthModifier = youthModifier
        self.notes = notes
        self.statute = statute
        self.canliiURL = canliiURL
    }
}

enum Statute: String, Hashable {
    case criminalCode = "Criminal Code"
    case cdsa = "Controlled Drugs and Substances Act"
    case cannabisAct = "Cannabis Act"
    case firearmsAct = "Firearms Act"
    case youthCriminalJusticeAct = "Youth Criminal Justice Act"
    case immigrationAct = "Immigration and Refugee Protection Act"
    case customsAct = "Customs Act"
    case competitionAct = "Competition Act"
    case incomeTexAct = "Income Tax Act"
    case copyrightAct = "Copyright Act"
    case trademarkAct = "Trademarks Act"
    case environmentalProtectionAct = "Canadian Environmental Protection Act"
    case fisheriesAct = "Fisheries Act"
    case speciesAtRiskAct = "Species at Risk Act"
    case wildlifeAct = "Wild Animal and Plant Protection Act"
    case explosivesAct = "Explosives Act"
    case securityOfInfoAct = "Security of Information Act"
    case proceedsOfCrimeAct = "Proceeds of Crime Act"

    var url: URL? {
        let baseURL = "https://laws-lois.justice.gc.ca/eng/acts/"
        let urlString: String
        switch self {
        case .criminalCode:
            urlString = baseURL + "C-46"
        case .cdsa:
            urlString = baseURL + "C-38.8"
        case .cannabisAct:
            urlString = baseURL + "C-24.5"
        case .firearmsAct:
            urlString = baseURL + "F-11.6"
        case .youthCriminalJusticeAct:
            urlString = baseURL + "Y-1.5"
        case .immigrationAct:
            urlString = baseURL + "I-2.5"
        case .customsAct:
            urlString = baseURL + "C-52.6"
        case .competitionAct:
            urlString = baseURL + "C-34"
        case .incomeTexAct:
            urlString = baseURL + "I-3.3"
        case .copyrightAct:
            urlString = baseURL + "C-42"
        case .trademarkAct:
            urlString = baseURL + "T-13"
        case .environmentalProtectionAct:
            urlString = baseURL + "C-15.31"
        case .fisheriesAct:
            urlString = baseURL + "F-14"
        case .speciesAtRiskAct:
            urlString = baseURL + "S-15.3"
        case .wildlifeAct:
            urlString = baseURL + "W-8.5"
        case .explosivesAct:
            urlString = baseURL + "E-17"
        case .securityOfInfoAct:
            urlString = baseURL + "O-5"
        case .proceedsOfCrimeAct:
            urlString = baseURL + "P-24.501"
        }
        return URL(string: urlString)
    }
}

struct Sentence: Hashable {
    let value: Int
    let unit: SentenceUnit
    let type: SentenceType

    var formatted: String {
        let unitStr = value == 1 ? unit.singular : unit.plural
        switch type {
        case .imprisonment:
            return "\(value) \(unitStr)"
        case .fine:
            return "$\(value.formatted()) fine"
        case .lifeImprisonment:
            return "Life imprisonment"
        case .conditionalDischarge:
            return "Conditional discharge"
        case .absoluteDischarge:
            return "Absolute discharge"
        case .probation:
            return "\(value) \(unitStr) probation"
        case .suspended:
            return "Suspended sentence"
        case .summaryMax:
            return "2 years less a day"
        }
    }

    static let life = Sentence(value: 0, unit: .years, type: .lifeImprisonment)
    static let summaryMax = Sentence(value: 2, unit: .years, type: .summaryMax)

    static func years(_ value: Int) -> Sentence {
        Sentence(value: value, unit: .years, type: .imprisonment)
    }

    static func months(_ value: Int) -> Sentence {
        Sentence(value: value, unit: .months, type: .imprisonment)
    }

    static func days(_ value: Int) -> Sentence {
        Sentence(value: value, unit: .days, type: .imprisonment)
    }

    static func fine(_ value: Int) -> Sentence {
        Sentence(value: value, unit: .days, type: .fine)
    }
}

enum SentenceUnit: Hashable {
    case days
    case months
    case years

    var singular: String {
        switch self {
        case .days: return "day"
        case .months: return "month"
        case .years: return "year"
        }
    }

    var plural: String {
        switch self {
        case .days: return "days"
        case .months: return "months"
        case .years: return "years"
        }
    }
}

enum SentenceType: Hashable {
    case imprisonment
    case fine
    case lifeImprisonment
    case conditionalDischarge
    case absoluteDischarge
    case probation
    case suspended
    case summaryMax
}

struct YouthModifier: Hashable {
    let maxYouthSentence: Sentence
    let minAge: Int
    let maxAge: Int
    let notes: String?

    static let standard = YouthModifier(
        maxYouthSentence: .years(3),
        minAge: 12,
        maxAge: 17,
        notes: nil
    )

    static let murder = YouthModifier(
        maxYouthSentence: .years(10),
        minAge: 12,
        maxAge: 17,
        notes: "Maximum 6 years custody, 4 years supervision for youth 14-17. Younger youth: 4 years custody, 3 years supervision."
    )

    static let serious = YouthModifier(
        maxYouthSentence: .years(3),
        minAge: 12,
        maxAge: 17,
        notes: "Intensive rehabilitative custody and supervision may apply."
    )

    static let minor = YouthModifier(
        maxYouthSentence: .years(2),
        minAge: 12,
        maxAge: 17,
        notes: "Often results in extrajudicial measures or sanctions for first-time offenders."
    )
}
