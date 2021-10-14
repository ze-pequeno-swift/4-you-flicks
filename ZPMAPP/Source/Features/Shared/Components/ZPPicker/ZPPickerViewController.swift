//
//  ZPPickerViewController.swift
//  ZPMAPP
//
//  Created by Hellen on 26/09/21.
//

import UIKit

class ZPPickerViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var tableView: DynamicHeightTableView! {
        didSet {
            let nib = UINib(nibName: "ZPPickerTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: ZPPickerTableViewCell.identifier)
        }
    }
    
    @IBOutlet private var confirmButton: UIButton!
    
    @IBOutlet private var cancelButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: ZPPickerDelegate?
    
    var pickerData = [String]()
    
    var lastSelectedIndex: Int?
    
    var pickerTitle: String? {
        didSet {
            titleLabel?.text = pickerTitle
        }
    }
    
    var confirmLabel: String? {
        didSet {
            confirmButton?.setTitle(confirmLabel, for: .normal)
        }
    }
    
    var cancelLabel: String? {
        didSet {
            cancelButton?.setTitle(cancelLabel, for: .normal)
        }
    }
    
    private var selectedRow: (String, Int)?
    
    // MARK: - View lifecycle
    
    init() {
        super.init(nibName: "ZPPickerViewController", bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let row = lastSelectedIndex ?? 0
        let indexPath = IndexPath(row: row, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedRow = (pickerData[row], row)
        
        setupLabels()
    }
    
    // MARK: - Actions
    
    @IBAction private func confirmAction(_ sender: Any) {
        if let selectedRow = selectedRow {
            delegate?.didSelectPicker(atRow: selectedRow.1, withKey: selectedRow.0)
        }
        dismiss(animated: true)
    }
    
    @IBAction private func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Private functions
    
    private func setup() {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    private func setupLabels() {
        titleLabel.text = pickerTitle
        confirmButton.setTitle(confirmLabel, for: .normal)
        cancelButton.setTitle(cancelLabel, for: .normal)
    }
    
}

extension ZPPickerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: ZPPickerTableViewCell.identifier, for: indexPath)
            as? ZPPickerTableViewCell else { return UITableViewCell() }
        
        let label = pickerData[indexPath.row]
        cell.setup(withLabel: label)
        
        return cell
    }
    
}

extension ZPPickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        selectedRow = (pickerData[index], index)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
}

open class DynamicHeightTableView: UITableView {
    
    override open var intrinsicContentSize: CGSize {
        return contentSize
    }
    
}
