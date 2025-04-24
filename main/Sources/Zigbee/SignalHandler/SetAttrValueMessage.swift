/*
struct SetAttrValueMessage {
    private let raw: UnsafeMutablePointer<esp_zb_zcl_set_attr_value_message_t>
    
    init(_ pointer: UnsafeMutableRawPointer?) throws (Error){
        guard let pointer = pointer else { throw .cantGetMessageFromPointer }
        self.raw = pointer.assumingMemoryBound(to: esp_zb_zcl_set_attr_value_message_t.self)
    }
    
    var attrID:    UInt16 { raw.pointee.attr_id }
    
    var clusterID: UInt16 { raw.pointee.cluster_id }
    
    var endpoint:  UInt8 { raw.pointee.endpoint }
    
    var value:     UnsafePointer<UInt8>? { raw.pointee.value }
    
    var size:      Int { Int(raw.pointee.size) }
    
    // Add more field accessors if needed
}
*/
