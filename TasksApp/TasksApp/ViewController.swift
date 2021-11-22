//
//  ViewController.swift
//  TasksApp
//
//  Created by Camila Ribeiro Rodrigues on 22/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {


	private let table: UITableView = {
		let table = UITableView()
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return table
	}()
	
	var tasks = [String] ()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
		title = "Tasks"
		view.addSubview(table)
		table.dataSource = self
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
	}
	
	@objc private func didTapAdd() {
		let alert = UIAlertController(title: "New Task", message: "Enter new task!", preferredStyle: .alert)
		
		alert.addTextField { field in
			field.placeholder = "My Task"
		}
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
			if let field = alert.textFields?.first {
				if let text = field.text, !text.isEmpty {
					DispatchQueue.main.async {
						var currentTasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
						currentTasks.append(text)
						UserDefaults.standard.setValue(currentTasks, forKey: "Tasks")
						self?.tasks.append(text)
						self?.table.reloadData()
					}

				}
			}
		}))
		
		present(alert, animated: true)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		table.frame = view.bounds
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = tasks[indexPath.row]
		return cell
	}
	
}

