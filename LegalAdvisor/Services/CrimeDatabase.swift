import Foundation

class CrimeDatabase {
    static let shared = CrimeDatabase()

    let dataVersion = "2.0.0"
    let lastUpdated = "2025-02-12"
    let sourceNote = "Based on Criminal Code (R.S.C., 1985, c. C-46), CDSA, and related federal statutes"

    private(set) var crimes: [Crime] = []

    private init() {
        loadAllCrimes()
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

    private func loadAllCrimes() {
        crimes = []
        crimes.append(contentsOf: homicideOffenses)
        crimes.append(contentsOf: violentCrimes)
        crimes.append(contentsOf: sexualOffenses)
        crimes.append(contentsOf: childrenOffenses)
        crimes.append(contentsOf: propertyOffenses)
        crimes.append(contentsOf: drugOffenses)
        crimes.append(contentsOf: financialCrimes)
        crimes.append(contentsOf: cyberCrimes)
        crimes.append(contentsOf: weaponsFirearms)
        crimes.append(contentsOf: adminJustice)
        crimes.append(contentsOf: publicOrder)
        crimes.append(contentsOf: terrorism)
        crimes.append(contentsOf: trafficOffenses)
        crimes.append(contentsOf: moralOffenses)
        crimes.append(contentsOf: environmentalOffenses)
        crimes.append(contentsOf: organizationsOffenses)
    }

    // MARK: - Homicide Offenses
    private var homicideOffenses: [Crime] {
        [
            Crime(name: "First Degree Murder", section: "235(1)", category: .homicide,
                  description: "Planned and deliberate killing; murder of peace officer, during sexual assault, kidnapping, hijacking, criminal harassment, terrorist activity, intimidation, or involving explosives.",
                  minimumSentence: .years(25), maximumSentence: .life, youthModifier: .murder,
                  notes: "Mandatory life with no parole for 25 years. Consecutive periods possible for multiple murders."),

            Crime(name: "Second Degree Murder", section: "235(1)", category: .homicide,
                  description: "Intentional killing that is not planned and deliberate or does not meet first degree criteria.",
                  minimumSentence: .years(10), maximumSentence: .life, youthModifier: .murder,
                  notes: "Life imprisonment with parole eligibility between 10-25 years as set by court."),

            Crime(name: "Manslaughter", section: "236", category: .homicide,
                  description: "Culpable homicide that is not murder or infanticide; includes killings from unlawful acts or criminal negligence.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "4-year minimum if firearm used. No minimum otherwise."),

            Crime(name: "Infanticide", section: "237", category: .homicide,
                  description: "Female causes death of her newly-born child while mind disturbed from effects of giving birth or lactation.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Criminal Negligence Causing Death", section: "220", category: .homicide,
                  description: "Causing death by doing or omitting to do anything showing wanton or reckless disregard for lives or safety of others.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "4-year minimum if firearm used."),

            Crime(name: "Causing Death by Criminal Negligence (Street Racing)", section: "249.2", category: .homicide,
                  description: "Causing death while street racing or in flight from police.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Accessory After the Fact to Murder", section: "240", category: .homicide,
                  description: "Knowingly receiving, comforting, or assisting anyone who has committed murder to escape.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Attempted Murder", section: "239", category: .homicide,
                  description: "Attempting by any means to commit murder.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "4-year minimum if firearm used. 5-year if restricted/prohibited firearm. 7-year if for criminal organization."),

            Crime(name: "Counselling Murder (Not Committed)", section: "464(a)", category: .homicide,
                  description: "Counselling another person to commit murder where murder is not committed.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Conspiracy to Commit Murder", section: "465(1)(a)", category: .homicide,
                  description: "Agreeing with another person to commit murder.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Killing Unborn Child in Act of Birth", section: "238", category: .homicide,
                  description: "Causing the death of a child that has not become a human being in such manner that would be murder if the child were a human being.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Neglect to Obtain Assistance in Childbirth", section: "242", category: .homicide,
                  description: "Female being with child fails to obtain assistance in childbirth and child permanently injured or dies.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .minor, notes: nil),
        ]
    }

    // MARK: - Violent Crimes
    private var violentCrimes: [Crime] {
        [
            Crime(name: "Assault", section: "266", category: .violentCrimes,
                  description: "Intentionally applying force to another person without consent, attempting or threatening to apply force, or accosting while openly wearing a weapon.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .minor,
                  notes: "Summary: 2 years less a day or $5,000 fine."),

            Crime(name: "Assault with a Weapon", section: "267(a)", category: .violentCrimes,
                  description: "Committing assault while carrying, using, or threatening to use a weapon or imitation.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Assault Causing Bodily Harm", section: "267(b)", category: .violentCrimes,
                  description: "Assault causing bodily harm that interferes with health or comfort and is more than transient or trifling.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Aggravated Assault", section: "268", category: .violentCrimes,
                  description: "Assault that wounds, maims, disfigures, or endangers the life of the complainant.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Unlawfully Causing Bodily Harm", section: "269", category: .violentCrimes,
                  description: "Unlawfully causing bodily harm to any person.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Assault Peace Officer", section: "270(1)", category: .violentCrimes,
                  description: "Assaulting a public officer or peace officer engaged in execution of duty.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Assault Peace Officer with Weapon/Causing Bodily Harm", section: "270.01", category: .violentCrimes,
                  description: "Assaulting peace officer with weapon or causing bodily harm.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Aggravated Assault Peace Officer", section: "270.02", category: .violentCrimes,
                  description: "Aggravated assault against a peace officer.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Disarming Peace Officer", section: "270.1", category: .violentCrimes,
                  description: "Taking or attempting to take a weapon from a peace officer.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Robbery", section: "344", category: .violentCrimes,
                  description: "Theft with violence or threats of violence to any person or property.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "4-year min if firearm. 5-year min restricted/prohibited. 7-year min if for criminal org."),

            Crime(name: "Extortion", section: "346", category: .violentCrimes,
                  description: "Inducing or attempting to induce any person to do anything by threats, accusations, menaces, or violence.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "4-year minimum if firearm used."),

            Crime(name: "Uttering Threats - Death or Bodily Harm", section: "264.1(1)(a)", category: .violentCrimes,
                  description: "Threatening to cause death or bodily harm to any person.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .minor, notes: nil),

            Crime(name: "Uttering Threats - Property Damage", section: "264.1(1)(b)", category: .violentCrimes,
                  description: "Threatening to burn, destroy, or damage property.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Uttering Threats - Kill/Harm Animal", section: "264.1(1)(c)", category: .violentCrimes,
                  description: "Threatening to kill, poison, or injure an animal or bird belonging to another person.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Criminal Harassment (Stalking)", section: "264", category: .violentCrimes,
                  description: "Repeatedly following, communicating with, watching, or threatening conduct causing victim to reasonably fear for safety.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Intimidation", section: "423", category: .violentCrimes,
                  description: "Using violence, threats, or persistent following to compel a person to abstain from doing lawful acts.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Kidnapping", section: "279(1)", category: .violentCrimes,
                  description: "Confining, imprisoning, or forcibly seizing another person without lawful authority.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "5-year minimum if firearm used."),

            Crime(name: "Forcible Confinement", section: "279(2)", category: .violentCrimes,
                  description: "Confining, imprisoning, or forcibly seizing another person without kidnapping elements.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Hostage Taking", section: "279.1", category: .violentCrimes,
                  description: "Confining, imprisoning, or seizing a person and threatening death, bodily harm, or continued confinement to compel third party to act.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "4-year minimum if firearm used."),

            Crime(name: "Trafficking in Persons", section: "279.01", category: .violentCrimes,
                  description: "Recruiting, transporting, harbouring, or exercising control over a person for exploitation.",
                  minimumSentence: .years(4), maximumSentence: .life, youthModifier: .standard,
                  notes: "5-year minimum if kidnapping, aggravated assault, or sexual assault involved."),

            Crime(name: "Trafficking in Persons Under 18", section: "279.011", category: .violentCrimes,
                  description: "Human trafficking where victim is under 18 years of age.",
                  minimumSentence: .years(5), maximumSentence: .life, youthModifier: .standard,
                  notes: "6-year minimum if kidnapping, aggravated assault, or sexual assault involved."),

            Crime(name: "Material Benefit from Trafficking", section: "279.02", category: .violentCrimes,
                  description: "Receiving financial or other material benefit from trafficking in persons.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "2-year minimum if victim under 18."),

            Crime(name: "Withholding/Destroying Documents for Trafficking", section: "279.03", category: .violentCrimes,
                  description: "Concealing, removing, withholding, or destroying travel or identity documents to facilitate trafficking.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "1-year minimum if victim under 18."),

            Crime(name: "Torture", section: "269.1", category: .violentCrimes,
                  description: "Official or person acting at instigation of official intentionally inflicting severe pain or suffering for purposes including obtaining information, punishment, intimidation, or discrimination.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Overcoming Resistance to Commission of Offense", section: "246", category: .violentCrimes,
                  description: "Administering or causing to be administered any drug, matter, or thing with intent to stupefy or overpower to enable commission of indictable offense.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Criminal Negligence Causing Bodily Harm", section: "221", category: .violentCrimes,
                  description: "Causing bodily harm by doing or omitting anything showing wanton or reckless disregard for lives or safety of others.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Trap Likely to Cause Bodily Harm", section: "247", category: .violentCrimes,
                  description: "Setting or placing a trap, device, or thing likely to cause death or bodily harm.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "10 years if bodily harm results. 14 years if death results."),

            Crime(name: "Pointing a Firearm", section: "87", category: .violentCrimes,
                  description: "Pointing a firearm at another person without lawful excuse.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Administering Noxious Thing", section: "245", category: .violentCrimes,
                  description: "Administering or causing to be taken any poison or destructive/noxious thing with intent to endanger life, cause bodily harm, or aggrieve/annoy.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "2 years if only intent to aggrieve or annoy."),

            Crime(name: "Assault in Aircraft", section: "7(2)", category: .violentCrimes,
                  description: "Committing assault aboard an aircraft in flight.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),
        ]
    }

    // MARK: - Sexual Offenses
    private var sexualOffenses: [Crime] {
        [
            Crime(name: "Sexual Assault", section: "271", category: .sexualOffenses,
                  description: "Sexual touching without consent; any unwanted sexual contact.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "Summary: 2 years less a day. 1-year minimum if victim under 16."),

            Crime(name: "Sexual Assault with Weapon/Threats/Bodily Harm", section: "272", category: .sexualOffenses,
                  description: "Sexual assault while carrying, using, or threatening to use a weapon, or causing bodily harm, or with multiple perpetrators.",
                  minimumSentence: .years(4), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "5-year min if firearm. 7-year min if restricted/prohibited firearm or for criminal org."),

            Crime(name: "Aggravated Sexual Assault", section: "273", category: .sexualOffenses,
                  description: "Sexual assault that wounds, maims, disfigures, or endangers the life of the victim.",
                  minimumSentence: .years(4), maximumSentence: .life, youthModifier: .standard,
                  notes: "5-year min if firearm. 7-year min if restricted/prohibited firearm or for criminal org."),

            Crime(name: "Sexual Interference", section: "151", category: .sexualOffenses,
                  description: "Touching a person under 16 years for a sexual purpose.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "90-day minimum on summary conviction."),

            Crime(name: "Invitation to Sexual Touching", section: "152", category: .sexualOffenses,
                  description: "Inviting, counselling, or inciting a person under 16 to touch for a sexual purpose.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "90-day minimum on summary conviction."),

            Crime(name: "Sexual Exploitation", section: "153", category: .sexualOffenses,
                  description: "Person in position of trust/authority touching young person (16-17) for sexual purpose or inviting sexual touching.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "90-day minimum on summary conviction."),

            Crime(name: "Sexual Exploitation of Person with Disability", section: "153.1", category: .sexualOffenses,
                  description: "Person in position of trust/dependency sexually exploiting person with mental or physical disability.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Incest", section: "155", category: .sexualOffenses,
                  description: "Sexual intercourse with a blood relative (parent, child, sibling, grandparent, grandchild).",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "5-year minimum if complainant under 16."),

            Crime(name: "Bestiality", section: "160(1)", category: .sexualOffenses,
                  description: "Committing bestiality.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "1-year minimum if victim/participant under 16."),

            Crime(name: "Compelling Person to Commit Bestiality", section: "160(2)", category: .sexualOffenses,
                  description: "Compelling another person to commit bestiality.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "1-year minimum if victim under 16."),

            Crime(name: "Bestiality in Presence of Child", section: "160(3)", category: .sexualOffenses,
                  description: "Committing bestiality in presence of person under 16 or inciting person under 16 to commit bestiality.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Voyeurism", section: "162(1)", category: .sexualOffenses,
                  description: "Secretly observing or recording a person in circumstances where privacy is expected, for sexual purpose.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Publication of Intimate Images Without Consent", section: "162.1", category: .sexualOffenses,
                  description: "Publishing, distributing, transmitting, or making available an intimate image without consent.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Indecent Exposure", section: "173(2)", category: .sexualOffenses,
                  description: "Exposing genitals to person under 16 for sexual purpose.",
                  minimumSentence: .months(6), maximumSentence: .years(2), youthModifier: .minor,
                  notes: "90-day minimum on summary conviction."),

            Crime(name: "Anal Intercourse Under 18", section: "159", category: .sexualOffenses,
                  description: "Engaging in anal intercourse with person under 18 (exceptions for married couples and those 18+ in private).",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Parent/Guardian Procuring Sexual Activity", section: "170", category: .sexualOffenses,
                  description: "Parent or guardian procuring person under 18 to engage in sexual activity prohibited under the Criminal Code.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Householder Permitting Sexual Activity", section: "171", category: .sexualOffenses,
                  description: "Owner/occupier knowingly permitting person under 18 to engage in prohibited sexual activity on premises.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "1-year minimum if victim under 16, 90-day minimum on summary."),
        ]
    }

    // MARK: - Offenses Against Children
    private var childrenOffenses: [Crime] {
        [
            Crime(name: "Luring a Child", section: "172.1", category: .childrenOffenses,
                  description: "Using computer system to communicate with person under 18 for purpose of facilitating sexual offense.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "6-month minimum on summary. Higher minimum if victim under 16."),

            Crime(name: "Agreement/Arrangement - Sexual Offense Against Child", section: "172.2", category: .childrenOffenses,
                  description: "Making agreement or arrangement by telecommunication to commit sexual offense against a child.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "6-month minimum on summary conviction."),

            Crime(name: "Child Pornography - Making", section: "163.1(2)", category: .childrenOffenses,
                  description: "Making, printing, publishing, or possessing for purpose of publication any child pornography.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "6-month minimum on summary conviction."),

            Crime(name: "Child Pornography - Distribution", section: "163.1(3)", category: .childrenOffenses,
                  description: "Distributing, transmitting, selling, importing, exporting, or making available child pornography.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "6-month minimum on summary conviction."),

            Crime(name: "Child Pornography - Possession", section: "163.1(4)", category: .childrenOffenses,
                  description: "Possessing child pornography.",
                  minimumSentence: .years(1), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "6-month minimum on summary conviction."),

            Crime(name: "Child Pornography - Accessing", section: "163.1(4.1)", category: .childrenOffenses,
                  description: "Accessing child pornography.",
                  minimumSentence: .years(1), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "6-month minimum on summary conviction."),

            Crime(name: "Abandoning Child Under 10", section: "218", category: .childrenOffenses,
                  description: "Unlawfully abandoning or exposing a child under 10 so life is endangered or health permanently injured.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Failure to Provide Necessaries - Child", section: "215(2)", category: .childrenOffenses,
                  description: "Parent, guardian, or head of family failing to provide necessaries of life to child under 16.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Abduction of Person Under 16", section: "280", category: .childrenOffenses,
                  description: "Taking or causing to be taken an unmarried person under 16 out of possession of parent/guardian without consent.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Abduction of Person Under 14", section: "281", category: .childrenOffenses,
                  description: "Taking, enticing away, concealing, detaining, receiving, or harbouring person under 14 with intent to deprive parent/guardian.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Abduction in Contravention of Custody Order", section: "282", category: .childrenOffenses,
                  description: "Taking, enticing, concealing, detaining, or harbouring person under 14 in contravention of custody order with intent to deprive.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Abduction - No Custody Order", section: "283", category: .childrenOffenses,
                  description: "Taking, enticing away, concealing, detaining, or harbouring a child under 14 by parent/guardian with intent to deprive other parent/guardian.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Corrupting Children", section: "172", category: .childrenOffenses,
                  description: "In the home of a child, participating in adultery or sexual immorality, or indulging in habitual drunkenness or other vice, thereby endangering morals of child.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Making Sexually Explicit Material Available to Child", section: "171.1", category: .childrenOffenses,
                  description: "Making, transmitting, or making available sexually explicit material to person under 18 for purpose of facilitating sexual offense.",
                  minimumSentence: .months(6), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "90-day minimum on summary conviction."),

            Crime(name: "Procuring Person Under 18 for Illicit Sexual Activity", section: "212(2)", category: .childrenOffenses,
                  description: "Procuring person under 18 to have illicit sexual intercourse.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),
        ]
    }

    // MARK: - Property Offenses
    private var propertyOffenses: [Crime] {
        [
            Crime(name: "Theft Under $5,000", section: "334(b)", category: .propertyOffenses,
                  description: "Taking property under $5,000 without consent with intent to deprive owner.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor,
                  notes: "Hybrid offense. Summary: 2 years less a day or $5,000 fine."),

            Crime(name: "Theft Over $5,000", section: "334(a)", category: .propertyOffenses,
                  description: "Taking property over $5,000 without consent with intent to deprive owner.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Motor Vehicle Theft", section: "333.1", category: .propertyOffenses,
                  description: "Theft of a motor vehicle.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "6-month minimum for third or subsequent offense."),

            Crime(name: "Theft of Cattle", section: "338(1)", category: .propertyOffenses,
                  description: "Stealing cattle.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Theft from Mail", section: "356(1)(a)", category: .propertyOffenses,
                  description: "Stealing anything sent by post after it is deposited and before delivery.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Theft of Telecommunications Service", section: "326", category: .propertyOffenses,
                  description: "Stealing telecommunication service or using device to obtain such service without payment.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Theft of Electricity/Gas/Water", section: "326(1)(b)", category: .propertyOffenses,
                  description: "Fraudulently consuming or using electricity, gas, or water.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Taking Motor Vehicle Without Consent", section: "335", category: .propertyOffenses,
                  description: "Taking a motor vehicle without consent of owner with intent to drive or use it.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Break and Enter - Dwelling House", section: "348(1)(d)", category: .propertyOffenses,
                  description: "Breaking and entering a dwelling house with intent to commit an indictable offense.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "Home invasion cases typically result in significant sentences."),

            Crime(name: "Break and Enter - Non-Dwelling", section: "348(1)(e)", category: .propertyOffenses,
                  description: "Breaking and entering a place other than dwelling with intent to commit indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Being Unlawfully in Dwelling House", section: "349(1)", category: .propertyOffenses,
                  description: "Being unlawfully in a dwelling house without lawful excuse.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Break-In Instruments", section: "351(1)", category: .propertyOffenses,
                  description: "Possessing instrument suitable for breaking into places with intent to use it.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Disguise with Intent", section: "351(2)", category: .propertyOffenses,
                  description: "Having face masked or colored with intent to commit an indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Mischief Under $5,000", section: "430(4)", category: .propertyOffenses,
                  description: "Willfully destroying or damaging property under $5,000, rendering it useless or obstructing its use.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Mischief Over $5,000", section: "430(3)", category: .propertyOffenses,
                  description: "Willfully destroying or damaging property over $5,000.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Mischief to Religious Property", section: "430(4.1)", category: .propertyOffenses,
                  description: "Mischief to religious property, educational institution, or cultural property motivated by bias, prejudice, or hate.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Mischief to War Memorial", section: "430(4.11)", category: .propertyOffenses,
                  description: "Mischief in relation to war memorial.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Mischief - Endangering Life", section: "430(2)", category: .propertyOffenses,
                  description: "Mischief that causes actual danger to life.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Arson - Disregard for Human Life", section: "433", category: .propertyOffenses,
                  description: "Intentionally setting fire knowing or reckless as to whether property is inhabited.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Arson - Damage to Property", section: "434", category: .propertyOffenses,
                  description: "Intentionally damaging property by fire or explosion.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Arson - Own Property", section: "434.1", category: .propertyOffenses,
                  description: "Setting fire to own property causing danger to life or serious damage to others' property.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Arson by Negligence", section: "436", category: .propertyOffenses,
                  description: "Owning property and by marked departure from reasonable care causing fire.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Arson for Fraudulent Purpose", section: "435", category: .propertyOffenses,
                  description: "Burning or destroying property with intent to defraud.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Incendiary Material", section: "436.1", category: .propertyOffenses,
                  description: "Possessing incendiary material/device/explosive substance for purpose of arson.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Stolen Property Under $5,000", section: "354(1)(b)", category: .propertyOffenses,
                  description: "Possessing property knowing it was obtained by crime, value under $5,000.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Possession of Stolen Property Over $5,000", section: "354(1)(a)", category: .propertyOffenses,
                  description: "Possessing property knowing it was obtained by crime, value over $5,000.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Trafficking in Stolen Goods", section: "355.2", category: .propertyOffenses,
                  description: "Trafficking in property obtained by crime for consideration.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Possession for Trafficking Stolen Goods", section: "355.4", category: .propertyOffenses,
                  description: "Possessing property obtained by crime for purpose of trafficking.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Unauthorized Use of Computer", section: "342.1", category: .propertyOffenses,
                  description: "Fraudulently obtaining computer services or intercepting computer functions.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),
        ]
    }

    // MARK: - Drug Offenses
    private var drugOffenses: [Crime] {
        [
            Crime(name: "Possession - Schedule I (Cocaine, Heroin, Fentanyl)", section: "4(1)", category: .drugOffenses,
                  description: "Possession of Schedule I substances including cocaine, heroin, fentanyl, methamphetamine, MDMA.",
                  minimumSentence: nil, maximumSentence: .years(7), youthModifier: .standard,
                  notes: "Summary: 1 year or $1,000 fine first offense.", statute: .cdsa),

            Crime(name: "Possession - Schedule II (Cannabis Over Limit)", section: "4(1)", category: .drugOffenses,
                  description: "Possession of cannabis exceeding legal limits.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .minor,
                  notes: "Adults can legally possess up to 30g in public.", statute: .cdsa),

            Crime(name: "Possession - Schedule III (Psychedelics)", section: "4(1)", category: .drugOffenses,
                  description: "Possession of Schedule III substances including LSD, psilocybin (mushrooms), mescaline.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .minor,
                  notes: "Summary: 1 year or $1,000 fine first offense.", statute: .cdsa),

            Crime(name: "Possession - Schedule IV (Barbiturates)", section: "4(1)", category: .drugOffenses,
                  description: "Possession of Schedule IV substances including barbiturates, anabolic steroids, benzodiazepines.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .minor,
                  notes: "Summary: 6 months or $1,000 fine first offense.", statute: .cdsa),

            Crime(name: "Trafficking - Schedule I", section: "5(1)", category: .drugOffenses,
                  description: "Selling, giving, administering, transporting, or delivering Schedule I substances.",
                  minimumSentence: .years(1), maximumSentence: .life, youthModifier: .standard,
                  notes: "2-year min if aggravating factors (near school, using youth, for criminal org).", statute: .cdsa),

            Crime(name: "Trafficking - Schedule II", section: "5(1)", category: .drugOffenses,
                  description: "Trafficking cannabis or cannabis derivatives.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "1-year minimum if aggravating factors present.", statute: .cdsa),

            Crime(name: "Trafficking - Schedule III/IV", section: "5(1)", category: .drugOffenses,
                  description: "Trafficking Schedule III or IV substances.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: nil, statute: .cdsa),

            Crime(name: "Possession for Purpose of Trafficking - Schedule I", section: "5(2)", category: .drugOffenses,
                  description: "Possessing Schedule I substance for purpose of trafficking.",
                  minimumSentence: .years(1), maximumSentence: .life, youthModifier: .standard,
                  notes: "2-year min if aggravating factors present.", statute: .cdsa),

            Crime(name: "Production - Schedule I", section: "7(1)", category: .drugOffenses,
                  description: "Manufacturing, synthesizing, or producing Schedule I substances.",
                  minimumSentence: .years(2), maximumSentence: .life, youthModifier: .standard,
                  notes: "3-year min if aggravating factors.", statute: .cdsa),

            Crime(name: "Production - Schedule II (Cannabis Over Legal Limit)", section: "7(1)", category: .drugOffenses,
                  description: "Producing cannabis exceeding legal cultivation limits.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Adults may cultivate up to 4 plants per residence.", statute: .cdsa),

            Crime(name: "Production - Schedule III/IV", section: "7(1)", category: .drugOffenses,
                  description: "Producing Schedule III or IV substances.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: nil, statute: .cdsa),

            Crime(name: "Importing/Exporting - Schedule I", section: "6(1)", category: .drugOffenses,
                  description: "Importing or exporting Schedule I substances.",
                  minimumSentence: .years(1), maximumSentence: .life, youthModifier: .standard,
                  notes: "2-year min for amounts over 1kg.", statute: .cdsa),

            Crime(name: "Importing/Exporting - Schedule II", section: "6(1)", category: .drugOffenses,
                  description: "Importing or exporting cannabis exceeding legal limits.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: nil, statute: .cdsa),

            Crime(name: "Possession of Precursor for Production", section: "7.1", category: .drugOffenses,
                  description: "Possessing, producing, or importing precursor chemicals with intent to produce controlled substance.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: nil, statute: .cdsa),

            Crime(name: "Cannabis - Distribution to Minor", section: "9", category: .drugOffenses,
                  description: "Distributing cannabis to person under 18.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: nil, statute: .cannabisAct),

            Crime(name: "Cannabis - Using Minor in Offense", section: "10", category: .drugOffenses,
                  description: "Using person under 18 in commission of cannabis offense.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: nil, statute: .cannabisAct),

            Crime(name: "Impaired Driving - Drug", section: "320.14(1)(a)", category: .drugOffenses,
                  description: "Operating motor vehicle while impaired by drug or combination of alcohol and drug.",
                  minimumSentence: .fine(1000), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "$1,000 min fine first, 30-day jail second, 120-day third."),
        ]
    }

    // MARK: - Financial Crimes
    private var financialCrimes: [Crime] {
        [
            Crime(name: "Fraud Under $5,000", section: "380(1)(b)", category: .financialCrimes,
                  description: "Defrauding the public or any person of property, money, or services under $5,000.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Fraud Over $5,000", section: "380(1)(a)", category: .financialCrimes,
                  description: "Defrauding the public or any person of property, money, or services over $5,000.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "2-year minimum if value exceeds $1 million."),

            Crime(name: "Fraud Affecting Public Market", section: "380(2)", category: .financialCrimes,
                  description: "Fraud affecting the public market price of stocks, shares, merchandise, or anything publicly offered for sale.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Insider Trading", section: "382.1", category: .financialCrimes,
                  description: "Using inside information to buy or sell securities.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Identity Theft", section: "402.2", category: .financialCrimes,
                  description: "Obtaining or possessing another person's identity information with intent to commit indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Identity Fraud", section: "403", category: .financialCrimes,
                  description: "Fraudulently personating another person to gain advantage or cause disadvantage.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Forgery", section: "366", category: .financialCrimes,
                  description: "Making a false document with intent that it be used as genuine.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Uttering Forged Document", section: "368", category: .financialCrimes,
                  description: "Knowingly using, dealing with, or acting on a forged document as if genuine.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Counterfeiting", section: "449", category: .financialCrimes,
                  description: "Making or possessing counterfeit money.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Uttering Counterfeit Money", section: "452", category: .financialCrimes,
                  description: "Uttering or offering counterfeit money.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Money Laundering", section: "462.31", category: .financialCrimes,
                  description: "Dealing with property or proceeds from designated offenses to conceal illicit origin.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Property from Crime Over $5,000", section: "354", category: .financialCrimes,
                  description: "Possessing proceeds of crime over $5,000.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Laundering Proceeds of Crime", section: "462.31", category: .financialCrimes,
                  description: "Using, transferring, sending, or delivering property for purpose of concealing its illicit source.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Bribery of Officials", section: "119", category: .financialCrimes,
                  description: "Giving or offering a bribe to judicial officer, member of Parliament, or government official.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Bribery of Officers", section: "120", category: .financialCrimes,
                  description: "Giving, offering, or receiving bribe by justice, police commissioner, or peace officer.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Frauds on Government", section: "121", category: .financialCrimes,
                  description: "Giving, accepting, or agreeing to accept benefit for government contracts or dealings.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Breach of Trust by Public Officer", section: "122", category: .financialCrimes,
                  description: "Public officer committing breach of trust or fraud in connection with duties.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Secret Commissions", section: "426", category: .financialCrimes,
                  description: "Agent corruptly accepting or giving consideration without principal's consent.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Embezzlement by Public Servant", section: "334", category: .financialCrimes,
                  description: "Public servant stealing or converting anything received by virtue of employment.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Criminal Breach of Trust", section: "336", category: .financialCrimes,
                  description: "Being a trustee and with intent to defraud, converting anything held in trust to own use.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Tax Evasion", section: "239(1)", category: .financialCrimes,
                  description: "Making false statements or participating in tax evasion.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "Fine of 50-200% of tax evaded, plus imprisonment.", statute: .incomeTexAct),

            Crime(name: "Credit Card Fraud", section: "342(1)", category: .financialCrimes,
                  description: "Using, possessing, or trafficking credit card data without authorization.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Obtaining Credit by False Pretense", section: "362(1)(b)", category: .financialCrimes,
                  description: "Obtaining credit by false pretense or fraud.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "False Prospectus", section: "400", category: .financialCrimes,
                  description: "Making false or deceptive statement in prospectus or statement published to induce investment.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Market Manipulation", section: "382", category: .financialCrimes,
                  description: "Using stock exchange facilities to manipulate market price of securities.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Price Fixing", section: "45", category: .financialCrimes,
                  description: "Conspiring to fix prices, allocate markets, or reduce output.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Fine up to $25 million.", statute: .competitionAct),

            Crime(name: "Bid Rigging", section: "47", category: .financialCrimes,
                  description: "Agreeing to not submit bid or to withdraw bid or submitting pre-arranged bids.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: nil, statute: .competitionAct),

            Crime(name: "False or Misleading Advertising", section: "52", category: .financialCrimes,
                  description: "Making materially false or misleading representation to promote product or business.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: nil, statute: .competitionAct),

            Crime(name: "Pyramid/Multi-Level Marketing Schemes", section: "55", category: .financialCrimes,
                  description: "Operating scheme of pyramid selling.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .competitionAct),
        ]
    }

    // MARK: - Cyber Crimes
    private var cyberCrimes: [Crime] {
        [
            Crime(name: "Unauthorized Computer Access", section: "342.1", category: .cyberCrimes,
                  description: "Fraudulently obtaining computer services or using computer to commit offense or intercept functions.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Mischief to Computer Data", section: "430(1.1)", category: .cyberCrimes,
                  description: "Destroying, altering, or rendering meaningless computer data or denying access.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Device for Unauthorized Computer Use", section: "342.2", category: .cyberCrimes,
                  description: "Possessing instruments/devices for unauthorized use of computer systems.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Interception of Private Communications", section: "184", category: .cyberCrimes,
                  description: "Willfully intercepting private communication using electromagnetic or other device.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Disclosure of Intercepted Communications", section: "193", category: .cyberCrimes,
                  description: "Knowingly disclosing intercepted private communication without consent.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Possession of Interception Device", section: "191", category: .cyberCrimes,
                  description: "Possessing device primarily useful for interception without authorization.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Fraudulent Use of Telecom Facility", section: "327", category: .cyberCrimes,
                  description: "Using telecommunication facility or obtaining telecom service fraudulently.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Possession of Means to Use Telecom Facility", section: "327(2)", category: .cyberCrimes,
                  description: "Manufacturing/possessing instruments for fraudulent use of telecom facility.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Copyright Infringement - Commercial", section: "42", category: .cyberCrimes,
                  description: "Infringement of copyright on commercial scale.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .copyrightAct),

            Crime(name: "Circumventing Technological Protection", section: "41.1", category: .cyberCrimes,
                  description: "Circumventing technological protection measures on copyrighted works.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .copyrightAct),
        ]
    }

    // MARK: - Weapons & Firearms
    private var weaponsFirearms: [Crime] {
        [
            Crime(name: "Possession of Firearm - Unauthorized", section: "91(1)", category: .weaponsFirearms,
                  description: "Possessing firearm without license or registration.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Prohibited/Restricted Firearm with Ammo", section: "95", category: .weaponsFirearms,
                  description: "Possessing loaded restricted/prohibited firearm or with accessible ammunition.",
                  minimumSentence: .years(3), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "3-year min first, 5-year min subsequent."),

            Crime(name: "Possession of Prohibited Weapon", section: "91(2)", category: .weaponsFirearms,
                  description: "Possessing prohibited weapon, restricted weapon, prohibited device, or prohibited ammunition.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Weapons Trafficking", section: "99", category: .weaponsFirearms,
                  description: "Trafficking in firearms, prohibited weapons, or prohibited devices.",
                  minimumSentence: .years(3), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "5-year minimum for subsequent offenses."),

            Crime(name: "Possession for Purpose of Weapons Trafficking", section: "100", category: .weaponsFirearms,
                  description: "Possessing firearm, prohibited weapon, or device for purpose of trafficking.",
                  minimumSentence: .years(3), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "5-year minimum for subsequent offenses."),

            Crime(name: "Importing/Exporting Firearms Without Authorization", section: "103", category: .weaponsFirearms,
                  description: "Importing or exporting firearm, prohibited weapon, or device without authorization.",
                  minimumSentence: .years(3), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "5-year minimum for subsequent."),

            Crime(name: "Careless Use of Firearm", section: "86(1)", category: .weaponsFirearms,
                  description: "Using, carrying, handling, shipping, or storing firearm in careless manner or without reasonable precautions.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Using Firearm in Commission of Offense", section: "85", category: .weaponsFirearms,
                  description: "Using firearm or imitation while committing or attempting indictable offense.",
                  minimumSentence: .years(1), maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Consecutive to sentence for underlying offense."),

            Crime(name: "Careless Storage of Firearm", section: "86(2)", category: .weaponsFirearms,
                  description: "Failing to store firearm in compliance with regulations.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Pointing a Firearm", section: "87", category: .weaponsFirearms,
                  description: "Pointing firearm at another person without lawful excuse.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Making Automatic Firearm", section: "102", category: .weaponsFirearms,
                  description: "Altering firearm to discharge projectiles in rapid succession with one trigger pull.",
                  minimumSentence: .years(1), maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Weapon for Dangerous Purpose", section: "88", category: .weaponsFirearms,
                  description: "Carrying weapon, prohibited device, or ammunition for purpose dangerous to public peace.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Carrying Concealed Weapon", section: "90", category: .weaponsFirearms,
                  description: "Carrying concealed weapon or prohibited device without authorization.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Unauthorized Possession in Motor Vehicle", section: "94", category: .weaponsFirearms,
                  description: "Occupant of motor vehicle knowing there is prohibited firearm or device in vehicle.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "1-year minimum first, 3-year second, 5-year third or subsequent."),

            Crime(name: "Tampering with Serial Number", section: "108(1)", category: .weaponsFirearms,
                  description: "Altering, removing, or obliterating serial number on firearm.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Weapon with Altered Serial Number", section: "108(2)", category: .weaponsFirearms,
                  description: "Possessing firearm knowing serial number has been altered, removed, or obliterated.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Possession of Explosives", section: "82(1)", category: .weaponsFirearms,
                  description: "Without lawful excuse possessing explosive substance.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Making or Possessing Explosive Device", section: "81(1)(d)", category: .weaponsFirearms,
                  description: "Making or possessing explosive or incendiary device or material to make one.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Using Explosives", section: "81(1)(a)", category: .weaponsFirearms,
                  description: "Using explosives with intent to cause serious bodily harm or death.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),
        ]
    }

    // MARK: - Administration of Justice
    private var adminJustice: [Crime] {
        [
            Crime(name: "Obstruction of Justice", section: "139(2)", category: .adminJustice,
                  description: "Willfully attempting to obstruct, pervert, or defeat course of justice.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Perjury", section: "131(1)", category: .adminJustice,
                  description: "Making false statement under oath or affirmation in judicial proceeding.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Fabricating Evidence", section: "137", category: .adminJustice,
                  description: "Fabricating evidence with intent to mislead.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Public Mischief", section: "140", category: .adminJustice,
                  description: "Making false statement to peace officer to cause investigation or mislead.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .minor, notes: nil),

            Crime(name: "Breach of Probation", section: "733.1", category: .adminJustice,
                  description: "Failing without reasonable excuse to comply with probation order.",
                  minimumSentence: nil, maximumSentence: .years(4), youthModifier: .minor, notes: nil),

            Crime(name: "Breach of Recognizance (Bail)", section: "145(3)", category: .adminJustice,
                  description: "Failing without lawful excuse to comply with condition of undertaking or recognizance.",
                  minimumSentence: nil, maximumSentence: .years(4), youthModifier: .minor, notes: nil),

            Crime(name: "Failure to Appear", section: "145(2)", category: .adminJustice,
                  description: "Failing without lawful excuse to appear in court as required.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Escape from Lawful Custody", section: "144", category: .adminJustice,
                  description: "Escaping from lawful custody or at large before sentence expires.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "10 years if escaping prison."),

            Crime(name: "Being at Large Without Lawful Excuse", section: "145(1)", category: .adminJustice,
                  description: "Being at large without lawful excuse before expiration of sentence.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Prison Breach", section: "144(a)", category: .adminJustice,
                  description: "Breaking out of prison with intent to escape.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Assisting Escape", section: "146", category: .adminJustice,
                  description: "Assisting prisoner of war or person in lawful custody to escape.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Resisting Arrest", section: "129(a)", category: .adminJustice,
                  description: "Resisting or willfully obstructing peace officer in execution of duty.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Obstructing Peace Officer", section: "129(a)", category: .adminJustice,
                  description: "Willfully obstructing peace officer or public officer in execution of duty.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Personating Peace Officer", section: "130", category: .adminJustice,
                  description: "Falsely representing oneself to be peace officer or public officer.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Accessory After the Fact", section: "463", category: .adminJustice,
                  description: "Receiving, comforting, or assisting person who committed indictable offense to escape.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Maximum half of maximum for underlying offense."),

            Crime(name: "Compounding Indictable Offense", section: "141", category: .adminJustice,
                  description: "Asking or receiving consideration for not prosecuting indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Corrupting Justice - Accepting Bribe", section: "119", category: .adminJustice,
                  description: "Corruptly accepting any gift for oneself in respect of judicial or official duties.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Intimidation of Justice System Participant", section: "423.1", category: .adminJustice,
                  description: "Intimidating justice system participant (judge, juror, prosecutor, witness) to impede justice.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Contempt of Court", section: "708", category: .adminJustice,
                  description: "Disobeying court order or showing disrespect for court proceedings.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Breach of Peace Bond", section: "811", category: .adminJustice,
                  description: "Failing without reasonable excuse to comply with recognizance to keep the peace.",
                  minimumSentence: nil, maximumSentence: .years(4), youthModifier: .minor, notes: nil),
        ]
    }

    // MARK: - Public Order
    private var publicOrder: [Crime] {
        [
            Crime(name: "Causing a Disturbance", section: "175(1)", category: .publicOrder,
                  description: "Fighting, screaming, shouting, swearing, or being drunk in public place.",
                  minimumSentence: nil, maximumSentence: .fine(5000), youthModifier: .minor,
                  notes: "Summary conviction only."),

            Crime(name: "Unlawful Assembly", section: "63", category: .publicOrder,
                  description: "Assembly of three or more causing reasonable fear of breach of peace.",
                  minimumSentence: nil, maximumSentence: .fine(5000), youthModifier: .minor,
                  notes: "Summary offense."),

            Crime(name: "Riot", section: "65", category: .publicOrder,
                  description: "Unlawful assembly that has begun to disturb peace tumultuously.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Participation in Riot", section: "65", category: .publicOrder,
                  description: "Taking part in a riot.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Reading Proclamation (Riot)", section: "68", category: .publicOrder,
                  description: "After proclamation to disperse, failing to disperse within 30 minutes.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Public Incitement of Hatred", section: "319(1)", category: .publicOrder,
                  description: "Communicating in public place statements inciting hatred likely to lead to breach of peace.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Willful Promotion of Hatred", section: "319(2)", category: .publicOrder,
                  description: "Willfully promoting hatred against identifiable group.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Advocating Genocide", section: "318", category: .publicOrder,
                  description: "Advocating or promoting genocide against identifiable group.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Mischief - Hate Motivation", section: "430(4.101)", category: .publicOrder,
                  description: "Mischief motivated by hatred based on race, national or ethnic origin, language, colour, religion, sex, age, mental or physical disability, sexual orientation, or gender identity.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Assault - Hate Motivation", section: "718.2(a)(i)", category: .publicOrder,
                  description: "Assault motivated by bias, prejudice, or hate based on protected grounds.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "Hate motivation is aggravating factor at sentencing."),

            Crime(name: "Spreading False News", section: "181", category: .publicOrder,
                  description: "Willfully publishing statement, tale, or news knowing it to be false causing injury to public interest.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor,
                  notes: "Section declared unconstitutional but remains in Code."),

            Crime(name: "Intimidation", section: "423", category: .publicOrder,
                  description: "Using violence, threats, or persistent following to compel abstaining from lawful act.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Forcible Entry", section: "73", category: .publicOrder,
                  description: "Entering real property in possession of another in manner likely to cause breach of peace.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Forcible Detainer", section: "74", category: .publicOrder,
                  description: "Being in possession of real property without color of right and resisting entry by person entitled.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Piracy", section: "74(1)", category: .publicOrder,
                  description: "Committing piracy according to law of nations.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Piratical Acts", section: "75", category: .publicOrder,
                  description: "Committing piratical acts (robbery, endangering navigation, etc.) in Canadian waters.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Hijacking", section: "76", category: .publicOrder,
                  description: "Seizing control of aircraft or causing interference with navigation.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Endangering Safety of Aircraft", section: "77", category: .publicOrder,
                  description: "Causing damage to aircraft, placing thing on aircraft, or doing anything likely to endanger safety.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Taking Weapon on Aircraft", section: "78", category: .publicOrder,
                  description: "Taking offensive weapon or explosive on aircraft.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Trespassing at Night", section: "177", category: .publicOrder,
                  description: "Loitering or prowling at night on property near dwelling house.",
                  minimumSentence: nil, maximumSentence: .fine(5000), youthModifier: .minor,
                  notes: "Summary conviction."),
        ]
    }

    // MARK: - Terrorism & National Security
    private var terrorism: [Crime] {
        [
            Crime(name: "Participation in Terrorist Group", section: "83.18", category: .terrorism,
                  description: "Participating in or contributing to activity of terrorist group for purpose of enhancing its ability.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Facilitating Terrorist Activity", section: "83.19", category: .terrorism,
                  description: "Knowingly facilitating terrorist activity.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Commission of Offense for Terrorist Group", section: "83.2", category: .terrorism,
                  description: "Committing indictable offense for benefit of, at direction of, or in association with terrorist group.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Instructing to Carry Out Terrorist Activity", section: "83.22", category: .terrorism,
                  description: "Knowingly instructing person to carry out terrorist activity.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Harboring/Concealing Terrorist", section: "83.23", category: .terrorism,
                  description: "Knowingly harboring or concealing person who has carried out or is likely to carry out terrorist activity.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Financing Terrorism", section: "83.02", category: .terrorism,
                  description: "Providing or collecting property intending or knowing it will be used to carry out terrorist activity.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Providing Property for Terrorism", section: "83.03", category: .terrorism,
                  description: "Providing or making available property or financial services to terrorist group.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Using/Possessing Property for Terrorism", section: "83.04", category: .terrorism,
                  description: "Using or possessing property for terrorist purposes.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Leaving Canada for Terrorism", section: "83.181", category: .terrorism,
                  description: "Leaving or attempting to leave Canada for purpose of participating in terrorist activity.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Hoax - Terrorism", section: "83.231", category: .terrorism,
                  description: "Conveying information knowing it to be false with intent to cause fear of terrorist activity.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Treason", section: "46(1)", category: .terrorism,
                  description: "Using force or violence to overthrow government, communicating military info to enemy, assisting enemy.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "High Treason", section: "47(1)", category: .terrorism,
                  description: "Killing, wounding, or imprisoning the Sovereign, levying war against Canada, or assisting enemy at war.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "Mandatory life imprisonment."),

            Crime(name: "Sedition", section: "59", category: .terrorism,
                  description: "Speaking seditious words, publishing seditious libel, or being party to seditious conspiracy.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Sabotage", section: "52", category: .terrorism,
                  description: "Doing act prohibited by Security of Information Act for purpose prejudicial to safety or interests of state.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Wrongful Communication of Information", section: "4", category: .terrorism,
                  description: "Wrongfully communicating, retaining, or failing to take care of information or document.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: nil, statute: .securityOfInfoAct),

            Crime(name: "Threats Against Internationally Protected Person", section: "424", category: .terrorism,
                  description: "Threatening to commit offense against internationally protected person.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Attack on Premises of Internationally Protected Person", section: "431", category: .terrorism,
                  description: "Attacking premises, residence, or transport of internationally protected person.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),
        ]
    }

    // MARK: - Traffic Offenses
    private var trafficOffenses: [Crime] {
        [
            Crime(name: "Impaired Driving - Alcohol", section: "320.14(1)(a)", category: .trafficOffenses,
                  description: "Operating motor vehicle while impaired by alcohol.",
                  minimumSentence: .fine(1000), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "$1,000 min fine first, 30-day jail second, 120-day jail third."),

            Crime(name: "Impaired Driving - Over 80mg", section: "320.14(1)(b)", category: .trafficOffenses,
                  description: "Operating motor vehicle with blood alcohol concentration over 80mg per 100ml blood.",
                  minimumSentence: .fine(1000), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "Higher minimums for BAC over 120mg and 160mg."),

            Crime(name: "Impaired Driving - Refusal", section: "320.15", category: .trafficOffenses,
                  description: "Refusing to comply with demand for breath sample or blood sample.",
                  minimumSentence: .fine(2000), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "Same penalties as over 80mg."),

            Crime(name: "Impaired Driving Causing Bodily Harm", section: "320.14(2)", category: .trafficOffenses,
                  description: "Impaired operation causing bodily harm to another person.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Impaired Driving Causing Death", section: "320.14(3)", category: .trafficOffenses,
                  description: "Impaired operation causing death of another person.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Dangerous Driving", section: "320.13", category: .trafficOffenses,
                  description: "Operating motor vehicle in manner dangerous to public having regard to all circumstances.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Dangerous Driving Causing Bodily Harm", section: "320.13(2)", category: .trafficOffenses,
                  description: "Dangerous operation causing bodily harm.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Dangerous Driving Causing Death", section: "320.13(3)", category: .trafficOffenses,
                  description: "Dangerous operation causing death.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Street Racing", section: "320.13", category: .trafficOffenses,
                  description: "Operating motor vehicle in race with another vehicle or performing stunt.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Street Racing Causing Bodily Harm", section: "320.13(2)", category: .trafficOffenses,
                  description: "Street racing causing bodily harm.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Street Racing Causing Death", section: "320.13(3)", category: .trafficOffenses,
                  description: "Street racing causing death.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Failure to Stop at Accident", section: "320.16", category: .trafficOffenses,
                  description: "Failing to stop after accident to give identity and offer assistance.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard,
                  notes: "Life imprisonment if death results and knowledge of injury."),

            Crime(name: "Flight from Police", section: "320.17", category: .trafficOffenses,
                  description: "Operating motor vehicle while being pursued by peace officer and failing to stop.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Flight from Police Causing Bodily Harm", section: "320.17(2)", category: .trafficOffenses,
                  description: "Flight from police causing bodily harm to another person.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Flight from Police Causing Death", section: "320.17(3)", category: .trafficOffenses,
                  description: "Flight from police causing death of another person.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Driving While Prohibited", section: "320.18", category: .trafficOffenses,
                  description: "Operating motor vehicle while prohibited from doing so by court order.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Driving While Disqualified", section: "320.18", category: .trafficOffenses,
                  description: "Operating motor vehicle while disqualified from doing so.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Operating Vessel Impaired", section: "320.14", category: .trafficOffenses,
                  description: "Operating vessel, aircraft, or railway equipment while impaired.",
                  minimumSentence: .fine(1000), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "Same penalties as motor vehicle impaired driving."),
        ]
    }

    // MARK: - Moral & Decency Offenses
    private var moralOffenses: [Crime] {
        [
            Crime(name: "Obscene Publication", section: "163(1)", category: .moralOffenses,
                  description: "Making, printing, publishing, or distributing obscene material.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Distributing Obscene Material", section: "163(2)", category: .moralOffenses,
                  description: "Selling, distributing, or exposing to public view obscene matter.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Indecent Act", section: "173(1)", category: .moralOffenses,
                  description: "Willfully doing indecent act in public place or exposing genitals to person under 16.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Nudity", section: "174", category: .moralOffenses,
                  description: "Being nude in public place without lawful excuse.",
                  minimumSentence: nil, maximumSentence: .fine(5000), youthModifier: .minor,
                  notes: "Summary conviction."),

            Crime(name: "Procuring for Prostitution", section: "286.3", category: .moralOffenses,
                  description: "Procuring or recruiting person to offer or provide sexual services for consideration.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "5-year minimum if victim under 18."),

            Crime(name: "Material Benefit from Sexual Services", section: "286.2", category: .moralOffenses,
                  description: "Receiving financial or material benefit from sexual services provided by another person.",
                  minimumSentence: nil, maximumSentence: .years(10), youthModifier: .standard, notes: nil),

            Crime(name: "Advertising Sexual Services", section: "286.4", category: .moralOffenses,
                  description: "Advertising another person's sexual services.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Purchasing Sexual Services - Minor", section: "286.1(2)", category: .moralOffenses,
                  description: "Obtaining sexual services for consideration from person under 18.",
                  minimumSentence: .months(6), maximumSentence: .years(10), youthModifier: .standard,
                  notes: "1-year minimum for second or subsequent offense."),

            Crime(name: "Purchasing Sexual Services - Adult", section: "286.1(1)", category: .moralOffenses,
                  description: "Obtaining sexual services for consideration from person 18 or older.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Communicating for Purpose of Prostitution - Public Place", section: "213(1)", category: .moralOffenses,
                  description: "Communicating in public place for purpose of obtaining sexual services.",
                  minimumSentence: nil, maximumSentence: .fine(5000), youthModifier: .minor,
                  notes: "Summary conviction."),

            Crime(name: "Common Bawdy House", section: "210", category: .moralOffenses,
                  description: "Keeping common bawdy house or being found in such a place.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Gaming House", section: "201", category: .moralOffenses,
                  description: "Keeping common gaming house or found in such a place.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Betting House", section: "201(2)", category: .moralOffenses,
                  description: "Keeping common betting house.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Book-Making", section: "202", category: .moralOffenses,
                  description: "Engaging in book-making or pool-selling.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Lottery Offenses", section: "206", category: .moralOffenses,
                  description: "Making, printing, selling lottery scheme not authorized by law.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Cheating at Play", section: "209", category: .moralOffenses,
                  description: "Cheating while playing game or holding stakes.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),

            Crime(name: "Cruelty to Animals", section: "445.1", category: .moralOffenses,
                  description: "Willfully causing unnecessary pain, suffering, or injury to animal.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Killing/Injuring Animals", section: "445", category: .moralOffenses,
                  description: "Willfully killing, maiming, wounding, or injuring dogs, birds, or animals.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Keeping Cockpit", section: "447", category: .moralOffenses,
                  description: "Building, making, maintaining, or keeping cockpit for fighting cocks.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Causing Unnecessary Suffering", section: "446(1)(b)", category: .moralOffenses,
                  description: "Negligently causing unnecessary pain, suffering, or injury to animal.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor, notes: nil),
        ]
    }

    // MARK: - Environmental Offenses
    private var environmentalOffenses: [Crime] {
        [
            Crime(name: "Deposit of Deleterious Substance", section: "36(3)", category: .environmentalOffenses,
                  description: "Depositing or permitting deposit of deleterious substance in water frequented by fish.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .standard,
                  notes: "Summary: 2 years less a day or $300,000 fine.", statute: .fisheriesAct),

            Crime(name: "Unlawful Fishing", section: "78", category: .environmentalOffenses,
                  description: "Fishing without license or in contravention of regulations.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor,
                  notes: nil, statute: .fisheriesAct),

            Crime(name: "Destroying Fish Habitat", section: "35(1)", category: .environmentalOffenses,
                  description: "Carrying on work or undertaking that results in harmful alteration or destruction of fish habitat.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .standard,
                  notes: nil, statute: .fisheriesAct),

            Crime(name: "Release of Toxic Substance", section: "272", category: .environmentalOffenses,
                  description: "Releasing or permitting release of toxic substance into environment.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "Fine up to $1 million per day.", statute: .environmentalProtectionAct),

            Crime(name: "Failure to Report Release", section: "273", category: .environmentalOffenses,
                  description: "Failing to report release of substance as required.",
                  minimumSentence: nil, maximumSentence: .years(2), youthModifier: .minor,
                  notes: nil, statute: .environmentalProtectionAct),

            Crime(name: "Import/Export of Hazardous Waste", section: "185", category: .environmentalOffenses,
                  description: "Importing, exporting, or transporting hazardous waste in contravention of regulations.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .standard,
                  notes: nil, statute: .environmentalProtectionAct),

            Crime(name: "Killing Species at Risk", section: "32(1)", category: .environmentalOffenses,
                  description: "Killing, harming, harassing, capturing, or taking individual of wildlife species listed as extirpated, endangered, or threatened.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "Fine up to $1 million.", statute: .speciesAtRiskAct),

            Crime(name: "Possession of Species at Risk", section: "32(2)", category: .environmentalOffenses,
                  description: "Possessing, collecting, buying, selling, or trading individual of protected species or its parts.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .speciesAtRiskAct),

            Crime(name: "Destruction of Critical Habitat", section: "58(1)", category: .environmentalOffenses,
                  description: "Destroying critical habitat of species listed as endangered or threatened.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .speciesAtRiskAct),

            Crime(name: "Wildlife Trafficking - CITES", section: "6", category: .environmentalOffenses,
                  description: "Importing, exporting, or transporting controlled animal or plant in contravention of CITES.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .wildlifeAct),

            Crime(name: "Illegal Import of Wildlife", section: "6(2)", category: .environmentalOffenses,
                  description: "Importing animal or plant taken, possessed, or transported in contravention of law of country of origin.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: nil, statute: .wildlifeAct),

            Crime(name: "Ocean Dumping", section: "125", category: .environmentalOffenses,
                  description: "Dumping substance in waters under Canadian jurisdiction without permit.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .standard,
                  notes: nil, statute: .environmentalProtectionAct),

            Crime(name: "Ship-Source Pollution", section: "186.1", category: .environmentalOffenses,
                  description: "Discharge of prescribed pollutant from ship in Canadian waters.",
                  minimumSentence: nil, maximumSentence: .years(3), youthModifier: .standard,
                  notes: nil, statute: .environmentalProtectionAct),
        ]
    }

    // MARK: - Criminal Organizations
    private var organizationsOffenses: [Crime] {
        [
            Crime(name: "Participation in Criminal Organization", section: "467.11", category: .organizationsOffenses,
                  description: "Participating in or contributing to activity of criminal organization for purpose of enhancing its ability to commit or facilitate indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard, notes: nil),

            Crime(name: "Commission of Offense for Criminal Organization", section: "467.12", category: .organizationsOffenses,
                  description: "Committing indictable offense for benefit of, at direction of, or in association with criminal organization.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard, notes: nil),

            Crime(name: "Instructing Commission of Offense for Criminal Organization", section: "467.13", category: .organizationsOffenses,
                  description: "Person who is or purports to be member of criminal organization instructing person to commit offense for benefit of organization.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard, notes: nil),

            Crime(name: "Recruiting Member for Criminal Organization", section: "467.111", category: .organizationsOffenses,
                  description: "Recruiting, soliciting, encouraging, or inviting person to join criminal organization.",
                  minimumSentence: nil, maximumSentence: .years(5), youthModifier: .standard,
                  notes: "6-year maximum if victim under 18."),

            Crime(name: "Conspiracy", section: "465(1)(c)", category: .organizationsOffenses,
                  description: "Conspiring with any person to commit indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Maximum is same as maximum for offense conspired to commit."),

            Crime(name: "Counselling Offense Not Committed", section: "464", category: .organizationsOffenses,
                  description: "Counselling another person to commit indictable offense that is not committed.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Maximum half of maximum for offense counselled."),

            Crime(name: "Attempt", section: "463", category: .organizationsOffenses,
                  description: "Attempting to commit an indictable offense.",
                  minimumSentence: nil, maximumSentence: .years(14), youthModifier: .standard,
                  notes: "Maximum half of maximum for completed offense."),

            Crime(name: "Being Party to Offense", section: "21", category: .organizationsOffenses,
                  description: "Aiding or abetting person in committing offense.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "Same liability as principal offender."),

            Crime(name: "Common Intention - Different Offense", section: "21(2)", category: .organizationsOffenses,
                  description: "Forming common intention to carry out unlawful purpose and in doing so offense committed.",
                  minimumSentence: nil, maximumSentence: .life, youthModifier: .standard,
                  notes: "Liable if knew or ought to have known offense would be committed."),
        ]
    }
}
