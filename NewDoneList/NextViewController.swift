//
//  NextViewController.swift
//  NewDoneList
//
//  Created by 福本伊織 on 2021/03/04.
//

import UIKit
import Cosmos

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var DetailTextView: UITextView!
    @IBOutlet weak var cosmosView: CosmosView!
    
    //Classをインスタンス化
    let listData = ListData()
    
    //DoneStruct型がはいる空の配列をつくる
    private var list: [DoneStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UserDefaultsのデータを入れる。nilのときのために空配列を用意
        list = listData.getValue() ?? []
        
        //以下TextViewの設定
        // 枠のカラー
        DetailTextView.layer.borderColor = UIColor.lightGray.cgColor
        // 枠の幅
        DetailTextView.layer.borderWidth = 0.5
        // 枠を角丸にする場合
        DetailTextView.layer.cornerRadius = 3.0
        DetailTextView.layer.masksToBounds = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
    }
    
    
    @IBAction func AddButton(_ sender: Any) {
        
        //配列listの中にある構造体todo,rateそれぞれにTextField.textとrateを入れる
        let doneStruct = DoneStruct(todo: TextField.text!,todoDetail: DetailTextView.text,star: Int(cosmosView.rating))
        list.append(doneStruct)
        // listをUserDefaultsで保存する
        listData.save(list: list)
        
        //保存したデータを取得してPrintする
        print(listData.getValue() as Any)
        
        TextField.text = ""
        dismiss(animated: true, completion: nil)
        
    }
    
    //キーボード以外をタップでキーボード閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
