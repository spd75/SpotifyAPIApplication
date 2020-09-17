//
//  Constants.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/12/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    public static let screenRect = UIScreen.main.bounds
    public static let screenWidth = screenRect.size.width
    public static let screenHeight = screenRect.size.height
    
    public static let size = (Constants.screenWidth * 0.48)
    
    public static let mainViewPadding = Constants.screenHeight * 0.025 + 4
    public static let buttonHeight = Constants.screenHeight * 0.038 + 30
    public static let buttonCornerRadius = (Constants.screenHeight * 0.038 + 30) / 2
    
    public static let searchTableHeight = CGFloat(Constants.screenWidth * 0.7 + 145)
    public static let playlistTableHeight: CGFloat = 290
    
    
    
    public static let lightGray = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1).cgColor
    public static let darkerGray = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1).cgColor
    
    public static let lightGray2 = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1).cgColor
    public static let darkerGray2 = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1).cgColor
    
    public static let spotifyGreen = UIColor(red: 91/255, green: 190/255, blue: 100/255, alpha: 1)
    public static let spotifyLightGreen = UIColor(red: 115/255, green: 218/255, blue: 119/255, alpha: 1)


    
    public static let mtSerLight10 = UIFont(name: "Montserrat-Light", size: 10)
    public static let mtSerReg10 = UIFont(name: "Montserrat-Regular", size: 10)
    public static let mtSerMed10 = UIFont(name: "Montserrat-Medium", size: 10)
    public static let mtSerSemiBold10 = UIFont(name: "Montserrat-SemiBold", size: 10)
    public static let mtSerBold10 = UIFont(name: "Montserrat-Bold", size: 10)
    
    
    public static let mtSerLight14 = UIFont(name: "Montserrat-Light", size: 14)
    public static let mtSerReg14 = UIFont(name: "Montserrat-Regular", size: 14)
    public static let mtSerMed14 = UIFont(name: "Montserrat-Medium", size: 14)
    public static let mtSerSemiBold14 = UIFont(name: "Montserrat-SemiBold", size: 14)
    public static let mtSerBold14 = UIFont(name: "Montserrat-Bold", size: 14)
    
    
    public static let mtSerLight20 = UIFont(name: "Montserrat-Light", size: 20)
    public static let mtSerReg20 = UIFont(name: "Montserrat-Regular", size: 20)
    public static let mtSerMed20 = UIFont(name: "Montserrat-Medium", size: 20)
    public static let mtSerSemiBold20 = UIFont(name: "Montserrat-SemiBold", size: 20)
    public static let mtSerBold20 = UIFont(name: "Montserrat-Bold", size: 20)
    
    public static let mtSerLight24 = UIFont(name: "Montserrat-Light", size: 24)
    public static let mtSerReg24 = UIFont(name: "Montserrat-Regular", size: 24)
    public static let mtSerMed24 = UIFont(name: "Montserrat-Medium", size: 24)
    public static let mtSerSemiBold24 = UIFont(name: "Montserrat-SemiBold", size: 24)
    public static let mtSerBold24 = UIFont(name: "Montserrat-Bold", size: 24)
    
    public static let mtSerLight28 = UIFont(name: "Montserrat-Light", size: 28)
    public static let mtSerReg28 = UIFont(name: "Montserrat-Regular", size: 28)
    public static let mtSerMed28 = UIFont(name: "Montserrat-Medium", size: 28)
    public static let mtSerSemiBold28 = UIFont(name: "Montserrat-SemiBold", size: 28)
    public static let mtSerBold28 = UIFont(name: "Montserrat-Bold", size: 28)
    
    public static let mtSerLight32 = UIFont(name: "Montserrat-Light", size: 32)
    public static let mtSerReg32 = UIFont(name: "Montserrat-Regular", size: 32)
    public static let mtSerMed32 = UIFont(name: "Montserrat-Medium", size: 32)
    public static let mtSerSemiBold32 = UIFont(name: "Montserrat-SemiBold", size: 32)
    public static let mtSerBold32 = UIFont(name: "Montserrat-Bold", size: 32)
    
    
    public static func getTextFont() -> UIFont {
        if Constants.screenHeight < 600 {
            return UIFont(name: "Montserrat-Regular", size: 18)!
        }
        return Constants.mtSerReg20!
    }
    
}
