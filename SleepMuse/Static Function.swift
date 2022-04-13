//
//  Static Function.swift
//  SleepMuse
//
//  Created by William Chrisandy on 13/04/22.
//

import UIKit

class StaticFunction
{
    static func setUpCompleted()
    {
        UserDefaults.standard.set(true, forKey: keyFirstTime)
        //Insert dummy data
    }
}
