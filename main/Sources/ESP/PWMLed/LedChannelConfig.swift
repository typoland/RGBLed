
typealias LedChannelConfig = ledc_channel_config_t

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
