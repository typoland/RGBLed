@_cdecl("esp_zb_task")
func zigbeeTask(_ parameter: UnsafeMutableRawPointer?) {  //(_ parameters: UnsafeMutablePointer<esp_zb_task_param_t>?) {
    print ("\(#function): start Zigbee Task")
    var config = ZigbeeConfig.dimmableLight
    
    print ("\(#function): config done, lets init zb:")
    esp_zb_init(&config)
    
    print ("\(#function): zb inited, let make some light")
    guard let light = try? ColorDimmableLight(name: "Experyment", 
                                              identifier: "OjTamOjTam")
    else {fatalError("cannot create Light")}
    
    print ("Light config: \(light.config)")
    
    
    
    print ("...go to main loop")
    esp_zb_stack_main_loop()
}


