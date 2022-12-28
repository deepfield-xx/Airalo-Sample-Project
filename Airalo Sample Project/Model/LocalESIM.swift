import Foundation

struct LocalESIMImage: Codable {
    let width: Int
    let height: Int
    let url: URL?
}

struct LocalESIM: Codable {
    let id: Int
    let slug: String
    let title: String
    let image: LocalESIMImage
}
