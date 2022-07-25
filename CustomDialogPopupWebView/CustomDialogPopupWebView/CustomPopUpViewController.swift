//
//  CustomPopUpViewController.swift
//  CustomDialogPopupWebView
//
//  Created by Debby on 2022/07/24.
//

import Foundation
import UIKit

class CustomPopUpViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var youtubeBtn: UIButton!
    @IBOutlet weak var bgBtn: UIButton!
    
    var youtubeBtnCompletionClosure: (() -> Void)? // (() -> Void)? : 호출되어도 아무것도 안하겠다
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CustomPopUpViewController - viewDidLoad() called")
        contentView.layer.cornerRadius = 30
        youtubeBtn.layer.cornerRadius = 10
    }

    @IBAction func onBgBtnClicked(_ sender: UIButton) {
        print("CustomPopUpViewController - onBgBtnClicked() called")
        // dismiss : 현재 창 닫기, completion : 완료되면, nil : 아무것도 안 하겠다
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onYoutubeBtnClicked(_ sender: UIButton) {
        print("CustomPopUpViewController - onYoutubeBtnClicked() called")
        
        self.dismiss(animated: true, completion: nil)
        
        // 클로저를 통한 이벤트 전달 - 컴플레션 블럭 호출
        if let youtubeBtnCompletionClosure = youtubeBtnCompletionClosure{
            // 메인에 알린다.
            youtubeBtnCompletionClosure()
        }
        
    }
    
}
