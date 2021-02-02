//
//  Haptic Feedback.swift
//  CircleBar
//
//  Created by Gokul Nair on 02/02/21.
//

import Foundation

class HapticFeedback{
    //Declaring class as static
    static let Feedback = HapticFeedback()
    func hapticFeedback(){
        print("feedback")
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
