//
//  Model.swift
//  momshake
//
//  Created by Clayton Sulby on 12/4/20.
//

import Foundation
import UIKit

class Model : ObservableObject {
    
    @Published var firstShake:Bool {
        didSet {
            UserDefaults.standard.set(firstShake, forKey: "firstShake")
        }
    }
    
    var firstInsults:[Insult]
    var secondInsults:[Insult]
    var thirdInsults:[Insult]
    
    
    var firstSelections:[String] {
        firstInsults.map { (insult) -> String in
            return insult.insult
        }
    }
    var secondSelections:[String] {
        secondInsults.map { (insult) -> String in
            return insult.insult
        }
    }
    var thirdSelections:[String] {
        thirdInsults.map { (insult) -> String in
            return insult.insult
        }
    }
    
    var context:[String]
    
    init(){
        
        self.firstShake = false//UserDefaults.standard.object(forKey: "firstShake") as? Bool ?? false
        
        //https://www.litcharts.com/blog/shakespeare/top-shakespeare-insults-of-all-time/
        
        firstInsults = [
            Insult(insult: "foul spoken",
                   source_quote: "Foul spoken coward, that thund’rest with thy tongue, and with thy weapon nothing dares perform.",
                   source_line: "Titus Andronicus, Act 2, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/titus-andronicus/act-2-scene-1"),
            Insult(insult: "overly saucy",
                   source_quote: "You, minion, are too saucy.",
                   source_line: "The Two Gentlemen of Verona, Act 1, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-two-gentlemen-of-verona/act-1-scene-2"),
            Insult(insult: "scornfully scurvied",
                   source_quote: "I scorn you, scurvy companion.",
                   source_line: "Henry IV, Part 2, Act 2, Scene 4",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/henry-iv-part-2/act-2-scene-4"),
            Insult(insult: "flesh-mongering",
                   source_quote: "Was the Duke a flesh-monger, a fool and a coward?",
                   source_line: "Measure For Measure, Act 5, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/measure-for-measure/act-5-scene-1"),
            Insult(insult: "sin-trading",
                   source_quote: "Thy sin’s not accidental, but a trade.",
                   source_line: "Measure For Measure, Act 3, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/measure-for-measure/act-3-scene-1")
        ]

        secondInsults = [
            
            Insult(insult: "prickley faced",
                   source_quote: "Go, prick thy face, and over-red thy fear, Thou lily-liver’d boy.",
                   source_line: "Macbeth, Act 5, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/macbeth/act-5-scene-3"),
            Insult(insult: "lily-livered",
                   source_quote: "Go, prick thy face, and over-red thy fear, Thou lily-liver’d boy.",
                   source_line: "Macbeth, Act 5, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/macbeth/act-5-scene-3"),
            Insult(insult: "over-red fearful",
                   source_quote: "Go, prick thy face, and over-red thy fear, Thou lily-liver’d boy.",
                   source_line: "Macbeth, Act 5, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/macbeth/act-5-scene-3"),
            Insult(insult: "friendly-eared",
                   source_quote: "I must tell you friendly in your ear, sell when you can, you are not for all markets.",
                   source_line: "As You Like It, Act 3, Scene 5",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/as-you-like-it/act-3-scene-5"),
            Insult(insult: "market-specific",
                   source_quote: "I must tell you friendly in your ear, sell when you can, you are not for all markets.",
                   source_line: "As You Like It, Act 3, Scene 5",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/as-you-like-it/act-3-scene-5"),
            Insult(insult: "another-word-unworthy",
                   source_quote: "You are not worth another word, else I’d call you knave.",
                   source_line: "All’s Well That Ends Well, Act 2, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/all-s-well-that-ends-well/act-2-scene-3"),
            Insult(insult: "empty-pursed",
                   source_quote: "A fool, an empty purse. There was no money in’t.",
                   source_line: "Cymbeline, Act 4, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/cymbeline/act-4-scene-2"),
            Insult(insult: "worm-tongued",
                   source_quote: "Thy tongue outvenoms all the worms of Nile.",
                   source_line: "Cymbeline, Act 3, Scene 4",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/cymbeline/act-3-scene-4"),
            Insult(insult: "spit-upon-able",
                   source_quote: "Would thou wert clean enough to spit upon.",
                   source_line: "Timon of Athens, Act 4, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/timon-of-athens/act-4-scene-3"),
            Insult(insult: "better-as-strangers",
                   source_quote: "I do desire that we may be better strangers.",
                   source_line: "As You Like It, Act 3, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/as-you-like-it/act-3-scene-2"),
            Insult(insult: "swine drunk",
                   source_quote: "Drunkenness is his best virtue, for he will be swine drunk, and in his sleep he does little harm, save to his bedclothes about him.",
                   source_line: "All’s Well That Ends Well, Act 4, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/all-s-well-that-ends-well/act-4-scene-3"),
            Insult(insult: "north-of-my-lady’s-opinion",
                   source_quote: "You are now sailed into the north of my lady’s opinion, where you will hang like an icicle on a Dutchman’s beard.",
                   source_line: "Twelfth Night, Act 3, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/twelfth-night/act-3-scene-2")
        ]
        
        thirdInsults = [
            Insult(insult: "rotten apple",
                   source_quote: "There’s small choice in rotten apples.",
                   source_line: "Taming of the Shrew, Act 1, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-taming-of-the-shrew/act-1-scene-1"),
            Insult(insult: "rag",
                   source_quote: "Away thou rag, thou quantity, thou remnant.",
                   source_line: "The Taming of the Shrew, Act 4, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-taming-of-the-shrew/act-4-scene-3"),
            Insult(insult: "quantity",
                   source_quote: "Away thou rag, thou quantity, thou remnant.",
                   source_line: "The Taming of the Shrew, Act 4, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-taming-of-the-shrew/act-4-scene-3"),
            Insult(insult: "remnant",
                   source_quote: "Away thou rag, thou quantity, thou remnant.",
                   source_line: "The Taming of the Shrew, Act 4, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-taming-of-the-shrew/act-4-scene-3"),
            Insult(insult: "coward",
                   source_quote: "Foul spoken coward, that thund’rest with thy tongue, and with thy weapon nothing dares perform.",
                   source_line: "Titus Andronicus, Act 2, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/titus-andronicus/act-2-scene-1"),
            Insult(insult: "thund’rest tongue",
                   source_quote: "Foul spoken coward, that thund’rest with thy tongue, and with thy weapon nothing dares perform.",
                   source_line: "Titus Andronicus, Act 2, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/titus-andronicus/act-2-scene-1"),
            Insult(insult: "boy",
                   source_quote: "Go, prick thy face, and over-red thy fear, Thou lily-liver’d boy.",
                   source_line: "Macbeth, Act 5, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/macbeth/act-5-scene-3"),
            Insult(insult: "minion",
                   source_quote: "You, minion, are too saucy.",
                   source_line: "The Two Gentlemen of Verona, Act 1, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-two-gentlemen-of-verona/act-1-scene-2"),
            Insult(insult: "companion",
                   source_quote: "I scorn you, scurvy companion.",
                   source_line: "Henry IV, Part 2, Act 2, Scene 4",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/henry-iv-part-2/act-2-scene-4"),
            Insult(insult: "fool and coward",
                   source_quote: "Was the Duke a flesh-monger, a fool and a coward?",
                   source_line: "Measure For Measure, Act 5, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/measure-for-measure/act-5-scene-1"),
            Insult(insult: "knave",
                   source_quote: "You are not worth another word, else I’d call you knave.",
                   source_line: "All’s Well That Ends Well, Act 2, Scene 3",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/all-s-well-that-ends-well/act-2-scene-3"),
            Insult(insult: "whoreson zed",
                   source_quote: "Thou whoreson zed, thou unnecessary letter!",
                   source_line: "King Lear, Act 2, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/king-lear/act-2-scene-2"),
            Insult(insult: "unnecessary letter",
                   source_quote: "Thou whoreson zed, thou unnecessary letter!",
                   source_line: "King Lear, Act 2, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/king-lear/act-2-scene-2"),
            Insult(insult: "mouldy rogue",
                   source_quote: "Away, you mouldy rogue, away!",
                   source_line: "Henry IV, Part 2, Act 2, Scene 4",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/henry-iv-part-2/act-2-scene-4"),
            Insult(insult: "burnt-out candle",
                   source_quote: "You are as a candle, the better burnt out.",
                   source_line: "Henry IV Part 2, Act 1, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/henry-iv-part-2/act-1-scene-2"),
            Insult(insult: "hanging icicle",
                   source_quote: "You are now sailed into the north of my lady’s opinion, where you will hang like an icicle on a Dutchman’s beard.",
                   source_line: "Twelfth Night, Act 3, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/twelfth-night/act-3-scene-2"),
            Insult(insult: "threadbare juggler",
                   source_quote: "Threadbare juggler!",
                   source_line: "The Comedy of Errors, Act 5, Scene 1",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/the-comedy-of-errors/act-5-scene-1"),
            Insult(insult: "eater of broken meats",
                   source_quote: "Eater of broken meats!",
                   source_line: "King Lear, Act 2, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/king-lear/act-2-scene-2"),
            Insult(insult: "saucy lackey",
                   source_quote: "Saucy lackey!",
                   source_line: "As You Like It, Act 3, Scene 2",
                   source_url: "https://www.litcharts.com/shakescleare/shakespeare-translations/as-you-like-it/act-3-scene-2"),
        ]

        context = [
            "I've had it with you! You",
            "Geez! Thou art such a",
            "Thou art undoubtedly a",
            "You",
            "Don't ever talk to me again! You",
            "I'll show you! You"
        ]
    }
    
    func fontHelp() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
}
