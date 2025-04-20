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
    
    func setBrightness(_ value: UInt8) {
        setDuty(channel: channelConfig, duty: value)
    }
}
