import Foundation

struct CountryPackageImage: Codable {
    let url: URL?
}

struct CountryPackageCountry: Codable {
    let title: String
}

enum CountryPackageOperatorStyle: String, Codable {
    case light
    case dark
}

struct CountryPackageOperator: Codable {
    let title: String
    let gradient_start: String
    let gradient_end: String
    let image: CountryPackageImage
    let style: CountryPackageOperatorStyle
    let countries: [CountryPackageCountry]
}

struct CountryPackage: Codable {
    let id: Int
    let price: Double
    let data: String
    let validity: String
    let `operator`: CountryPackageOperator
}

struct CountryPackages: Codable {
    let packages: [CountryPackage]
}
