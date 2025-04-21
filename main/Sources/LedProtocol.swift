enum LedError: Swift.Error {
    case timerConfigurationFailed(String)
    case channelConfigurationFailed(String)
}

typealias LedTimerConfig = ledc_timer_config_t
typealias LedChannelConfig = ledc_channel_config_t

protocol PWMLed {
    var timerConfig: LedTimerConfig {get set}
}



extension PWMLed {
    func setDuty(config: LedChannelConfig, duty: UInt8) {
        //let dutyValue = UInt32(duty) * ((1 << timerConfig.duty_resolution.rawValue) - 1) / 255
        let rawDuty = timerConfig.rawDuty(duty)
        //print ("in: \(duty)->\(rawDuty)")
        ledc_set_duty(config.speed_mode, config.channel, rawDuty)
        ledc_update_duty(config.speed_mode, config.channel)
    }
    
    func getDuty(config: LedChannelConfig) -> UInt8 {
        timerConfig.dutyFrom(raw: config.rawDuty)
    }
    
    static func configureTimer(
        speedMode: ledc_mode_t = LEDC_LOW_SPEED_MODE,
        dutyResolution: ledc_timer_bit_t = LEDC_TIMER_13_BIT,
        timerNumber: ledc_timer_t =  LEDC_TIMER_1,
        frequency: UInt32 = 5000,
        clockConfig: ledc_clk_cfg_t = LEDC_AUTO_CLK,
        deconfigure: Bool = false
    ) throws (LedError) -> LedTimerConfig {
        
        var config = LedTimerConfig(
            speed_mode:      speedMode,
            duty_resolution: dutyResolution,
            timer_num:       timerNumber,
            freq_hz:         frequency,
            clk_cfg:         clockConfig,
            deconfigure:     deconfigure
        )
        switch runEsp ({ ledc_timer_config(&config) }) {
        case .success: return config
        case .failure(let s): throw LedError.timerConfigurationFailed(s)
        }
        
    }
    
    static func configureChannel(_ channel: ledc_channel_t, 
                                 gpio: Int32, 
                                 timerConfig: ledc_timer_config_t) 
    throws (LedError) -> LedChannelConfig {
        var ledcChannelConfig = LedChannelConfig(
            gpio_num:   gpio,
            speed_mode: timerConfig.speed_mode,
            channel:    channel,
            intr_type:  LEDC_INTR_FADE_END,//LEDC_INTR_DISABLE,
            timer_sel:  timerConfig.timer_num,
            duty:  0,
            hpoint: 0,
            sleep_mode: LEDC_SLEEP_MODE_NO_ALIVE_NO_PD,
            flags: .init()
        )
        switch runEsp ({ledc_channel_config(&ledcChannelConfig)}) {
        case .success: return ledcChannelConfig
        case .failure(let s): 
            throw LedError.channelConfigurationFailed(s)
        }
    } 
}
