
@_cdecl("app_main")
func app_main() {
    
    guard let rgbLed = try? RGBLed(
        channels: RGB(r: LEDC_CHANNEL_3, 
                      g: LEDC_CHANNEL_4, 
                      b: LEDC_CHANNEL_5), 
        gpios: RGB(r: 22, g: 2, b: 3)) 
    else {
        print ("Failed to initialize RGB LED")
        return
    }
    var time = 0
//    var red: UInt8 = 0
//    var green: UInt8 = 0
//    var blue: UInt8 = 0
    let redTicks = 10
    let blueTicks  = 9
    let greenTicks = 4
    
    var rFadeParams = try! rgbLed.setParams(steps: 100)
    var gFadeParams = try! rgbLed.setParams(steps: 80)
    var bFadeParams = try! rgbLed.setParams(steps: 30)
    
    switch runEsp({ledc_fade_func_install(ESP_INTR_FLAG_LEVEL1)}) {
    case .success: break
    case .failure(let err): print ("\(err)")
    }
    
    print ("OK")
    
    while true {
//         
////        rgbLed.setColor(.red)
////        vTaskDelay(10)
//        let red = UInt8((sin(Double(time/redTicks)))*255)
//        let green = UInt8((sin(Double(time/greenTicks)))*255)
//        let blue = UInt8((sin(Double(time/blueTicks)))*255)
//        rgbLed.setColor(RGBColor(r: red, g: green, b: blue))
//        
        do {    
            try rgbLed.multiFadeStart(config: rgbLed.configR, params: &rFadeParams )
            try rgbLed.multiFadeStart(config: rgbLed.configG, params: &gFadeParams )
            try rgbLed.multiFadeStart(config: rgbLed.configB, params: &bFadeParams )
        } catch {print ("No fade")}
        
        time += 1
        vTaskDelay(200)
        print ("go...")
        //print ("\red:\(red), green:\(green), blue:\(blue)")
    }
}

