//
//  ViewController.swift
//  CustomDialogPopupWebView
//
//  Created by Debby on 2022/07/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var createPopUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onCreatePopUpBtnClicked(_ sender: UIButton) {
        print("ViewController - onCreatePopUpBtnClicked() called")
        // 스토리보드 가져오기
        let storyboard = UIStoryboard.init(name: "PopUp", bundle: nil)
        // 스토리보드를 통해 뷰컨 가져오기
        let customPopUpVC = storyboard.instantiateViewController(withIdentifier: "AlertPopUpVC") as! CustomPopUpViewController
        // 뷰컨 보여지는 스타일 = 현재 있는 컨텍스트를 덮어 팝업처럼 보이게 한다
        customPopUpVC.modalPresentationStyle = .overCurrentContext
        // 뷰컨 사라지는 스타일 = 스르륵 사라지는 스타일
        customPopUpVC.modalTransitionStyle = .crossDissolve
        
        customPopUpVC.youtubeBtnCompletionClosure = {
            print("컴플레션 블록이 호출됨")
            let jeonjangUrl = URL(string: "https://www.youtube.com/watch?v=dFUT2Lnn1cc&t=857s")
            self.myWebView.load(URLRequest(url: jeonjangUrl!))
        }
        
        self.present(customPopUpVC, animated: true, completion: nil)
    }
    
}

