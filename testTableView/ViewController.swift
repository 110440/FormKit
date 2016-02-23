//
//  ViewController.swift
//  testTableView
//
//  Created by tanson on 15/12/8.
//  Copyright © 2015 tanson. All rights reserved.
//

import UIKit

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "form tableView"
        
        let rightItem = UIBarButtonItem(title: "WeChat", style: .Plain, target: self, action: "rightItem")
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func rightItem(){
        let weChatController = WeChatViewController()
        self.navigationController?.pushViewController(weChatController, animated: true)
    }

    
    override func buildCells(builder: FormBuilder) {
        
        builder += FormSection()
        builder += FormLabelCell(title: "这是一个lab", rightText: "value" ,detailText: "sub")
        builder += FormLabelCell(title: "设置", rightText: "")
        builder += FormTextInputCell(title: "名字:").rightText("三斤叔")
        
        
        builder += FormSection()
        builder += buttonOK
        builder += buttonAndRight
        builder += FormButtonCell(title: "按钮", detailText: "描述").rightText("Test")
        
        builder += setting
        
        builder += FormSection().headTitle("test section").footTitle("这是一个脚标提")
        builder += FormButtonCell(title: "标题测试")
        builder += swicthCell
        
        builder += FormSection().headTitle("输入注册")
        builder += userName
        builder += passWord
        builder += email
        builder += btnLogin
        
        builder += FormSection()
        builder += labelCell

        
        builder += mutilSelect
        builder += customCell
        builder += citySelectCell
    }
    
    lazy var swicthCell:FormSwicthCell = {
       let cell = FormSwicthCell(title: "开关")
        cell.action = { value in
            print(value )
        }
        return cell
    }()
    
    lazy var buttonOK:FormButtonCell = {
        var btnCell = FormButtonCell(title: "OK")
        btnCell.setSeparatorInsetZero()
        return btnCell
    }()
    
    lazy var passWord:FormTextFieldCell = {
        var textField = FormTextFieldCell(title: "密码:",detailText: "不能小于6").placeholder("请输入密码").SetIsPassWord(true)
        textField.addValidator(textField.inputValidator(6, max: 10 ,errorMsg: "密码长度6-10"))
        textField.detailTextColor = UIColor.darkGrayColor()
        return textField
    }()
    
    lazy var userName:FormTextFieldCell = {
        var textField = FormTextFieldCell(title: "账号:").placeholder("输入用户名").showClearButtonWhileEditting()
        textField.addValidator(textField.inputValidator(3, max: 6,errorMsg: "用户名长度:3-6"))
        return textField
    }()
    
    lazy var email:FormTextFieldCell = {
        
        var textField = FormTextFieldCell(title: "邮箱:").placeholder("请输入邮箱").showClearButtonWhileEditting()
        textField.addValidator(textField.emailValidator())
        textField.setKeyboardType(.EmailAddress)
        return textField
    }()
    
    lazy var btnLogin:FormButtonCell={
        var btn = FormButtonCell(title: "登陆")
        
        btn.action = { [weak self] button in
            let ret = self?.liveValidate()
            if let retStr = ret {
                let alert = UIAlertView(title: "", message: retStr, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        return btn
    }()
    
    
    lazy var labelCell:FormOptionTextCell = {
        var labelCell = FormOptionTextCell(title: "职业:")
        var options = ["大学生","小学生","中学生"]
        labelCell.rightText = "大学生"
        labelCell.optionItems = options
        labelCell.didSelectBlock = { [weak self] index,title in
            print( "select the index : \(index) , titile: \(title)")
        }
        return labelCell
    }()
    
    
    lazy var buttonAndRight:FormButtonCell = {
        var btn = FormButtonCell(title: "清除缓存", rightText: "23M")
        btn.accessoryType = .DisclosureIndicator
        btn.action = { [weak self] btn in
            print("====== 清除成功!!!")
        }
        return btn
    }()
    
    lazy var setting:FormButtonCell = {
        let btn =  FormButtonCell(title: "设置", rightText: "系统")
        btn.accessoryType = .DisclosureIndicator
        return btn
    }()
    
    lazy var mutilSelect:FormSegmentedCell={
       
        var cell = FormSegmentedCell(title: "选一个", items: ["2G","Wi-Fi","3/4G"] )
        cell.setSelectedIndex(1)
        cell.action = { index in
            print("select index: \(index)")
        }
        return cell
    }()
    
    lazy var customCell:TestNibCell = {
        
        let view:TestNibCell = TestNibCell.fromNib()
        return view
    }()
    
    lazy var citySelectCell:FormCitySelectCell = {
       
        var cell = FormCitySelectCell(title: "选择城市")
        cell.rightText = "请选择城市"
        cell.cityDidSelect = { s,c,z in
            print(s,c,z)
        }
        return cell
    }()
    

}
