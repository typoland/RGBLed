//
//  RGBLed+Fade.swift
//  
//
//  Created by Łukasz Dziedzic on 18/04/2025.
//
typealias FadeParameters = ledc_fade_param_config_t

extension FadeParameters {
    static func pulse(steps: UInt32, up: UInt32, down: UInt32) -> [FadeParameters] {
        let maxDuty: UInt32 = (1 << 13) - 1 //
        let fadeUp = ledc_fade_param_config_t(
            dir: 1, 
            cycle_num: up, 
            scale: maxDuty/steps,
            step_num: steps
        )   
        let fadeDn = ledc_fade_param_config_t(
            dir: 0, 
            cycle_num: down, 
            scale: maxDuty/steps,
            step_num: steps
        )  
        return [fadeUp, fadeDn]
    }
}

extension LedChannelConfig {
    
    var rawDuty: UInt32 {
        ledc_get_duty( speed_mode, channel )
    }
    
    func pulse(_ params: inout [FadeParameters]) {
        ledc_set_multi_fade_and_start (
            speed_mode, // speed_mode
            channel,    // channel
            UInt32(0),         //Set the start of the gradient duty, the range of duty setting is [0, (2**duty_resolution)]
            &params,           //Pointer to the array of fade parameters for a multi-fade
            UInt32(params.count),//list_len -- Length of the fade_params_list, i.e. number of fade ranges for a multi-fade (1 - SOC_LEDC_GAMMA_CURVE_FADE_RANGE_MAX)
            LEDC_FADE_NO_WAIT
        )
    }
    
    func fade(to newRawDuty: UInt32, ms time: Int32) {
        switch runEsp({ ledc_set_fade_with_time (
            speed_mode,  //speed_mode
            channel,    // channel
            newRawDuty, //duty
            time)       //step_num  Set the number of the gradient
        }) {
        case .failure(let s): print ("\(s)")
        default: break
        }
        switch runEsp({ 
            ledc_fade_start (
                speed_mode,
                channel,
                LEDC_FADE_NO_WAIT)}) {
        case .failure(let s): print ("\(s)")
        default: break
        }
    }
}

extension LedTimerConfig {
    func rawDuty<T:FixedWidthInteger>(_ duty:T) -> UInt32 {
        UInt32(duty) * ((1 << duty_resolution.rawValue) - 1) / UInt32(T.max)
    }
    func dutyFrom<T:FixedWidthInteger>(raw: UInt32) -> T {
        let i = (raw * UInt32(T.max) / (1 << duty_resolution.rawValue) + 1)
        return T(i)
    }
}
