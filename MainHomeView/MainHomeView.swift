import SwiftUI

struct MainHomeView : View {
    @EnvironmentObject var viewModel: MainHomeVM
    @State private var selectedYear = ""
    @State private var selectedYearIndex = 0
    @State private var isExpend = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    YearButton(text: self.viewModel.selectedYear) {self.isExpend = true}
                    ResetButton {self.viewModel.resetData()}
                }
               
                HStack(spacing: 10) {
                    ClickableImage(text: "All", imageString: "pencil") {self.viewModel.updateQurter(value: "ALL")}
                    ClickableImage(text: "Q1", imageString: "1.square.fill") {self.viewModel.updateQurter(value: "Q1")}
                    ClickableImage(text: "Q2", imageString: "2.square.fill") {self.viewModel.updateQurter(value: "Q2")}
                    ClickableImage(text: "Q3", imageString: "3.square.fill") {self.viewModel.updateQurter(value: "Q3")}
                    ClickableImage(text: "Q4", imageString: "4.square.fill") {self.viewModel.updateQurter(value: "Q4")}
                }
                HStack(spacing: 10) {
                    Text("Quarter").frame(width: 100, alignment: .leading)
                    Text("Amount Data Sent")
                }
                List(viewModel.filterRecords) { item in
                    DataRow(data: item)
                }.navigationBarTitle(Text("Sample Data" + self.viewModel.getSubTitle()))
                if(self.isExpend) {
                    DoneButton {
                        if(self.selectedYearIndex == nil) {
                            self.selectedYearIndex = 0
                        }
                        if(self.selectedYearIndex > 0 && self.selectedYearIndex < self.viewModel.years.count) {
                            self.isExpend = false
                            self.viewModel.updateSelectedYear(value: self.selectedYearIndex)
                        }
                       
                    }
                    Picker(selection: $selectedYearIndex, label: Text("Year")) {
                        ForEach(0..<viewModel.years.count) { index in
                            Text(self.viewModel.years[index]).tag(index)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0, trailing: 8.0))

                }
              
            }
            
        }
    }
}

#if DEBUG
struct MainHomeV_Previews : PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
#endif
