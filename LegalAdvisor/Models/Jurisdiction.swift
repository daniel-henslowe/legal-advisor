import Foundation

enum Jurisdiction: String, CaseIterable, Identifiable {
    case federal = "Federal"
    case alberta = "Alberta"
    case britishColumbia = "British Columbia"
    case manitoba = "Manitoba"
    case newBrunswick = "New Brunswick"
    case newfoundland = "Newfoundland and Labrador"
    case northwestTerritories = "Northwest Territories"
    case novaScotia = "Nova Scotia"
    case nunavut = "Nunavut"
    case ontario = "Ontario"
    case pei = "Prince Edward Island"
    case quebec = "Quebec"
    case saskatchewan = "Saskatchewan"
    case yukon = "Yukon"

    var id: String { rawValue }

    var abbreviation: String {
        switch self {
        case .federal: return "FED"
        case .alberta: return "AB"
        case .britishColumbia: return "BC"
        case .manitoba: return "MB"
        case .newBrunswick: return "NB"
        case .newfoundland: return "NL"
        case .northwestTerritories: return "NT"
        case .novaScotia: return "NS"
        case .nunavut: return "NU"
        case .ontario: return "ON"
        case .pei: return "PE"
        case .quebec: return "QC"
        case .saskatchewan: return "SK"
        case .yukon: return "YT"
        }
    }

    var courts: [String] {
        switch self {
        case .federal:
            return ["Supreme Court of Canada", "Federal Court of Appeal", "Federal Court"]
        default:
            return ["Provincial Superior Court", "Provincial Court", "Court of Appeal"]
        }
    }
}

struct AgeCategory {
    let name: String
    let minAge: Int
    let maxAge: Int
    let sentencingNotes: String

    static let youth = AgeCategory(
        name: "Youth",
        minAge: 12,
        maxAge: 17,
        sentencingNotes: "Subject to Youth Criminal Justice Act. Maximum sentences are significantly reduced."
    )

    static let adult = AgeCategory(
        name: "Adult",
        minAge: 18,
        maxAge: 999,
        sentencingNotes: "Full adult sentences apply under the Criminal Code."
    )

    static func category(for age: Int) -> AgeCategory {
        if age >= 12 && age <= 17 {
            return .youth
        }
        return .adult
    }
}
