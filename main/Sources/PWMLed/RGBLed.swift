struct RGBLed: PWMLed {

    var timerConfig: LedTimerConfig
    var channelsConfig: RGB<LedChannelConfig>
    
    init(channels: RGB<LedChannelAssign>,
         speedMode: ledc_mode_t = LEDC_LOW_SPEED_MODE,
         dutyResolution: ledc_timer_bit_t = LEDC_TIMER_13_BIT,
         timerNumber: ledc_timer_t = LEDC_TIMER_1,
         frequency: UInt32 = 5000,
         clockConfig: ledc_clk_cfg_t = LEDC_AUTO_CLK,
         deconfigure: Bool = false
    ) 
    throws (LedError) 
    {
        self.timerConfig = try Self.configureTimer(
            speedMode: speedMode,
            dutyResolution: dutyResolution,
            timerNumber: timerNumber,
            frequency: frequency,
            clockConfig: clockConfig,
            deconfigure: deconfigure
        )
        self.channelsConfig = RGB(
            r: try Self.configureChannel(
                channels.r.channel, 
                gpio: channels.r.gpio, 
                timerConfig: timerConfig),
            g: try Self.configureChannel(
                channels.g.channel, 
                gpio: channels.g.gpio, 
                timerConfig: timerConfig),
            b: try Self.configureChannel(
                channels.b.channel, 
                gpio: channels.b.gpio,
                timerConfig: timerConfig)
            )
    }
    
    func setColor(r: UInt8, g: UInt8, b: UInt8) {
        setDuty(config: channelsConfig.r, duty: r)
        setDuty(config: channelsConfig.g, duty: g)
        setDuty(config: channelsConfig.b, duty: b)
    }
    
    func fadeToColor(_ color: RGBColor, ms time: Int32 = 1500) {
        channelsConfig.r.fade(to: timerConfig.rawDuty(color.r), ms: time)
        channelsConfig.g.fade(to: timerConfig.rawDuty(color.g), ms: time)
        channelsConfig.b.fade(to: timerConfig.rawDuty(color.b), ms: time)
    }
    
    var color: RGBColor {
        let r = getDuty(config: channelsConfig.r)
        let g = getDuty(config: channelsConfig.g)
        let b = getDuty(config: channelsConfig.b)
        return RGBColor(r:r, g:g, b:b)
    } 
    func setColor(_ color: RGBColor) {
        setColor(r: color.r, g: color.g, b: color.b)
    }
}

