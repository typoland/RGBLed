//
//  ColorLed.swift
//  
//
//  Created by Łukasz Dziedzic on 09/04/2025.
//
struct RGB<T> {
    var r: T
    var g: T
    var b: T
}

struct RGBLed {
    enum Error: Swift.Error {
        case ledcConfigError(String)
        case channelConfigurationFailed(String)
    }
    
    //let channels: Channels
    //let setup: Setup
    
    var ledcTimerConfig: ledc_timer_config_t
    var redChannel: ledc_channel_config_t
    var greenChannel: ledc_channel_config_t
    var blueChannel: ledc_channel_config_t
    
    init(channels: RGB<ledc_channel_t>, gpios: RGB<Int32>) 
    throws (RGBLed.Error) 
    {
        var config = ledc_timer_config_t(
            speed_mode:      LEDC_LOW_SPEED_MODE,
            duty_resolution: LEDC_TIMER_13_BIT,
            timer_num:       LEDC_TIMER_1,
            freq_hz:         5_000,
            clk_cfg:         LEDC_AUTO_CLK,
            deconfigure: false
        )
        switch runEsp ({ ledc_timer_config(&config) }) {
        case .success: break
        case .failure(let s): throw Error.ledcConfigError(s)
        }

        let red   = try configureChannel(
            channels.r, 
            gpio: gpios.r, 
            timerConfig: config)
        let green = try configureChannel(
            channels.g, 
            gpio: gpios.g, 
            timerConfig: config)
        let blue  = try configureChannel(
            channels.b, 
            gpio: gpios.b,
            timerConfig: config)
        
        self.ledcTimerConfig = config
        self.redChannel   = red
        self.greenChannel = green
        self.blueChannel  = blue
        
        func configureChannel(_ channel: ledc_channel_t, 
                                      gpio: Int32, 
                                      timerConfig: ledc_timer_config_t) 
        throws (RGBLed.Error) -> ledc_channel_config_t 
        {
            var ledcChannelConfig = ledc_channel_config_t(
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
                throw Error.channelConfigurationFailed(s)
            }
        } 
    }
    
    func setColor(red: UInt8, green: UInt8, blue: UInt8) {
        setDuty(channel: greenChannel, duty: green)
        setDuty(channel: blueChannel,  duty: blue)
        setDuty(channel: redChannel,   duty: red)
    }
    
    func setColor(_ color: RGBColor) {
        setColor(red: color.red, green: color.green, blue: color.blue)
    }
    
    private func setDuty(channel: ledc_channel_config_t, duty: UInt8) {
        let dutyValue = UInt32(duty) * ((1 << ledcTimerConfig.duty_resolution.rawValue) - 1) / 255
        ledc_set_duty(channel.speed_mode, channel.channel, dutyValue)
        ledc_update_duty(channel.speed_mode, channel.channel)
    }
    
  
}

