//
//  BudgetGoalsViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/27/23.
//

import Foundation
import FirebaseFirestore

protocol BudgetGoalsViewModelDelegate: AnyObject {
    func budgetSavedSuccessfully()
    func budgetsFetchedSuccessfully()
    

}

class BudgetGoalsViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: BudgetGoalsViewModelDelegate?
    var budget: Budget?
    var budgets: [Budget] = []
    
    init(serviceInjected: FireBaseSyncable = FirebaseService(), delegate: BudgetGoalsViewModelDelegate) {
        self.service = serviceInjected
        self.delegate = delegate
        self.loadBudgets()
    }
    
    // MARK: - Functions

    func saveBudget(budget: Budget) {
        service.saveBudget(budget: budget)
        CurrentUser.shared.currentBudget = budget
        self.delegate?.budgetSavedSuccessfully()
    }

    func addBudget(_ budget: Budget) {
        self.budgets.append(budget)
        }
    
    func loadBudgets() {
        service.loadBudget { [weak self] result in
            switch result {
            case .success(let budgets):
                self?.budgets = budgets
                self?.delegate?.budgetsFetchedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


