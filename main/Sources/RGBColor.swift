struct RGB<T> {
    var r: T
    var g: T
    var b: T
}

typealias RGBChannel = UInt8;
typealias RGBColor = RGB<RGBChannel>

extension RGB where T == RGBChannel {
    static var white      = RGBColor(r: 255, g: 255, b: 255)
    static var off        = RGBColor(r: 0,   g: 0,   b: 0)
    static var red        = RGBColor(r: 255, g: 0,   b: 0)
    static var green      = RGBColor(r: 0,   g: 255, b: 0)
    static var blue       = RGBColor(r: 0,   g: 0,   b: 255)
    static var lightWhite = RGBColor(r: 16,  g: 16,  b: 16)
    static var lightRandom: RGBColor {
        RGBColor(
            r: .random(in: 0...16), 
            g: .random(in: 0...16), 
            b: .random(in: 0...16))
    }
}

//MARK: Active Channel
enum ActiveChannel: String {
    case r
    case g
    case b
    var next: ActiveChannel {
        switch self {
        case .r: return .g
        case .g: return .b
        case .b: return .r
        }
    }
}
extension RGB where T == RGBChannel {
    func channel(_ channel: ActiveChannel) -> RGBColor {
        switch channel {
        case .r: return RGBColor(r: r, g: 0, b: 0) 
        case .g: return RGBColor(r: 0, g: g, b: 0) 
        case .b: return RGBColor(r: 0, g: 0, b: b)
        }
    }
}

