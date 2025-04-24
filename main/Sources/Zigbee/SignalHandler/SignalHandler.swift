//
//  SignalHandler.swift
//  
//
//  Created by Łukasz Dziedzic on 21/04/2025.
//

enum ZigbeeError:Swift.Error {
   
    case cantGetMessageFromPointer
    case manufacturerInfoFailed(String)
    var description: String {
        switch self {
        case .manufacturerInfoFailed(let string):
            return "Manufacturer Info Failed: \(string)"
        case .cantGetMessageFromPointer:
            return "Cant get message from pointer"
        }
    }
}

@_cdecl("esp_zb_app_signal_handler")
public func signalHandler(_ signal: UnsafeMutablePointer<esp_zb_app_signal_t>?) {
    guard let signal = signal else { return }
    
    let p_sg_p = signal.pointee.p_app_signal
    let errStatus = signal.pointee.esp_err_status
    let sigType = p_sg_p?.pointee ?? 0  // esp_zb_app_signal_type_t
    let errName = String(cString: esp_err_to_name(errStatus))
    
    // Prepare optional parameter pointers
//    var devAnnceParams: UnsafeMutablePointer<esp_zb_zdo_signal_device_annce_params_t>? = nil
//    var leaveIndParams: UnsafeMutablePointer<esp_zb_zdo_signal_leave_indication_params_t>? = nil
    
    print("🔁 Zigbee signal received: type=\(sigType), status=\(errName)")
    switch (sigType) {
    default: print ("no this time \(sigType)")
    }
}

//@_cdecl("zb_attribute_handler")
//func attributeHandler(message: )
//static (const esp_zb_zcl_set_attr_value_message_t *message)
//{

//@_cdecl("zb_action_handler")
/*
var actionHandler @convention(c) (esp_zb_core_action_callback_id_t,
                           callback_id, 
                           UnsafeRawPointer? ) 
{
    print ("action handler registered: \(callbackId)")
    return ESP_OK
//    var ret:ESPError = .success;
    /*
    let msg = try SetAttrValueMessage(message)
    
    switch (callback_id) {
    case .setAttrValue: // ESP_ZB_CORE_SET_ATTR_VALUE_CB_ID:
        switch runEsp({
            print ("seems to be OK, now attribute \(msg.attrID) handler")
            //zb_attribute_handler(msg.attrID)
        }) {
        case .success: break
        default: fatalError("action Handler failed")
        }
    
    default:
        print("Receive Zigbee action \(callback_id) callback", );
        break;
    }
     */
   
}
*/
@_cdecl("esp_zb_task")

func zigbeeTask(_ parameter: UnsafeMutableRawPointer?) {  //(_ parameters: UnsafeMutablePointer<esp_zb_task_param_t>?) {
    
    var config = ZigbeeConfig(role: .router,
                              installCodePolicy: false,
                              maxChildren: 10)
    esp_zb_init(&config)
    guard let light = try? ColorDimmableLight(name: "Experyment", 
                                              identifier: "OjTamOjTam")
    else {fatalError("cannot create Light")}
  
    
    
    
    
    
    esp_zb_stack_main_loop()
}


func addBasicManufacturerInfo(
    to epList: UnsafeMutablePointer<esp_zb_ep_list_t>,
    endpointId: UInt8,
    info: UnsafePointer<zcl_basic_manufacturer_info_t>
) throws (ZigbeeError) {

    guard let clusterList = esp_zb_ep_list_get_ep(epList, endpointId) else {
        throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find endpoint id: \(endpointId) in list: \(epList)")
    }
    
    guard let basicCluster = esp_zb_cluster_list_get_cluster(
        clusterList,
        ZCL.Cluster.Id.basic.rawValue, //ESP_ZB_ZCL_CLUSTER_ID_BASIC,
        ZCL.Cluster.Role.server.rawValue //ESP_ZB_ZCL_CLUSTER_SERVER_ROLE
    ) else {
        throw .manufacturerInfoFailed("ZCL_UTILITY: Failed to find basic cluster in endpoint: \(endpointId)")
    }
    
    guard let name = info.pointee.manufacturer_name else {
        throw .manufacturerInfoFailed("ZCL_UTILITY: Invalid manufacturer name")
    }
    
    switch runEsp({
        esp_zb_basic_cluster_add_attr(basicCluster, 
                                      ZCL.BasicAttr.manufacturerName.rawValue, 
                                      name)}) 
    {
    case .success: break
    case .failure(let err): throw .manufacturerInfoFailed(err)
    }
    
    guard let model = info.pointee.model_identifier else {
        throw .manufacturerInfoFailed("ZCL_UTILITY: Invalid model identifier")
    }
    switch runEsp({
        esp_zb_basic_cluster_add_attr(basicCluster, 
                                      ZCL.BasicAttr.modelIdentifier.rawValue, 
                                      model)})
    {
    case .success: break
    case .failure(let err): throw .manufacturerInfoFailed(err)
    }
}
