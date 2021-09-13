//
//  CicularProgressBar.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit

class CircularProgressBar {
    
    public static func circularProgress(progressCircleBarView: KDCircularProgress, actualData: Int, goalData: Int, firstColor: UIColor) {
        
        progressCircleBarView.startAngle = -90
        progressCircleBarView.progressThickness = 0.15
        progressCircleBarView.trackThickness = 0.15
        progressCircleBarView.trackColor = UIColor(displayP3Red: 155/256, green: 155/256, blue: 155/256, alpha: 0.8)
        progressCircleBarView.clockwise = true
        progressCircleBarView.gradientRotateSpeed = 2
        progressCircleBarView.roundedCorners = true
        progressCircleBarView.glowMode = .forward
        progressCircleBarView.glowAmount = 0
        progressCircleBarView.set(colors: firstColor)
        
        var angle: Double
        if actualData >= goalData {
            angle = 360.0
        } else {
            angle = (Double(actualData)/Double(goalData))*360.0
        }
        
        progressCircleBarView.animate(toAngle: angle, duration: 1, completion: nil)
    }
    
    public static func halfCircularProgress(progressCircleBarView: KDCircularProgress, actualData: Int, goalData: Int, firstColor: UIColor, secondColor: UIColor) {
        progressCircleBarView.startAngle = -190
        progressCircleBarView.progressThickness = 0.25
        progressCircleBarView.trackThickness = 0.25
        progressCircleBarView.trackColor = UIColor(displayP3Red: 155/256, green: 155/256, blue: 155/256, alpha: 0.8)
        progressCircleBarView.clockwise = true
        progressCircleBarView.gradientRotateSpeed = 2
        progressCircleBarView.roundedCorners = false
        progressCircleBarView.glowMode = .forward
        progressCircleBarView.glowAmount = 0
        progressCircleBarView.set(colors: firstColor ,secondColor)
        
        var angle: Double
        //If actual data equals zero make graph 0
        if actualData > 0 {
            if actualData >= goalData{
                angle = 360.0
            } else {
                angle = (Double(actualData)/Double(goalData))*195.0
            }
        } else {
            angle = 0
        }
        
        progressCircleBarView.animate(toAngle: angle, duration: 1, completion: nil)
    }
    
    public static func circularProgressDouble(progressCircleBarView: KDCircularProgress, actualData: Double, goalData: Double, firstColor: UIColor, secondColor: UIColor) {
        
        progressCircleBarView.startAngle = -90
        progressCircleBarView.progressThickness = 0.15
        progressCircleBarView.trackThickness = 0.15
        progressCircleBarView.trackColor = UIColor(displayP3Red: 155/256, green: 155/256, blue: 155/256, alpha: 0.8)
        progressCircleBarView.clockwise = true
        progressCircleBarView.gradientRotateSpeed = 2
        progressCircleBarView.roundedCorners = true
        progressCircleBarView.glowMode = .forward
        progressCircleBarView.glowAmount = 0.9
        progressCircleBarView.set(colors: firstColor ,secondColor)
        
        var angle: Double
        if actualData >= goalData {
            angle = 360.0
        } else {
            angle = (Double(actualData)/Double(goalData))*360.0
        }
        
        progressCircleBarView.animate(toAngle: angle, duration: 1, completion: nil)
    }
    
    public static func halfCircularProgressDouble(progressCircleBarView: KDCircularProgress, actualData: Double, goalData: Double, firstColor: UIColor, secondColor: UIColor) {
        
        progressCircleBarView.startAngle = -180
        progressCircleBarView.progressThickness = 0.25
        progressCircleBarView.trackThickness = 0.25
        progressCircleBarView.trackColor = UIColor(displayP3Red: 155/256, green: 155/256, blue: 155/256, alpha: 0.8)
        progressCircleBarView.clockwise = true
        progressCircleBarView.gradientRotateSpeed = 2
        progressCircleBarView.roundedCorners = false
        progressCircleBarView.glowMode = .forward
        progressCircleBarView.glowAmount = 0
        progressCircleBarView.set(colors: firstColor ,secondColor)
        
        var angle: Double
        if actualData >= goalData {
            angle = 360.0
        } else {
            angle = (Double(actualData)/Double(goalData))*180.0
        }
        
        progressCircleBarView.animate(toAngle: angle, duration: 1, completion: nil)
    }
}
