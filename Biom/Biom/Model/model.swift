var latitude = 0.0
var longitude = 0.0
var place = [String]()
var token = ""
var servertoken = ""


// MARK: - For region
struct start: Codable {
    let results: [Result]
}
struct Result: Codable {
    let region: Region
}
struct Region: Codable {
    let area1: Area
    let area2: Area
    let area3: Area
}
struct Area: Codable {
    let name: String
}


// MARK: - For google login
struct Google: Codable {
    let data: DataClass
}
struct DataClass: Codable {
    let accessToken: String
}


// MARK: - For BIOM/ANOM
struct message: Codable {
    let message: String
}


// MARK: - For getregion
struct regionClass: Codable {
    let data: regioncode
}
struct regioncode: Codable {
    let regionCode: Int
}


// MARK: - For getpercent fuctions
struct percent: Codable {
    let data: Proportion
}
struct Proportion: Codable {
    let biomProportion: Double
    
}
