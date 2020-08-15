import SwiftUI

struct ClickableImage : View {
    
    @State var text: String
    var imageString: String
    var onClick: () -> Void = { }

    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 10) {
                Image(systemName: imageString)
                Text(text)
            }
        }.background(Color.white.opacity(0.3))
        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0, trailing: 8.0))
    }
}

struct ResetButton : View {
    var onClick: () -> Void = { }
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 10) {
                Text("Reset")
                Image(systemName: "arrow.clockwise")
            }
        }.background(Color.white.opacity(0.3))
        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0, trailing: 8.0))
    }
}

struct YearButton : View {
    
    var text: String
    var onClick: () -> Void = { }

    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 10) {
                Text("Selected Year : " + text)
                Image(systemName: "arrow.down")
            }
        }.background(Color.white.opacity(0.3))
        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0, trailing: 8.0))
    }
}

struct DoneButton : View {
    var onClick: () -> Void = { }

    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 10) {
                Text("Done")
            }
        }.background(Color.white.opacity(0.3))
        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0, trailing: 8.0))
    }
}

struct DataRow: View {
    var data: DataRecord
    var body: some View {
        HStack(spacing: 10) {
            Text("Quarter: \(data.quarter),").frame(width: 160, alignment: .leading)
            Text("Volume: \(data.volumeOfMobileData)")
        }
    }
}
