import SwiftUI

struct RawLessonData: Decodable {
    var name: String
    var data: [String]
}

let rawLessons: [RawLessonData] = loadDataFromFile("data.json")

var parsedLessons = rawLessons.map { rawLesson -> Lesson in
    let text = rawLesson.data.joined(separator: "\n")
    return Lesson(
        name: rawLesson.name,
        data: try! parseData(text: text)
    )
}

func loadDataFromFile<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
