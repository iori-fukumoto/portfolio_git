//
//  ViewController.swift
//  NewDoneList
//
//  Created by 福本伊織 on 2021/03/04.
//

import UIKit
import Cosmos

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //Classをインスタンス化
    let listData = ListData()
    
  
    //空の配列を用意する
    var structData: [DoneStruct]? = []
    var TextBox = DoneStruct()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //空の配列にUserDefaultsから取得したデータを入れる。
        structData = listData.getValue()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.reloadData()
        
    }
    
    
    //セクションの数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //表示するセルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //値がnilの場合の動作を設定しておく。
        if let unwrap_structData = structData {
            return unwrap_structData.count
        }
        else {
            return 1
        }
    }
    
    //セルの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    //セルの中身を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Xibファイルから持ってくる
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! TableViewCell
        
        //値がnilの場合の動作を設定しておく。
        if let unwrap_structData = structData {
            TextBox = unwrap_structData[indexPath.row]
        }
        else {
            print("値なし")
        }
        cell.Label.text = TextBox.todo
        cell.DetailLabel.text = TextBox.todoDetail
        cell.StarLabel.rating = Double(Int(TextBox.star))
        
        return cell
    }
    
    
   
    //プラスボタンを押して画面遷移する
    @IBAction func AddFAB(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    
    //Editボタンを押して、編集モードに切り替える
    @IBAction func EditButtonFAB(_ sender: Any) {
        
        //通常モードと編集モードを切り替える。
        if(tableView.isEditing == true){
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    
    //セルの削除を指定
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            structData!.remove(at: indexPath.row)
            listData.save(list: structData!)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    //並び替え時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let targetTitle = structData![sourceIndexPath.row]
        //元の位置のデータを配列から削除
        structData!.remove(at:sourceIndexPath.row)
        //移動先の位置にデータを配列に挿入
        structData!.insert(targetTitle, at: destinationIndexPath.row)
        listData.save(list: structData!)
        //テーブルビューをリロードする。
        tableView.reloadData()
    }
 
       
    
   
    
    
    

}
