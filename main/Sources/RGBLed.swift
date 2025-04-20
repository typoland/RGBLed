
struct RGBLed: PWMLed {

    var timerConfig: LedTimerConfig
    var channelsConfig: RGB<LedChannelConfig>
    
    init(channels: RGB<LedChannelAssign>) 
    throws (LedError) 
    {
        self.timerConfig = try Self.configureTimer()
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
        setDuty(channel: channelsConfig.r, duty: r)
        setDuty(channel: channelsConfig.g, duty: g)
        setDuty(channel: channelsConfig.b, duty: b)
    }
    
    func setColor(_ color: RGBColor) {
        setColor(r: color.r, g: color.g, b: color.b)
    }
}

