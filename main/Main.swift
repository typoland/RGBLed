
@_cdecl("app_main")
func app_main() {
    let rgbLedChannels = RGB (
        r: LedChannelAssign(channel: LEDC_CHANNEL_3, gpio: 22),
        g: LedChannelAssign(channel: LEDC_CHANNEL_4, gpio: 2),
        b: LedChannelAssign(channel: LEDC_CHANNEL_5, gpio: 3)
    )
    guard let rgbLed = try? RGBLed(channels: rgbLedChannels)
    else { fatalError ("Failed to initialize RGB LED") }
    rgbLed.setColor(r: 30, g: 200, b: 0)
    
    
    let redLedChannel = LedChannelAssign(channel: LEDC_CHANNEL_1, gpio: 10)    
    let redLed = try! MonchromeLed(channel: redLedChannel)
    redLed.setBrightness(255)
    
    let greenLedChannel = LedChannelAssign(channel: LEDC_CHANNEL_0, gpio: 12)
    let greenLed = try! MonchromeLed(channel: greenLedChannel)
    greenLed.setBrightness(255)
 
    let blueLedChannel = LedChannelAssign(channel: LEDC_CHANNEL_2, gpio: 11)
    let blueLed = try! MonchromeLed(channel: blueLedChannel)
    blueLed.setBrightness(255)
    
    var time = 0

    
    var rFadeParams = FadeParameters.pulse(steps: 100, up: 100, down: 10)
    var gFadeParams = FadeParameters.pulse(steps: 100, up: 60, down: 50)
    var bFadeParams = FadeParameters.pulse(steps: 100, up: 10, down: 100)
    var redFadeParams = FadeParameters.pulse(steps: 100, up: 10, down: 100)
    var greenFadeParams = FadeParameters.pulse(steps: 100, up: 50, down: 60)
    var blueFadeParams = FadeParameters.pulse(steps: 100, up: 100, down: 10)
    
    switch runEsp({ledc_fade_func_install(ESP_INTR_FLAG_LEVEL1)}) {
    case .success: break
    case .failure(let err): print ("\(err)")
    }
   
    print ("OK")
    
    while true {

           rgbLed.channelsConfig.r.pulse(&rFadeParams)
           rgbLed.channelsConfig.g.pulse(&gFadeParams )
           rgbLed.channelsConfig.b.pulse(&bFadeParams )
           redLed.channelConfig.pulse(&redFadeParams)
        greenLed.channelConfig.pulse(&greenFadeParams)
        blueLed.channelConfig.pulse(&blueFadeParams)
      
       
        time += 1
        vTaskDelay(200)
        print ("go...")
        //print ("\red:\(red), green:\(green), blue:\(blue)")
    }
}

