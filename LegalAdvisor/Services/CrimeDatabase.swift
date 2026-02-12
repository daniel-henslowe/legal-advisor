import Foundation

class CrimeDatabase {
    static let shared = CrimeDatabase()

    private(set) var crimes: [Crime] = []

    private init() {
        loadCrimes()
    }

    func crimes(for category: CrimeCategory) -> [Crime] {
        crimes.filter { $0.category == category }
    }

    func search(_ query: String) -> [Crime] {
        guard !query.isEmpty else { return crimes }
        let lowercased = query.lowercased()
        return crimes.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.section.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }

    private func loadCrimes() {
        crimes = [
            // VIOLENT CRIMES
            Crime(
                name: "First Degree Murder",
                section: "235(1)",
                category: .violentCrimes,
                description: "Planned and deliberate killing of another person, or murder of a peace officer, during sexual assault, kidnapping, hijacking, or other specified offenses.",
                minimumSentence: Sentence(value: 25, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: "Maximum 6 years custody, 4 years supervision for youth 14-17. Younger youth: 4 years custody, 3 years supervision."
                ),
                notes: "Mandatory life imprisonment with no parole eligibility for 25 years."
            ),
            Crime(
                name: "Second Degree Murder",
                section: "235(1)",
                category: .violentCrimes,
                description: "Intentional killing that is not planned and deliberate, or does not fall under first degree murder.",
                minimumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 7, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: "Maximum 4 years custody, 3 years supervision."
                ),
                notes: "Life imprisonment with parole eligibility between 10-25 years as set by the court."
            ),
            Crime(
                name: "Manslaughter",
                section: "236",
                category: .violentCrimes,
                description: "Culpable homicide that is not murder or infanticide. Includes killings resulting from unlawful acts or criminal negligence.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: "Maximum 2 years custody, 1 year supervision."
                ),
                notes: "4-year minimum if a firearm is used."
            ),
            Crime(
                name: "Assault",
                section: "266",
                category: .violentCrimes,
                description: "Intentionally applying force to another person without consent, attempting or threatening to apply force, or accosting while openly wearing a weapon.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Summary conviction maximum: 2 years less a day or $5,000 fine."
            ),
            Crime(
                name: "Assault Causing Bodily Harm",
                section: "267(b)",
                category: .violentCrimes,
                description: "Assault that causes bodily harm to the complainant, defined as any hurt or injury that interferes with health or comfort and is more than merely transient or trifling.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Aggravated Assault",
                section: "268",
                category: .violentCrimes,
                description: "Assault that wounds, maims, disfigures, or endangers the life of the complainant.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Robbery",
                section: "344",
                category: .violentCrimes,
                description: "Theft with violence or threats of violence to any person or property.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "4-year minimum if firearm used. 5-year minimum for restricted/prohibited firearm."
            ),
            Crime(
                name: "Uttering Threats",
                section: "264.1",
                category: .violentCrimes,
                description: "Threatening to cause death or bodily harm, burn/destroy/damage property, or kill/poison/injure an animal.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Summary conviction: 2 years less a day."
            ),
            Crime(
                name: "Criminal Harassment",
                section: "264",
                category: .violentCrimes,
                description: "Repeatedly following, communicating with, watching, or threatening conduct that causes the victim to reasonably fear for their safety.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Kidnapping",
                section: "279(1)",
                category: .violentCrimes,
                description: "Confining, imprisoning, or forcibly seizing another person against their will.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "5-year minimum if firearm used."
            ),

