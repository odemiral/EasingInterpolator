//
//  EasingProvider.swift
//  EasingInterpolator
//
//  Created by Onur Demiralay on 2022-04-13.
//  Copyright © 2022 Onur Demiralay. All rights reserved.
//

import Foundation

/**
 * The Easing class provides a collection of ease functions. It does not use the standard 4 param
 * ease signature. Instead it uses a single param which indicates the current linear ratio (0 to 1) of the tween.
 */
class EasingProvider {
    /**
     * @param ease            Easing type
     * @param elapsedTimeRate Elapsed time / Total time
     * @return easedValue
     */
    static func get(_ ease:Ease, _ elapsedTimeRate:Float) -> Float {
        var elapsedTimeRateV = elapsedTimeRate
        switch (ease) {
            case .LINEAR:
                return elapsedTimeRateV
            case .QUAD_IN:
                return getPowIn(elapsedTimeRateV, 2)
            case .QUAD_OUT:
                return getPowOut(elapsedTimeRateV, 2)
            case .QUAD_IN_OUT:
                return getPowInOut(elapsedTimeRateV, 2)
            case .CUBIC_IN:
                return getPowIn(elapsedTimeRateV, 3)
            case .CUBIC_OUT:
                return getPowOut(elapsedTimeRateV, 3)
            case .CUBIC_IN_OUT:
                return getPowInOut(elapsedTimeRateV, 3)
            case .QUART_IN:
                return getPowIn(elapsedTimeRateV, 4)
            case .QUART_OUT:
                return getPowOut(elapsedTimeRateV, 4)
            case .QUART_IN_OUT:
                return getPowInOut(elapsedTimeRateV, 4)
            case .QUINT_IN:
                return getPowIn(elapsedTimeRateV, 5)
            case .QUINT_OUT:
                return getPowOut(elapsedTimeRateV, 5)
            case .QUINT_IN_OUT:
                return getPowInOut(elapsedTimeRateV, 5)
            case .SINE_IN:
                return (Float) (1 - cos(elapsedTimeRateV * Float.pi / 2))
            case .SINE_OUT:
                return sinf(elapsedTimeRateV * Float.pi / 2)
            case .SINE_IN_OUT:
                return (Float) (-0.5 * (cos(Float.pi * elapsedTimeRateV) - 1))
            case .BACK_IN:
                return (Float) (elapsedTimeRateV * elapsedTimeRateV * ((1.7 + 1) * elapsedTimeRateV - 1.7))
            case .BACK_OUT:
                return (Float) ((elapsedTimeRateV - 1) * (elapsedTimeRateV - 1) * ((1.7 + 1) * (elapsedTimeRateV - 1) + 1.7) + 1)
            case .BACK_IN_OUT:
                return getBackInOut(elapsedTimeRateV, 1.7)
            case .CIRC_IN:
                return -1 * (sqrt(1 - elapsedTimeRateV * elapsedTimeRateV) - 1)
            case .CIRC_OUT:
                return sqrt(1 - (elapsedTimeRateV - 1) * (elapsedTimeRateV - 1))
            case .CIRC_IN_OUT:
                elapsedTimeRateV *= 2
                if (elapsedTimeRateV < 1) {
                    return (Float) (-0.5 * (sqrt(1 - elapsedTimeRateV * elapsedTimeRateV) - 1))
                }
                return (Float) (0.5 * (sqrt(1 - (elapsedTimeRateV - 2) * (elapsedTimeRateV - 2)) + 1))
            case .BOUNCE_IN:
                return getBounceIn(elapsedTimeRateV)
            case .BOUNCE_OUT:
                return getBounceOut(elapsedTimeRateV)
            case .BOUNCE_IN_OUT:
                if (elapsedTimeRate < 0.5) {
                    return getBounceIn(elapsedTimeRateV * 2) * 0.5
                }
                return getBounceOut(elapsedTimeRateV * 2 - 1) * 0.5 + 0.5
            case .ELASTIC_IN:
                return getElasticIn(elapsedTimeRateV, 1, 0.3)
                
            case .ELASTIC_OUT:
                return getElasticOut(elapsedTimeRateV, 1, 0.3)
                
            case .ELASTIC_IN_OUT:
                return getElasticInOut(elapsedTimeRateV, 1, 0.45)
                
            case .EASE_IN_EXPO:
                return powf(2, 10 * (elapsedTimeRateV - 1))
            case .EASE_OUT_EXPO:
                return -1 * (powf(2, -10 * elapsedTimeRateV) + 1)
            case .EASE_IN_OUT_EXPO:
                elapsedTimeRateV *= 2
                if ((elapsedTimeRateV) < 1) {
                    return powf(2, 10 * (elapsedTimeRateV - 1)) * 0.5
                }
                return (Float) (-1 * powf(2, -10 * (elapsedTimeRateV - 1)) + 2) * 0.5
            default:
                return elapsedTimeRateV
                
        }
        
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param pow             pow The exponent to use (ex. 3 would return a cubic ease).
     * @return easedValue
     */
    static func getPowIn(_ elapsedTimeRate:Float, _ power: Float) -> Float {
        return powf(elapsedTimeRate, power)
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param pow             pow The exponent to use (ex. 3 would return a cubic ease).
     * @return easedValue
     */
    static func getPowOut(_ elapsedTimeRate:Float, _ power: Float) -> Float {
        return (Float) (1 - powf(1 - elapsedTimeRate, power))
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param pow             pow The exponent to use (ex. 3 would return a cubic ease).
     * @return easedValue
     */
    static func getPowInOut(_ elapsedTimeRate:Float, _ power: Float) -> Float {
        var elapsedTimeRateV = elapsedTimeRate
        elapsedTimeRateV *= 2
        if (elapsedTimeRateV < 1) {
            return (Float) (0.5 * pow(elapsedTimeRateV, power))
        }
        return (Float) (1 - 0.5 * abs(pow(2 - elapsedTimeRateV, power)))
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param amount          amount The strength of the ease.
     * @return easedValue
     */
    static func getBackInOut(_ elapsedTimeRate:Float, _ amount: Float) -> Float {
        var elapsedTimeRateV = elapsedTimeRate
        let amountV = amount * 1.525
        elapsedTimeRateV *= 2
        if (elapsedTimeRateV < 1) {
            return (Float) (0.5 * (elapsedTimeRate * elapsedTimeRate * ((amountV + 1) * elapsedTimeRate - amountV)))
        }
        return (Float) (0.5 * ((elapsedTimeRate - 2) * elapsedTimeRate * ((amountV + 1) * elapsedTimeRate - 2 + amountV) + 2))
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @return easedValue
     */
    static func getBounceIn(_ elapsedTimeRate:Float) -> Float{
        return 1 - getBounceOut(1 - elapsedTimeRate)
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @return easedValue
     */
    static func getBounceOut(_ elapsedTimeRate:Float) -> Float {
        if (elapsedTimeRate < 1 / 2.75) {
            return (Float) (7.5625 * elapsedTimeRate * elapsedTimeRate)
        } else if (elapsedTimeRate < 2 / 2.75) {
            return (Float) (7.5625 * ((elapsedTimeRate - 1.5) / 2.75) * (elapsedTimeRate - 1.5) + 0.75)
        } else if (elapsedTimeRate < 2.5 / 2.75) {
            return (Float) (7.5625 * ((elapsedTimeRate - 2.25) / 2.75) * (elapsedTimeRate - 2.25) + 0.9375)
        } else {
            return (Float) (7.5625 * ((elapsedTimeRate - 2.625) / 2.75) * (elapsedTimeRate - 2.625) + 0.984375)
        }
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param amplitude       Amplitude of easing
     * @param period          Animation of period
     * @return easedValue
     */
    static func getElasticIn(_ elapsedTimeRate:Float, _ amplitude: Float, _ period: Float) -> Float {
        if (elapsedTimeRate == 0 || elapsedTimeRate == 1) { return elapsedTimeRate}
        let pi2 = Float.pi * 2
        let s = period / pi2 * asin(1 / amplitude)
        return  -(amplitude * powf(2, 10 * (elapsedTimeRate - 1)) * sin((elapsedTimeRate - s - 1) * pi2 / period))
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param amplitude       Amplitude of easing
     * @param period          Animation of period
     * @return easedValue
     */
    static func getElasticOut(_ elapsedTimeRate:Float, _ amplitude:Float, _ period: Float) -> Float {
        if (elapsedTimeRate == 0 || elapsedTimeRate == 1) { return elapsedTimeRate }
        let pi2 = Float.pi * 2
        let s = period / pi2 * asin(1 / amplitude)
        return (Float) (amplitude * powf(2, -10 * elapsedTimeRate) * sin((elapsedTimeRate - s) * pi2 / period) + 1)
    }
    
    /**
     * @param elapsedTimeRate Elapsed time / Total time
     * @param amplitude       Amplitude of easing
     * @param period          Animation of period
     * @return easedValue
     */
    static func getElasticInOut(_ elapsedTimeRate:Float, _ amplitude: Float, _ period: Float) -> Float {
        let pi2 = Float.pi * 2
        var elapsedTimeRateV = elapsedTimeRate
        
        let s = period / pi2 * asin(1 / amplitude)
        elapsedTimeRateV *= 2
        if ((elapsedTimeRateV) < 1) {
            return (Float) (-0.5 * (amplitude * powf(2, 10 * (elapsedTimeRateV - 1)) * sin((elapsedTimeRate - 1 - s) * pi2 / period)))
        }
        return (Float) (amplitude * powf(2, -10 * (elapsedTimeRateV - 1)) * sin((elapsedTimeRateV - 1 - s) * pi2 / period) * 0.5 + 1)
        
    }
}
