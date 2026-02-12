import SwiftUI

enum CrimeCategory: String, CaseIterable, Identifiable {
    case violentCrimes = "Violent Crimes"
    case propertyOffenses = "Property Offenses"
    case drugOffenses = "Drug Offenses"
    case financialCrimes = "Financial Crimes"
    case sexualOffenses = "Sexual Offenses"
    case publicOrder = "Public Order"
    case trafficOffenses = "Traffic Offenses"
    case cyberCrimes = "Cyber Crimes"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .violentCrimes: return "flame.fill"
        case .propertyOffenses: return "house.fill"
        case .drugOffenses: return "pills.fill"
        case .financialCrimes: return "dollarsign.circle.fill"
        case .sexualOffenses: return "exclamationmark.shield.fill"
        case .publicOrder: return "building.columns.fill"
        case .trafficOffenses: return "car.fill"
        case .cyberCrimes: return "desktopcomputer"
        }
    }

    var color: Color {
        switch self {
        case .violentCrimes: return Theme.Colors.violentCrime
        case .propertyOffenses: return Theme.Colors.propertyCrime
        case .drugOffenses: return Theme.Colors.drugOffense
        case .financialCrimes: return Theme.Colors.financialCrime
        case .sexualOffenses: return Theme.Colors.sexualOffense
        case .publicOrder: return Theme.Colors.publicOrder
        case .trafficOffenses: return Theme.Colors.trafficOffense
        case .cyberCrimes: return Theme.Colors.cyberCrime
        }
    }

    var description: String {
        switch self {
        case .violentCrimes:
            return "Assault, homicide, robbery, and other violent offenses"
        case .propertyOffenses:
            return "Theft, break and enter, mischief, and property damage"
        case .drugOffenses:
            return "Possession, trafficking, and production of controlled substances"
        case .financialCrimes:
            return "Fraud, embezzlement, money laundering, and forgery"
        case .sexualOffenses:
            return "Sexual assault and related offenses"
        case .publicOrder:
            return "Weapons, public disturbance, and regulatory offenses"
        case .trafficOffenses:
            return "Impaired driving and dangerous operation"
        case .cyberCrimes:
            return "Computer-related offenses and unauthorized access"
        }
    }
}
