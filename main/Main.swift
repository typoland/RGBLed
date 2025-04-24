
@_cdecl("app_main")
func app_main() {
    do {
        try Zigbee.start()
    } catch  {
        print ("Zigbee start Failed")
    }
    
    let rgbLedChannels = RGB (
        r: LedChannelAssign(channel: LEDC_CHANNEL_3, gpio: 22),
        g: LedChannelAssign(channel: LEDC_CHANNEL_4, gpio: 2),
        b: LedChannelAssign(channel: LEDC_CHANNEL_5, gpio: 3)
    )
    let rgbLed = try! RGBLed(channels: rgbLedChannels, timerNumber: LEDC_TIMER_2)
    rgbLed.setColor(r: 30, g: 200, b: 0)
    /*
    let redLedChannel = LedChannelAssign(channel: LEDC_CHANNEL_1, gpio: 10)    
    let redLed = try! MonchromeLed(channel: redLedChannel)
    redLed.setBrightness(10)
    
    let greenLedChannel = LedChannelAssign(channel: LEDC_CHANNEL_0, gpio: 12)
    let greenLed = try! MonchromeLed(channel: greenLedChannel)
    greenLed.setBrightness(10)
 
    let blueLedChannel = LedChannelAssign(channel: LEDC_CHANNEL_2, gpio: 11)
    let blueLed = try! MonchromeLed(channel: blueLedChannel)
    blueLed.setBrightness(10)
    */
//    var ticks = 0
//    var color = rgbLed.color
//    print ("r:\(color.r) g:\(color.g) b:\(color.b)")
    
//    var rFadeParams = FadeParameters.pulse(steps: 100, up: 100, down: 10)
//    var gFadeParams = FadeParameters.pulse(steps: 100, up: 60, down: 50)
//    var bFadeParams = FadeParameters.pulse(steps: 100, up: 10, down: 100)
//    var redFadeParams = FadeParameters.pulse(steps: 100, up: 10, down: 100)
//    var greenFadeParams = FadeParameters.pulse(steps: 100, up: 50, down: 60)
//    var blueFadeParams = FadeParameters.pulse(steps: 100, up: 100, down: 10)
//    
    switch runEsp({ledc_fade_func_install(ESP_INTR_FLAG_LEVEL1)}) {
    case .success: break
    case .failure(let err): print ("\(err)")
    }
   
    print ("OK")
    /*
    let delay: UInt32 = 10
    //let time: Int32 = 500
    let colors:[RGBColor] = [.random, .lightRandom]
    while true {
        let index = ticks % colors.count
        color = colors[index]
        rgbLed.fadeToColor(color)
//        redLed.fadeTo(color.r)
//        greenLed.fadeTo(color.g)
//        blueLed.fadeTo(color.b)
        vTaskDelay(delay)
        
        ticks += 1
        vTaskDelay(30)
        print ("go...\(ticks)")
        //print ("\red:\(red), green:\(green), blue:\(blue)")
        
    }
     */
}

