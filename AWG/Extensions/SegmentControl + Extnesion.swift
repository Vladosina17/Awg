//
//  SegmentControl + Extnesion.swift
//  AWG
//
//  Created by Влад Барченков on 16.05.2021.
//

import UIKit

class NoSwipeSegmentedControl: UISegmentedControl {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

