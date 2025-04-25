@_cdecl("esp_zb_task")
func zigbeeTask(_ parameter: UnsafeMutableRawPointer?) {  //(_ parameters: UnsafeMutablePointer<esp_zb_task_param_t>?) {
    print ("⏺️ \(#function): start Zigbee Task")
    //var config = ZigbeeConfig.dimmableLight
    //MARK: Node Config
    var zigbeeConfig = ZigbeeConfig(role: .router, 
                              installCodePolicy: false,
                              maxChildren: 10)
    
    print ("⏺️ \(#function): config done, lets init zb:")
    esp_zb_init(&zigbeeConfig)
    
    //MARK: Create device
    print ("⏺️ \(#function): zb inited, let make some light")
    guard let light = try? ColorDimmableLight(name: "Experyment", 
                                              identifier: "OjTamOjTam")
    else {fatalError("cannot create Light")}
    
    esp_zb_set_primary_network_channel_set(ESP_ZB_TRANSCEIVER_ALL_CHANNELS_MASK)
    
    //ESP_ERROR_CHECK(esp_zb_start(false))
    switch runEsp({esp_zb_start(false)}) {
    case .success: break
    case .failure(let err): fatalError("can`t run zigbee \(err)") 
    }
    print ("⏺️ \(#function) Light config")
    
    print ("⏺️ \(#function)...go to main loop")
    esp_zb_stack_main_loop()
}


