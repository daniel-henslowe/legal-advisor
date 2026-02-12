import SwiftUI

enum CrimeCategory: String, CaseIterable, Identifiable {
    case violentCrimes = "Violent Crimes"
    case homicide = "Homicide"
    case sexualOffenses = "Sexual Offenses"
    case propertyOffenses = "Property Offenses"
    case drugOffenses = "Drug Offenses"
    case financialCrimes = "Financial Crimes"
    case cyberCrimes = "Cyber Crimes"
    case weaponsFirearms = "Weapons & Firearms"
    case adminJustice = "Administration of Justice"
    case publicOrder = "Public Order"
    case terrorism = "Terrorism & National Security"
    case trafficOffenses = "Traffic Offenses"
    case childrenOffenses = "Offenses Against Children"
    case moralOffenses = "Moral & Decency Offenses"
    case environmentalOffenses = "Environmental Offenses"
    case organizationsOffenses = "Criminal Organizations"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .violentCrimes: return "flame.fill"
        case .homicide: return "person.crop.circle.badge.xmark"
        case .sexualOffenses: return "exclamationmark.shield.fill"
        case .propertyOffenses: return "house.fill"
        case .drugOffenses: return "pills.fill"
        case .financialCrimes: return "dollarsign.circle.fill"
        case .cyberCrimes: return "desktopcomputer"
        case .weaponsFirearms: return "scope"
        case .adminJustice: return "building.columns.fill"
        case .publicOrder: return "person.3.fill"
        case .terrorism: return "shield.slash.fill"
        case .trafficOffenses: return "car.fill"
        case .childrenOffenses: return "figure.and.child.holdinghands"
        case .moralOffenses: return "eye.slash.fill"
        case .environmentalOffenses: return "leaf.fill"
        case .organizationsOffenses: return "person.3.sequence.fill"
        }
    }

    var color: Color {
        switch self {
        case .violentCrimes: return Color(red: 0.9, green: 0.3, blue: 0.3)
        case .homicide: return Color(red: 0.6, green: 0.1, blue: 0.1)
        case .sexualOffenses: return Color(red: 0.9, green: 0.5, blue: 0.3)
        case .propertyOffenses: return Color(red: 0.3, green: 0.6, blue: 0.9)
        case .drugOffenses: return Color(red: 0.6, green: 0.4, blue: 0.8)
        case .financialCrimes: return Color(red: 0.3, green: 0.8, blue: 0.5)
        case .cyberCrimes: return Color(red: 0.4, green: 0.8, blue: 0.8)
        case .weaponsFirearms: return Color(red: 0.5, green: 0.5, blue: 0.5)
        case .adminJustice: return Color(red: 0.5, green: 0.7, blue: 0.9)
        case .publicOrder: return Color(red: 0.7, green: 0.5, blue: 0.7)
        case .terrorism: return Color(red: 0.8, green: 0.2, blue: 0.4)
        case .trafficOffenses: return Color(red: 0.8, green: 0.7, blue: 0.3)
        case .childrenOffenses: return Color(red: 0.95, green: 0.6, blue: 0.7)
        case .moralOffenses: return Color(red: 0.6, green: 0.5, blue: 0.6)
        case .environmentalOffenses: return Color(red: 0.2, green: 0.7, blue: 0.4)
        case .organizationsOffenses: return Color(red: 0.4, green: 0.3, blue: 0.5)
        }
    }

    var description: String {
        switch self {
        case .violentCrimes:
            return "Assault, robbery, threats, harassment, and other violent offenses"
        case .homicide:
            return "Murder, manslaughter, infanticide, and causing death"
        case .sexualOffenses:
            return "Sexual assault, exploitation, and related offenses"
        case .propertyOffenses:
            return "Theft, break and enter, mischief, and property damage"
        case .drugOffenses:
            return "Possession, trafficking, production of controlled substances"
        case .financialCrimes:
            return "Fraud, embezzlement, money laundering, forgery, tax evasion"
        case .cyberCrimes:
            return "Computer offenses, hacking, identity theft, online fraud"
        case .weaponsFirearms:
            return "Firearm offenses, prohibited weapons, trafficking"
        case .adminJustice:
            return "Obstruction, perjury, breach of conditions, escape"
        case .publicOrder:
            return "Riots, unlawful assembly, hate crimes, disturbing peace"
        case .terrorism:
            return "Terrorist activities, financing, participation in groups"
        case .trafficOffenses:
            return "Impaired driving, dangerous operation, flight from police"
        case .childrenOffenses:
            return "Child abuse, abandonment, exploitation, luring"
        case .moralOffenses:
            return "Obscenity, prostitution-related, indecent acts"
        case .environmentalOffenses:
            return "Pollution, wildlife crimes, environmental destruction"
        case .organizationsOffenses:
            return "Gang participation, organized crime, criminal conspiracy"
        }
    }
}
