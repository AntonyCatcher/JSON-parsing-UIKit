
import UIKit

struct Kettle: Decodable {
    var kettleManufacturer: String
    var kettleColor: [String]
    var kettlePrice: Int
}

class ViewController: UIViewController, UIPickerViewDelegate,
                      UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var label: UILabel!
    
    var kettles = [Kettle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        label.text = "Price: 50"
        
        guard let path = Bundle.main.url(forResource: "kettles",
                                         withExtension: "json" ) else { return }
        
        do {
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode([Kettle].self, from: data)
            kettles += result
        } catch {
            print(error)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
        
        component == 0 ? kettles.count : kettles[pickerView.selectedRow(inComponent: 0)].kettleColor.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                 titleForRow row: Int,
          forComponent component: Int) -> String? {
        switch component {
        case 0: return kettles[row].kettleManufacturer
        case 1: return kettles[pickerView.selectedRow(inComponent: 0)].kettleColor[row]
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                didSelectRow row: Int,
           inComponent component: Int) {
        
        let price = kettles[pickerView.selectedRow(inComponent: 0)].kettlePrice
        label.text = "Price: \(price)"
        pickerView.reloadComponent(1)
        
        print(price)
    }
}

