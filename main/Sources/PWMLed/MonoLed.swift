struct MonchromeLed: PWMLed {

    var timerConfig: LedTimerConfig
    var channelConfig: LedChannelConfig
    
    init(channel: LedChannelAssign) 
    throws (LedError) 
    {
        self.timerConfig = try Self.configureTimer()
        self.channelConfig = try Self.configureChannel(
                channel.channel, 
                gpio: channel.gpio, 
                timerConfig: timerConfig
        )
    }
    
    func setBrightness(_ value: ColorValue) {
        setDuty(config: channelConfig, duty: value)
    }
    func fadeTo(_ brightness: ColorValue, ms time: Int32 = 500) {
        channelConfig.fade(to: timerConfig.rawDuty(brightness), ms: time)
    }
}
