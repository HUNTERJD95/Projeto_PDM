import SwiftUI

struct Aulas_Solo: View {
    var body: some View {
        SoloClassListView()
    }
}

struct SoloClassListView: View {
    @State private var classes = ["Yoga", "Pilates", "Zumba"]
    @State private var newClassName = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            List {
                ForEach(classes, id: \.self) { className in
                    Text(className)
                }
                .onDelete(perform: deleteClass)
            }
            
            Divider()
            
            HStack {
                TextField("Nova Aula", text: $newClassName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: addClass) {
                    Image(systemName: "plus")
                }
                .padding()
            }
        }
    }
    
    func addClass() {
        classes.append(newClassName)
        newClassName = ""
    }
    
    func deleteClass(at offsets: IndexSet) {
        classes.remove(atOffsets: offsets)
    }
}

struct Aulas_Solo_Previews: PreviewProvider {
    static var previews: some View {
        Aulas_Solo()
    }
}
