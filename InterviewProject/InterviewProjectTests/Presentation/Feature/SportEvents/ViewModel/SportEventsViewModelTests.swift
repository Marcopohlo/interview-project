//
//  SportEventsViewModelTests.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import Combine
import XCTest
@testable import InterviewProject

final class SportEventsViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let stateSubject: CurrentValueSubject<SportEventsViewState, Never> = .init(.loading)
    private let dataSubject: CurrentValueSubject<[Storable], Never> = .init([])
    private let createSportEventAction: PassthroughSubject<Void, Never> = .init()
    private let showAlertAction: PassthroughSubject<Void, Never> = .init()

    func testLoadDataSuccess() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 3
        
        let viewModel = viewModel()
        viewModel.stateSubject
            .sink { state in
                if case .loading = state {
                    expectation.fulfill()
                } else if case let .data(isEmpty) = state {
                    XCTAssertFalse(isEmpty)
                    expectation.fulfill()
                } else {
                    XCTFail("Data should be loaded correctly")
                }
            }
            .store(in: &cancellables)
        
        viewModel.dataSubject
            .sink { data in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadData()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testLoadDataFailed() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 3
        
        let storageRepository = StorageRepositoryMock(shouldThrow: true)
        let viewModel = viewModel(storageRepository: storageRepository)
        viewModel.stateSubject
            .sink { state in
                if case .loading = state {
                    expectation.fulfill()
                } else if case .error = state {
                    expectation.fulfill()
                } else {
                    XCTFail("Data load should failed")
                }
            }
            .store(in: &cancellables)
        
        viewModel.dataSubject
            .sink { data in
                XCTAssertTrue(data.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadData()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testRefresh() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 3
        
        let viewModel = viewModel()
        viewModel.stateSubject
            .sink { state in
                if case .loading = state {
                    expectation.fulfill()
                } else if case let .data(isEmpty) = state {
                    XCTAssertFalse(isEmpty)
                    expectation.fulfill()
                } else {
                    XCTFail("Data should be loaded correctly")
                }
            }
            .store(in: &cancellables)
        
        viewModel.dataSubject
            .sink { data in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.refresh()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testBarButtonItem() {
        let expectation = XCTestExpectation()
        
        let viewModel = viewModel()
        viewModel.createSportEventAction
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.didTapCreateSportEventButton()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testAlert() {
        let expectation = XCTestExpectation()
        
        let viewModel = viewModel()
        viewModel.showAlertAction
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.handleErrorState()
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testSegmentChange() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        let storageTypes: [StorageType] = [.local]
        let storageRepository = StorageRepositoryMock()
        let viewModel = viewModel(storageRepository: storageRepository)
        viewModel.stateSubject
            .sink { state in
                if case .loading = state {
                    expectation.fulfill()
                } else if case .data = state {
                    XCTAssertEqual(storageRepository.loadStorageTypes, storageTypes)
                    expectation.fulfill()
                } else {
                    XCTFail("Any other state should not happen")
                }
            }
            .store(in: &cancellables)
        
        viewModel.didSelectSegment(storageTypes: storageTypes)
        
        wait(for: [expectation], timeout: .defaultTimeout)
    }
}

private extension SportEventsViewModelTests {
    func viewModel(storageRepository: StorageRepositoryProtocol = StorageRepositoryMock()) -> SportEventsViewModelProtocol {
        SportEventsViewModel(
            storageRepository: storageRepository,
            stateSubject: stateSubject,
            dataSubject: dataSubject,
            createSportEventAction: createSportEventAction,
            showAlertAction: showAlertAction
        )
    }
}
