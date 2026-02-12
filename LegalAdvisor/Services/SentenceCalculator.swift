import Foundation

class SentenceCalculator {
    static func calculateSentence(for crime: Crime, age: Int, jurisdiction: Jurisdiction) -> SentenceResult {
        let ageCategory = AgeCategory.category(for: age)
        let isYouth = age >= 12 && age <= 17

        var minimumSentence: Sentence?
        var maximumSentence: Sentence
        var notes: [String] = []

        if isYouth, let youthModifier = crime.youthModifier {
            minimumSentence = nil
            maximumSentence = youthModifier.maxYouthSentence
            notes.append("Youth Criminal Justice Act applies.")
            if let youthNotes = youthModifier.notes {
                notes.append(youthNotes)
            }
        } else {
            minimumSentence = crime.minimumSentence
            maximumSentence = crime.maximumSentence
        }

        if let crimeNotes = crime.notes {
            notes.append(crimeNotes)
        }

        return SentenceResult(
            crime: crime,
            ageCategory: ageCategory,
            jurisdiction: jurisdiction,
            minimumSentence: minimumSentence,
            maximumSentence: maximumSentence,
            notes: notes
        )
    }
}

struct SentenceResult {
    let crime: Crime
    let ageCategory: AgeCategory
    let jurisdiction: Jurisdiction
    let minimumSentence: Sentence?
    let maximumSentence: Sentence
    let notes: [String]

    var formattedRange: String {
        if let min = minimumSentence {
            return "\(min.formatted) to \(maximumSentence.formatted)"
        }
        return "Up to \(maximumSentence.formatted)"
    }
}
