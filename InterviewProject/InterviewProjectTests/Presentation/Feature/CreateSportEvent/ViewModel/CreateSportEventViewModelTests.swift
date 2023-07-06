//
//  CreateSportEventViewModelTests.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import Combine
import XCTest
@testable import InterviewProject

final class CreateSportEventViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let cancelEventCreationAction: PassthroughSubject<Void, Never> = .init()
    private let saveEventAction: PassthroughSubject<Void, Never> = .init()
    private let showAlertAction: PassthroughSubject<Void, Never> = .init()
    private let showActionSheetAction: PassthroughSubject<Void, Never> = .init()
    
    func testCancel() {
        let expectation = XCTestExpectation()
        let viewModel = viewModel()
        viewModel.cancelEventCreationAction
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.didTapCancelButton()
        wait(for: [expectation], timeout: .defaultTimeout)
    }

    func testSaveEvent() {
        let expectation = XCTestExpectation()
        let storageRepositoryMock = StorageRepositoryMock()
        let viewModel = viewModel(storageRepository: storageRepositoryMock)
        viewModel.saveEventAction
            .sink {
                XCTAssertEqual(storageRepositoryMock.savedEvent?.name, "Mock Event")
                XCTAssertEqual(storageRepositoryMock.savedEvent?.place, "Mock Place")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.nameTextFieldEditingChanged("Mock Event")
        viewModel.placeTextFieldEditingChanged("Mock Place")
        viewModel.didSelectPickerRow(4, inComponent: 0)
        viewModel.saveEvent(storageType: .server)
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testPicker() {
        let viewModel = viewModel()
        XCTAssertEqual(viewModel.numberOfPickerComponents(), 3)
        XCTAssertEqual(viewModel.numberOfPickerRowsInComponent(0), 24)
        XCTAssertEqual(viewModel.numberOfPickerRowsInComponent(1), 60)
        XCTAssertEqual(viewModel.numberOfPickerRowsInComponent(2), 60)
        XCTAssertEqual(viewModel.titleForRow(5, forComponent: 1), "5 m")
    }
    
    func testShowMissingItemsAlert() {
        let expectation = XCTestExpectation()
        let viewModel = viewModel()
        viewModel.showAlertAction
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.didTapSaveButton()
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testShowActionSheet() {
        let expectation = XCTestExpectation()
        let viewModel = viewModel()
        viewModel.showActionSheetAction
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.nameTextFieldEditingChanged("Mock Event")
        viewModel.placeTextFieldEditingChanged("Mock Place")
        viewModel.didSelectPickerRow(4, inComponent: 0)
        viewModel.didTapSaveButton()
        wait(for: [expectation], timeout: .defaultTimeout)
    }
}

private extension CreateSportEventViewModelTests {
    func viewModel(storageRepository: StorageRepositoryProtocol = StorageRepositoryMock()) -> CreateSportEventViewModelProtocol {
        CreateSportEventViewModel(
            storageRepository: storageRepository,
            cancelEventCreationAction: cancelEventCreationAction,
            saveEventAction: saveEventAction,
            showAlertAction: showAlertAction,
            showActionSheetAction: showActionSheetAction
        )
    }
}
