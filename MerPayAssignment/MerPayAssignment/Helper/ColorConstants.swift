//
//  ColorConstants.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/11/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

enum ColorType {
    case dark
    case light
    
    func getInvertColor() -> UIColor {
        switch self {
        case .light     : return ColorHex.black.getColor()
        case .dark      : return ColorHex.white.getColor()
        }
    }
}

enum ColorHex : String {
    case white          = "FFFFFF"
    case black          = "000000"
    //RED
    case softRed        = "EC644B"
    case cinnabar       = "F03434"
    case waxFlower      = "F1A9A0"
    case monza          = "CF000F"
    case razzmatazz     = "DB0A5B"
    case newYorkPink    = "E08283"
    case sunglo         = "E26A6A"
    
    //BLUE
    case lavenderPurple = "947CB0"
    case snuff          = "DCC6E0"
    case rebeccapurple  = "663399"
    case honeyFlower    = "674172"
    case wistful        = "AEA8D3"
    case plum           = "913D88"
    case lightWisteria  = "BE90D4"
    case sherpaBlue     = "013243"
    case aliceBlue      = "E4F1FE"
    case shakespeare    = "52B3D9"
    case jaksonsPurple  = "1F3A93"
    case ebonyBlue      = "1971C2"
    
    //Green
    case summerGreen    = "91B496"
    case mediumTurquoise = "4ECDC4"
    case gossip         = "87D37C"
    case eucalyptus     = "26A65B"
    case madang         = "C8F7C5"
    case niagara        = "16A085"
    case salem          = "1E824C"
    
    //Orange
    case capeHoney      = "FDE3A7"
    case california     = "F89406"
    case crusta         = "F2784B"
    case butterCup      = "F39C12"
    case sandStorm      = "F9BF3B"
    
    //Gray
    case silverSand     = "BDC3C7"
    case silver         = "BFBFBF"
    case lightGray      = "E8E8E8"
    case whiteSmoke     = "#F5F5F5"
    
    func getColorType() -> ColorType {
        switch self {
        case .white         : return .light
        //RED
        case .softRed       : return .light
        case .cinnabar      : return .light
        case .waxFlower     : return .light
        case .monza         : return .dark
        case .razzmatazz    : return .dark
        case .newYorkPink   : return .light
        case .sunglo        : return .light
            
        //BLUE
        case .lavenderPurple : return .light
        case .snuff          : return .light
        case .rebeccapurple  : return .dark
        case .honeyFlower    : return .dark
        case .wistful        : return .light
        case .plum           : return .dark
        case .lightWisteria  : return .light
        case .sherpaBlue     : return .dark
        case .aliceBlue      : return .light
        case .shakespeare    : return .light
        case .ebonyBlue      : return .light
            
        //Green
        case .summerGreen    : return .dark
        case .mediumTurquoise: return .light
        case .gossip         : return .light
        case .eucalyptus     : return .light
        case .madang         : return .light
        case .niagara        : return .light
        case .salem          : return .dark
            
        //Orange
        case .capeHoney      : return .light
        case .california     : return .light
        case .crusta         : return .light
        case .butterCup      : return .light
        case .sandStorm      : return .light
            
        //Gray
        case .whiteSmoke     : return .light
        case .silverSand     : return .light
        case .silver         : return .light
        case .black          : return .dark
        case .jaksonsPurple  : return .dark
        case .lightGray      : return .light
        }
    }
    
    func getColor() -> UIColor {
        return UIColor(colorHex: self)
    }
    
    static func getRandom() -> ColorHex {
        let randomNumber = Int(arc4random()) % allHexColors.count
        return allHexColors[randomNumber]
    }
}

let allHexColors : [ColorHex] = [
    .white,
    .softRed,
        .cinnabar,
    .waxFlower,
    .monza,
    .razzmatazz,
    .newYorkPink,
    .sunglo,
    .lavenderPurple,
    .snuff,
    .rebeccapurple,
    .honeyFlower,
    .wistful,
    .plum,
    .lightWisteria,
    .sherpaBlue,
    .aliceBlue,
    .shakespeare,
    .summerGreen,
    .mediumTurquoise,
    .gossip,
    .eucalyptus,
    .madang,
    .niagara,
    .salem,
    .capeHoney,
    .california,
    .crusta,
    .butterCup,
    .sandStorm,
    .whiteSmoke,
    .silverSand,
    .silver
]
