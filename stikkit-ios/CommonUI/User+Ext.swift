import Foundation
import UIKit

struct User {

    enum Console: CaseIterable {
        case playstation
        case xbox
        case nintendoSwitch
        case pc
        case mobile
        
        var title: String {
            switch self {
            case .playstation:
                return "Playstation"
            case .xbox:
                return "Xbox"
            case .nintendoSwitch:
                return "Nintendo Switch"
            case .pc:
                return "PC"
            case .mobile:
                return "Mobile"
            }
        }
        
        var stringValue: String {
            switch self {
            case .playstation:
                return "ps4"
            case .xbox:
                return "xbox"
            case .nintendoSwitch:
                return "switch"
            case .pc:
                return "pc"
            case .mobile:
                return "mobile"
            }
        }
        
        var icon: String {
            switch self {
            case .playstation:
                return Icon.Console.playstation
            case .xbox:
                return Icon.Console.xbox
            case .nintendoSwitch:
                return Icon.Console.switch
            case .pc:
                return Icon.Console.pc
            case .mobile:
                return Icon.Console.mobile
            }
        }
        
        var backgroundIllustration: UIImage? {
            switch self {
            case .playstation:
                return UIImage(named: "playstationBackgroundIllustration")
            case .xbox:
                return UIImage(named: "xboxBackgroundIllustration")
            case .nintendoSwitch:
                return UIImage(named: "nintendoSwitchBackgroundIllustration")
            case .pc:
                return UIImage(named: "pcBackgroundIllustration")
            case .mobile:
                return UIImage(named: "mobileBackgroundIllustration")
            }
        }
    }
    
    enum Game: CaseIterable {
        case apex
        case codModernWarfare
        case csgo
        case dota2
        case fifa20
        case fortnite
        case gtav
        case lol
        case minecraft
        case overwatch
        case pubg
        case rainbowSixSiege
        case rocketLeague
        case valorant
        case roblox
        case rdr2
        case skate3
        case nba
        case animalCrossing



        var title: String {
            switch self {
            case .apex:
                return "Apex Legends"
            case .codModernWarfare:
                return "Call Of Duty MW"
            case .csgo:
                return "CS:GO"
            case .dota2:
                return "Dota 2"
            case .fifa20:
                return "FIFA 2020"
            case .fortnite:
                return "Fortnite"
            case .gtav:
                return "GTA V"
            case .lol:
                return "League Of Legends"
            case .minecraft:
                return "Minecraft"
            case .overwatch:
                return "Overwatch"
            case .pubg:
                return "PUBG"
            case .rainbowSixSiege:
                return "Rainbow Six Siege"
            case .rocketLeague:
                return "Rocket League"
            case .valorant:
                return "Valorant"
            case .roblox:
                return "Roblox"
            case .rdr2:
                return "RDR2"
            case .skate3:
                return "Skate 3"
            case .nba:
                return "2K20"
            case .animalCrossing:
                return "Animal Crossing"
            }
        }
        
        var stringValue: String {
            switch self {
            case .apex:
                return "apex"
            case .codModernWarfare:
                return "cod"
            case .csgo:
                return "counterstrikeglobaloffensive"
            case .dota2:
                return "dota2"
            case .fifa20:
                return "fifa20"
            case .fortnite:
                return "fortnite"
            case .gtav:
                return "gtav"
            case .lol:
                return "leagueoflegends"
            case .minecraft:
                return "minecraft"
            case .overwatch:
                return "overwatch"
            case .pubg:
                return "playerunknownsbattlegrounds"
            case .rainbowSixSiege:
                return "rainbowsix"
            case .rocketLeague:
                return "rocketleague"
            case .valorant:
                return "valorant"
            case .roblox:
                return "roblox"
            case .rdr2:
                return "reddeadredemption2"
            case .skate3:
                return "skate3"
            case .nba:
                return "nba"
            case .animalCrossing:
                return "animalcrossing"
            }
        }
        
        var icon: String {
            switch self {
            case .apex:
                return Icon.Game.apex
            case .codModernWarfare:
                return Icon.Game.modernWarfare
            case .csgo:
                return Icon.Game.csgo
            case .dota2:
                return Icon.Game.dota2
            case .fifa20:
                return Icon.Game.fifa20
            case .fortnite:
                return Icon.Game.fortnite
            case .gtav:
                return Icon.Game.gtav
            case .lol:
                return Icon.Game.lol
            case .minecraft:
                return Icon.Game.minecraft
            case .overwatch:
                return Icon.Game.overwatch
            case .pubg:
                return Icon.Game.pubg
            case .rainbowSixSiege:
                return Icon.Game.rainbowSixSiege
            case .rocketLeague:
                return Icon.Game.rocketLeague
            case .valorant:
                return Icon.Game.valorant
            case .roblox:
                return Icon.Game.roblox
            case .rdr2:
                return Icon.Game.rdr2
            case .skate3:
                return Icon.Game.skate3
            case .nba:
                return Icon.Game.nba
            case .animalCrossing:
                return Icon.Game.animalCrossing
            }
        }
        
