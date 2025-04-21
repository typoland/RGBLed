typealias LedTimerConfig = ledc_timer_config_t

extension LedTimerConfig {
    func rawDuty<T:FixedWidthInteger>(_ duty:T) -> UInt32 {
        UInt32(duty) * ((1 << duty_resolution.rawValue) - 1) / UInt32(T.max)
    }
    func dutyFrom<T:FixedWidthInteger>(raw: UInt32) -> T {
        let i = (raw * UInt32(T.max) / (1 << duty_resolution.rawValue) + 1)
        return T(i)
    }
}
