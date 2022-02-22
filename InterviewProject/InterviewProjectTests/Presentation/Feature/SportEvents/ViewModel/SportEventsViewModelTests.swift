//
//  SportEventsViewModelTests.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import XCTest
@testable import InterviewProject

final class SportEventsViewModelTests: XCTestCase {
    
    func testBinding() throws {
        let tableView = UITableView()
        let viewModel = viewModel()
        viewModel.bind(to: tableView)
        XCTAssertNotNil(tableView.dataSource)
    }

    func testLoadDataSuccess() throws {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        let viewModel = viewModel()
        viewModel.stateDidChange = { state in
            if case .loading = state {
                expectation.fulfill()
            } else if case let .data(isEmpty) = state {
                XCTAssertFalse(isEmpty)
                expectation.fulfill()
            } else {
                XCTFail("Data should be loaded correctly")
            }
        }
        viewModel.loadData()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testLoadDataFailed() throws {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        let storageRepository = StorageRepositoryMock(shouldThrow: true)
        let viewModel = viewModel(storageRepository: storageRepository)
        viewModel.stateDidChange = { state in
            if case .loading = state {
                expectation.fulfill()
            } else if case .error = state {
                expectation.fulfill()
            } else {
                XCTFail("Data load should failed")
            }
        }
        viewModel.loadData()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testRefresh() throws {
        let expectation = XCTestExpectation()
        
        let viewModel = viewModel()
        viewModel.stateDidChange = { state in
            if case let .data(isEmpty) = state {
                XCTAssertFalse(isEmpty)
                expectation.fulfill()
            } else {
                XCTFail("Data should be loaded correctly")
            }
        }
        viewModel.refresh()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testBarButtonItem() throws {
        let expectation = XCTestExpectation()
        
        let viewModel = viewModel()
        viewModel.createSportEventHandler = {
            expectation.fulfill()
        }
        viewModel.didTapCreateSportEventButton()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testAlert() throws {
        let expectation = XCTestExpectation()
        
        let viewModel = viewModel()
        viewModel.showAlert = {
            expectation.fulfill()
        }
        viewModel.handleErrorState()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testSegmentChange() throws {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        let storageTypes: [StorageType] = [.local]
        let storageRepository = StorageRepositoryMock()
        let viewModel = viewModel(storageRepository: storageRepository)
        viewModel.stateDidChange = { state in
            if case .loading = state {
                expectation.fulfill()
            } else if case .data = state {
                XCTAssertEqual(storageRepository.loadStorageTypes, storageTypes)
                expectation.fulfill()
            } else {
                XCTFail("Any other state should not happen")
            }
        }
        viewModel.didSelectSegment(storageTypes: storageTypes)
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
}

private extension SportEventsViewModelTests {
    func viewModel(storageRepository: StorageRepositoryProtocol = StorageRepositoryMock()) -> SportEventsViewModelProtocol {
        SportEventsViewModel(storageRepository: storageRepository)
    }
}
