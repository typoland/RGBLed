@_cdecl("esp_zb_app_signal_handler")
public func signalHandler(_ signal: UnsafeMutablePointer<esp_zb_app_signal_t>?) {
    
    guard let signal = signal else { return }
    
    let p_sg_p = signal.pointee.p_app_signal
    let errStatus = signal.pointee.esp_err_status
    let sigType = p_sg_p?.pointee ?? 0  // esp_zb_app_signal_type_t
    let errName = String(cString: esp_err_to_name(errStatus))
    
    // Prepare optional parameter pointers
    var devAnnceParams: UnsafeMutablePointer<esp_zb_zdo_signal_device_annce_params_t>? = nil
    var leaveIndParams: UnsafeMutablePointer<esp_zb_zdo_signal_leave_indication_params_t>? = nil
    
    print("🔁 Zigbee signal received: type=\(sigType), status=\(errName)")
    guard let signalType = AppSignalType(rawValue: sigType) else {
        print ("no signal type: \(sigType)")
        return}
    switch (signalType) {
    case .skipStartup: 
        print ("#️⃣ Initialize Zigbee stack")
        guard .success == runEsp ({
            esp_zb_bdb_start_top_level_commissioning (
                UInt8(ESP_ZB_BDB_MODE_INITIALIZATION.rawValue)
            )}) 
        else {print ("❌ Initialize Zigbee stack failed"); return }
    case .deviceFirstStart, .deviceReboot:
        print ("#️⃣ device first start, reboot")
    case .steering:
        print ("#️⃣ steering")
    case .permitJoinStatus:
        print ("#️⃣ permit Join Status")
    case .productionConfigReady:
        print ("#️⃣ production Config Ready")
    default: print ("no this time \(sigType)")
    }
}


