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

    var formattedSection: String {
        "Section \(section)"
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
        }
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
}

struct YouthModifier: Hashable {
    let maxYouthSentence: Sentence
    let minAge: Int
    let maxAge: Int
    let notes: String?
}