        var backgroundIllustration: UIImage? {
            switch self {
            case .apex:
                return UIImage(named: "apexBackgroundIllustration")
            case .codModernWarfare:
                return UIImage(named: "modernWarfareBackgroundIllustration")
            case .csgo:
                return UIImage(named: "csgoBackgroundIllustration")
            case .dota2:
                return UIImage(named: "dota2BackgroundIllustration")
            case .fifa20:
                return UIImage(named: "fifa20BackgroundIllustration")
            case .fortnite:
                return UIImage(named: "fortniteBackgroundIllustration")
            case .gtav:
                return UIImage(named: "gtavBackgroundIllustration")
            case .lol:
                return UIImage(named: "lolBackgroundIllustration")
            case .minecraft:
                return UIImage(named: "minecraftBackgroundIllustration")
            case .overwatch:
                return UIImage(named: "overwatchBackgroundIllustration")
            case .pubg:
                return UIImage(named: "pubgBackgroundIllustration")
            case .rainbowSixSiege:
                return UIImage(named: "rainbowSixSiegeBackgroundIllustration")
            case .rocketLeague:
                return UIImage(named: "rocketLeagueBackgroundIllustration")
            case .valorant:
                return UIImage(named: "valorantBackgroundIllustration")
            case .roblox:
                return UIImage(named: "robloxBackgroundIllustration")
            case .rdr2:
                return UIImage(named: "rdr2BackgroundIllustration")
            case .skate3:
                return UIImage(named: "skate3BackgroundIllustration")
            case .nba:
                return UIImage(named: "2k20BackgroundIllustration")
            case .animalCrossing:
                return UIImage(named: "animalCrossingBackgroundIllustration")
            }
        }
            
        var backgroundColor: UIColor {
            switch self {
            case .apex:
                return UIColor(hex: 0xE03830)
            case .codModernWarfare:
                return UIColor(hex: 0x6F6862)
            case .csgo:
                return UIColor(hex: 0x2A3145)
            case .dota2:
                return UIColor(hex: 0xD43B3B)
            case .fifa20:
                return UIColor(hex: 0xFB2064)
            case .fortnite:
                return UIColor(hex: 0x9C1FDD)
            case .gtav:
                return UIColor(hex: 0x376134)
            case .lol:
                return UIColor(hex: 0x1A3069)
            case .minecraft:
                return UIColor(hex: 0x5EAB27)
            case .overwatch:
                return UIColor(hex: 0xE47434)
            case .pubg:
                return UIColor(hex: 0x5627A4)
            case .rainbowSixSiege:
                return UIColor(hex: 0x20303E)
            case .rocketLeague:
                return UIColor(hex: 0x0486DA)
            case .valorant:
                return UIColor(hex: 0xFD4454)
            case .roblox:
                return UIColor(hex: 0x38415E)
            case .rdr2:
                return UIColor(hex: 0xE30C15)
            case .skate3:
                return UIColor(hex: 0xE25125)
            case .nba:
                return UIColor(hex: 0x05648C)
            case .animalCrossing:
                return UIColor(hex: 0x47BA4B)
            }
        }

    }
    
    enum MetadataKey {
        case unset
        case username
        case bio
        case snapchat
        case instagram
        case twitch
        case youtube
        case tiktok
        case isAdmin
        case isMod
        case isPCAlpha
        case color
        case apnsToken
        case langLocale
        case streak
        case isPro
        case isGold

        var stringValue: String {
            switch self {
            case .unset:
                return "UNSET"
            case .username:
                return "username"
            case .bio:
                return "bio"
            case .snapchat:
                return "snap"
            case .instagram:
                return "insta"
            case .twitch:
                return "twitch"
            case .youtube:
                return "youtube"
            case .tiktok:
                return "tiktok"
            case .isAdmin:
                return "is_admin"
            case .isMod:
                return "is_mod"
            case .isPCAlpha:
                return "is_pcalpha"
            case .color:
                return "color"
            case .apnsToken:
                return "apns_token"
            case .langLocale:
                return "lang_locale"
            case .streak:
                return "streak_days_connected"
            case .isPro:
                return "is_pro"
            case .isGold:
                return "is_gold"
            }
        }
    
        var editTitle: String? {
            switch self {
            case .username:
                return LocalizedString.profileUsernameTitle
            case .bio:
                return LocalizedString.profileBioTitle
            case .snapchat:
                return Icon.Social.snapchat
            case .instagram:
                return Icon.Social.instagram
            case .twitch:
                return Icon.Social.twitch
            case .youtube:
                return Icon.Social.youtube
            case .tiktok:
                return Icon.Social.tiktok
            default:
                return nil
            }
        }
        
        var placeHolder: String? {
            switch self {
            case .username:
                return LocalizedString.username.capitalized
            case .bio:
                return LocalizedString.profileBio.capitalized
            case .snapchat:
                return "@snapchat"
            case .instagram:
                return "@instagram"
            case .twitch:
                return "@twitch"
            case .youtube:
                return "@youtube"
            case .tiktok:
                return "@tiktok"
            default:
                return nil
            }
        }
    }
}
