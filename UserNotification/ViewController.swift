import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kiemTraDaDcCapQuyenChua()
    }
    
    func kiemTraCacPendingNotif() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (pendings) in
            
        }
    }
    
    func chayThongBao() {
        // tao con tent
        let content = UNMutableNotificationContent()
        content.title = "Tua de"
        content.body = "noi dung"
        content.sound = .default
        content.badge = 0
        content.subtitle = "tua de phu"

        //tao trigger (chay notification sau 3s, khong lap lai)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        //tap request
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        // up request len
        UNUserNotificationCenter.current().add(request) { (error) in
            guard error == nil else { return }
            
            print("Notification scheduled!")
        }
    }
    
    
    func kiemTraDaDcCapQuyenChua() {
        // goi ham lay setting notification (getNotifcationSetting)
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            let status = settings.authorizationStatus //lay trang thai uy quyen
            
            switch status {
            case .authorized, .provisional: // da uy quyen
                print("bat dau thong bao")
                self.chayThongBao()
            case .notDetermined: // chua xac dinh
                print("xin cap quyen thong bao")
                self.xinQuyenThongBao()
                
            default: break
            }
        }
    }
    
    // xin quyen thong bao
    func xinQuyenThongBao() {
        // goi ham yeu cau uy quyen (requestAuthorization)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.announcement,.badge]){ (isGranted, error) in
            if error != nil {return}
            if isGranted {
                print("dc cap quyen")
                print("chay chuc nang")
                self.chayThongBao()
            } else {
                print("k dc cap quyen")
            }
        }
    }
}

