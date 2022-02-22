//
//  CreateSportEventViewModelTests.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import XCTest
@testable import InterviewProject

final class CreateSportEventViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCancel() throws {
        let expectation = XCTestExpectation()
        var viewModel = viewModel()
        viewModel.didCancelEventCreation = {
            expectation.fulfill()
        }
        viewModel.didTapCancelButton()
        wait(for: [expectation], timeout: .defaultTimeout)
    }

    func testSaveEvent() throws {
        let expectation = XCTestExpectation()
        let storageRepositoryMock = StorageRepositoryMock()
        var viewModel = viewModel(storageRepository: storageRepositoryMock)
        viewModel.didSaveEvent = {
            XCTAssertEqual(storageRepositoryMock.savedEvent?.name, "Mock Event")
            XCTAssertEqual(storageRepositoryMock.savedEvent?.place, "Mock Place")
            expectation.fulfill()
        }
        viewModel.nameTextFieldEditingChanged("Mock Event")
        viewModel.placeTextFieldEditingChanged("Mock Place")
        viewModel.didSelectPickerRow(4, inComponent: 0)
        viewModel.saveEvent(storageType: .server)
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testPicker() throws {
        let viewModel = viewModel()
        XCTAssertEqual(viewModel.numberOfPickerComponents(), 3)
        XCTAssertEqual(viewModel.numberOfPickerRowsInComponent(0), 24)
        XCTAssertEqual(viewModel.numberOfPickerRowsInComponent(1), 60)
        XCTAssertEqual(viewModel.numberOfPickerRowsInComponent(2), 60)
        XCTAssertEqual(viewModel.titleForRow(5, forComponent: 1), "5 m")
    }
    
    func testShowMissingItemsAlert() throws {
        let expectation = XCTestExpectation()
        var viewModel = viewModel()
        viewModel.showAlert = {
            expectation.fulfill()
        }
        viewModel.didTapSaveButton()
        wait(for: [expectation], timeout: .defaultTimeout)
    }
    
    func testShowActionSheet() throws {
        let expectation = XCTestExpectation()
        var viewModel = viewModel()
        viewModel.showActionSheet = {
            expectation.fulfill()
        }
        viewModel.nameTextFieldEditingChanged("Mock Event")
        viewModel.placeTextFieldEditingChanged("Mock Place")
        viewModel.didSelectPickerRow(4, inComponent: 0)
        viewModel.didTapSaveButton()
        wait(for: [expectation], timeout: .defaultTimeout)
    }
}

private extension CreateSportEventViewModelTests {
    func viewModel(storageRepository: StorageRepositoryProtocol = StorageRepositoryMock()) -> CreateSportEventViewModelProtocol {
        CreateSportEventViewModel(storageRepository: storageRepository)
    }
}