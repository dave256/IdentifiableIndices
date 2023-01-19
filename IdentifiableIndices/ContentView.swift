//
//  ContentView.swift
//  IdentifiableIndices
//
//  Created by David M Reed on 4/21/21.
//

import SwiftUI

// https://www.swiftbysundell.com/articles/bindable-swiftui-list-elements/



struct Note: Hashable, Identifiable {
    var title: String
    var text: String
    let id: UUID = UUID()
}

class NoteList: ObservableObject {
    @Published var notes: [Note] = Note.sampleData()
}

extension Note {
    static func sampleData() -> [Note] {
        [
            Note(title: "N1", text: "text1"),
            Note(title: "N2", text: "text2"),
            Note(title: "N3", text: "text3"),
        ]
    }
}


struct ContentView: View {

    @StateObject private var list = NoteList()

    var body: some View {
        NavigationView {
            List {
                #warning("this should no longer be necessary now that we can make bindings in ForEach")
                ForEach(list.notes.identifiableIndices) { index in
                    VStack(alignment: .leading) {
                        Text(list.notes[index].title)
                        Spacer()
                        Text(list.notes[index].text)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarItems(leading: EditButton())
        }
    }

    func deleteItems(offsets: IndexSet) {
        for offset in offsets.sorted().reversed() {
            list.notes.remove(at: offset)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