            // PROPERTY OFFENSES
            Crime(
                name: "Theft Under $5,000",
                section: "334(b)",
                category: .propertyOffenses,
                description: "Taking property valued under $5,000 without consent with intent to deprive the owner.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: "Often results in extrajudicial measures for first-time youth offenders."
                ),
                notes: "Hybrid offense. Summary: 2 years less a day or $5,000 fine."
            ),
            Crime(
                name: "Theft Over $5,000",
                section: "334(a)",
                category: .propertyOffenses,
                description: "Taking property valued over $5,000 without consent with intent to deprive the owner.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Indictable offense only."
            ),
            Crime(
                name: "Break and Enter - Dwelling",
                section: "348(1)(d)",
                category: .propertyOffenses,
                description: "Breaking and entering a dwelling house with intent to commit an indictable offense.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Home invasion cases typically result in significant sentences."
            ),
            Crime(
                name: "Break and Enter - Non-Dwelling",
                section: "348(1)(e)",
                category: .propertyOffenses,
                description: "Breaking and entering a place other than a dwelling house with intent to commit an indictable offense.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Mischief Under $5,000",
                section: "430(4)",
                category: .propertyOffenses,
                description: "Willfully destroying or damaging property, rendering it dangerous or useless, or obstructing use of property.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Summary: 2 years less a day or $5,000 fine."
            ),
            Crime(
                name: "Mischief Over $5,000",
                section: "430(3)",
                category: .propertyOffenses,
                description: "Willfully destroying or damaging property over $5,000 in value.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Possession of Stolen Property Under $5,000",
                section: "354(1)(b)",
                category: .propertyOffenses,
                description: "Possessing property knowing it was obtained by crime, where value is under $5,000.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Possession of Stolen Property Over $5,000",
                section: "354(1)(a)",
                category: .propertyOffenses,
                description: "Possessing property knowing it was obtained by crime, where value exceeds $5,000.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Motor Vehicle Theft",
                section: "333.1",
                category: .propertyOffenses,
                description: "Theft of a motor vehicle.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "6-month minimum for third or subsequent offense."
            ),
            Crime(
                name: "Arson - Disregard for Human Life",
                section: "433",
                category: .propertyOffenses,
                description: "Intentionally setting fire to property knowing or reckless as to whether it is inhabited.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),

            // DRUG OFFENSES
            Crime(
                name: "Possession of Schedule I Substance",
                section: "CDSA 4(1)",
                category: .drugOffenses,
                description: "Possession of Schedule I controlled substances (cocaine, heroin, fentanyl, methamphetamine, etc.).",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 7, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: "Drug treatment courts often available."
                ),
                notes: "Summary: 1 year or $1,000 fine for first offense."
            ),
            Crime(
                name: "Possession of Schedule II Substance (Cannabis over limit)",
                section: "CDSA 4(1)",
                category: .drugOffenses,
                description: "Possession of cannabis exceeding legal limits under the Cannabis Act.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Adults can legally possess up to 30g in public."
            ),
            Crime(
                name: "Trafficking Schedule I Substance",
                section: "CDSA 5(1)",
                category: .drugOffenses,
                description: "Selling, giving, administering, transporting, or delivering Schedule I substances.",
                minimumSentence: Sentence(value: 1, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "2-year minimum if certain aggravating factors present."
            ),
            Crime(
                name: "Trafficking Schedule II Substance",
                section: "CDSA 5(1)",
                category: .drugOffenses,
                description: "Trafficking cannabis or cannabis derivatives.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "1-year minimum if aggravating factors present."
            ),
            Crime(
                name: "Production of Schedule I Substance",
                section: "CDSA 7(1)",
                category: .drugOffenses,
                description: "Manufacturing, synthesizing, or producing Schedule I controlled substances.",
                minimumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "3-year minimum if aggravating factors present."
            ),
            Crime(
                name: "Importing/Exporting Schedule I Substance",
                section: "CDSA 6(1)",
                category: .drugOffenses,
                description: "Importing or exporting Schedule I controlled substances.",
                minimumSentence: Sentence(value: 1, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "2-year minimum for amounts exceeding 1kg."
            ),

            // FINANCIAL CRIMES
            Crime(
                name: "Fraud Under $5,000",
                section: "380(1)(b)",
                category: .financialCrimes,
                description: "Defrauding the public or any person of property, money, or services valued under $5,000.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Fraud Over $5,000",
                section: "380(1)(a)",
                category: .financialCrimes,
                description: "Defrauding the public or any person of property, money, or services valued over $5,000.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "2-year minimum if value exceeds $1 million."
            ),
            Crime(
                name: "Identity Theft",
                section: "402.2",
                category: .financialCrimes,
                description: "Obtaining or possessing another person's identity information with intent to commit an indictable offense.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Identity Fraud",
                section: "403",
                category: .financialCrimes,
                description: "Fraudulently personating another person to gain advantage or cause disadvantage.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Forgery",
                section: "366",
                category: .financialCrimes,
                description: "Making a false document with intent that it be used as genuine.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Uttering Forged Document",
                section: "368",
                category: .financialCrimes,
                description: "Knowingly using, dealing with, or acting on a forged document as if it were genuine.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Money Laundering",
                section: "462.31",
                category: .financialCrimes,
                description: "Dealing with property or proceeds obtained from designated offenses to conceal their illicit origin.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Bribery of Officials",
                section: "119",
                category: .financialCrimes,
                description: "Giving or offering a bribe to a judicial officer, member of Parliament, or government official.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),

            // SEXUAL OFFENSES
            Crime(
                name: "Sexual Assault",
                section: "271",
                category: .sexualOffenses,
                description: "Sexual touching without consent. Includes any unwanted sexual contact.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Summary: 2 years less a day. 1-year minimum if victim under 16."
            ),
            Crime(
                name: "Sexual Assault with Weapon/Threats/Bodily Harm",
                section: "272",
                category: .sexualOffenses,
                description: "Sexual assault while carrying, using, or threatening to use a weapon, or causing bodily harm.",
                minimumSentence: Sentence(value: 4, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "5-year minimum if firearm used. 7-year minimum for restricted firearm."
            ),
            Crime(
                name: "Aggravated Sexual Assault",
                section: "273",
                category: .sexualOffenses,
                description: "Sexual assault that wounds, maims, disfigures, or endangers the life of the victim.",
                minimumSentence: Sentence(value: 4, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "5-year minimum if firearm used."
            ),
            Crime(
                name: "Sexual Interference",
                section: "151",
                category: .sexualOffenses,
                description: "Touching a person under 16 for a sexual purpose.",
                minimumSentence: Sentence(value: 1, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "90-day minimum on summary conviction."
            ),
            Crime(
                name: "Invitation to Sexual Touching",
                section: "152",
                category: .sexualOffenses,
                description: "Inviting, counselling, or inciting a person under 16 to touch for a sexual purpose.",
                minimumSentence: Sentence(value: 1, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "90-day minimum on summary conviction."
            ),
            Crime(
                name: "Child Pornography - Possession",
                section: "163.1(4)",
                category: .sexualOffenses,
                description: "Possessing child pornography.",
                minimumSentence: Sentence(value: 1, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "6-month minimum on summary conviction."
            ),
            Crime(
                name: "Child Pornography - Distribution",
                section: "163.1(3)",
                category: .sexualOffenses,
                description: "Distributing, transmitting, selling, or making available child pornography.",
                minimumSentence: Sentence(value: 1, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "6-month minimum on summary conviction."
            ),
            Crime(
                name: "Voyeurism",
                section: "162",
                category: .sexualOffenses,
                description: "Secretly observing or recording a person in circumstances where privacy is expected.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),

            // PUBLIC ORDER
            Crime(
                name: "Possession of Prohibited Weapon",
                section: "91(2)",
                category: .publicOrder,
                description: "Possessing a prohibited weapon without authority.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Possession of Firearm - Unauthorized",
                section: "91(1)",
                category: .publicOrder,
                description: "Possessing a firearm without a license or registration.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Possession of Restricted/Prohibited Firearm with Ammo",
                section: "95",
                category: .publicOrder,
                description: "Possessing a loaded restricted or prohibited firearm, or with accessible ammunition.",
                minimumSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "3-year minimum for first offense, 5 years for subsequent."
            ),
            Crime(
                name: "Weapons Trafficking",
                section: "99",
                category: .publicOrder,
                description: "Trafficking in firearms, prohibited weapons, or prohibited devices.",
                minimumSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "5-year minimum for subsequent offenses."
            ),
            Crime(
                name: "Causing a Disturbance",
                section: "175(1)",
                category: .publicOrder,
                description: "Fighting, screaming, shouting, swearing, or being drunk in a public place.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .months, type: .fine),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 0, unit: .months, type: .absoluteDischarge),
                    minAge: 12,
                    maxAge: 17,
                    notes: "Often results in warnings or extrajudicial measures."
                ),
                notes: "Summary conviction only. Fine up to $5,000."
            ),
            Crime(
                name: "Unlawful Assembly",
                section: "63",
                category: .publicOrder,
                description: "Assembly of three or more persons who cause reasonable fear of a breach of the peace.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .months, type: .fine),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 0, unit: .months, type: .absoluteDischarge),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Summary offense. Fine up to $5,000."
            ),
            Crime(
                name: "Riot",
                section: "65",
                category: .publicOrder,
                description: "Unlawful assembly that has begun to disturb the peace tumultuously.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),

            // TRAFFIC OFFENSES
            Crime(
                name: "Impaired Driving",
                section: "320.14",
                category: .trafficOffenses,
                description: "Operating a motor vehicle while impaired by alcohol or drugs, or with blood alcohol over 80mg/100ml.",
                minimumSentence: Sentence(value: 1000, unit: .days, type: .fine),
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "$1,000 minimum fine first offense. 30-day minimum jail for second. 120-day minimum for third."
            ),
            Crime(
                name: "Impaired Driving Causing Bodily Harm",
                section: "320.14(2)",
                category: .trafficOffenses,
                description: "Impaired operation of a motor vehicle causing bodily harm to another person.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Impaired Driving Causing Death",
                section: "320.14(3)",
                category: .trafficOffenses,
                description: "Impaired operation of a motor vehicle causing the death of another person.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Dangerous Operation",
                section: "320.13",
                category: .trafficOffenses,
                description: "Operating a motor vehicle in a manner dangerous to the public, having regard to all circumstances.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Dangerous Operation Causing Bodily Harm",
                section: "320.13(2)",
                category: .trafficOffenses,
                description: "Dangerous operation of a motor vehicle causing bodily harm to another person.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 14, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Dangerous Operation Causing Death",
                section: "320.13(3)",
                category: .trafficOffenses,
                description: "Dangerous operation of a motor vehicle causing the death of another person.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 0, unit: .years, type: .lifeImprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Failure to Stop at Accident",
                section: "320.16",
                category: .trafficOffenses,
                description: "Failing to stop after being involved in an accident to give identity and offer assistance.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: "Life imprisonment if death results and knowledge of injury."
            ),
            Crime(
                name: "Flight from Police",
                section: "320.17",
                category: .trafficOffenses,
                description: "Operating a motor vehicle while being pursued by a peace officer and failing to stop without reasonable excuse.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),

            // CYBER CRIMES
            Crime(
                name: "Unauthorized Use of Computer",
                section: "342.1",
                category: .cyberCrimes,
                description: "Fraudulently obtaining computer services or intercepting computer functions.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Mischief in Relation to Computer Data",
                section: "430(1.1)",
                category: .cyberCrimes,
                description: "Destroying, altering, or rendering meaningless computer data, or denying access to authorized users.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Possession of Device to Obtain Computer Service",
                section: "342.2",
                category: .cyberCrimes,
                description: "Possessing instruments or devices for unauthorized use of computer systems.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Publication of Intimate Images Without Consent",
                section: "162.1",
                category: .cyberCrimes,
                description: "Publishing, distributing, or making available an intimate image without consent.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Interception of Private Communications",
                section: "184",
                category: .cyberCrimes,
                description: "Willfully intercepting a private communication using an electromagnetic, acoustic, or other device.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 5, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 2, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
            Crime(
                name: "Credit Card Fraud",
                section: "342(1)",
                category: .cyberCrimes,
                description: "Using, possessing, or trafficking in credit card data without authorization.",
                minimumSentence: nil,
                maximumSentence: Sentence(value: 10, unit: .years, type: .imprisonment),
                youthModifier: YouthModifier(
                    maxYouthSentence: Sentence(value: 3, unit: .years, type: .imprisonment),
                    minAge: 12,
                    maxAge: 17,
                    notes: nil
                ),
                notes: nil
            ),
        ]
    }
}
