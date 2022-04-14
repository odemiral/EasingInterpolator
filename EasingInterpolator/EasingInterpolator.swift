//
//  EasingInterpolator.swift
//  EasingInterpolator
//
//  Created by Onur Demiralay on 2022-04-13.
//  Copyright © 2022 Onur Demiralay. All rights reserved.
//

import Foundation

class EasingInterpolator {
    private let ease: Ease
    
    init(ease: Ease) {
        self.ease = ease
    }
    
    func getEase() -> Ease {
        return ease;
    }
    
    func interpolate(elapsedTimeRate: Float) -> Float {
        return EasingProvider.get(self.ease, elapsedTimeRate)
    }
    
}
