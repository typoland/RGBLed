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
}
