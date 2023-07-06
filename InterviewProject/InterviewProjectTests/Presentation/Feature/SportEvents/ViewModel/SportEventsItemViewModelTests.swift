//
//  SportEventsItemViewModelTests.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import XCTest
@testable import InterviewProject

final class SportEventsItemViewModelTests: XCTestCase {

    func testRemoteEventData() {
        let event = SportEventMock()
        let viewModel = SportEventsItemViewModel(event: event)
        XCTAssertEqual(viewModel.name, event.name)
        XCTAssertEqual(viewModel.place, event.place)
        XCTAssertEqual(viewModel.duration, event.duration.asString(style: .positional))
        XCTAssertEqual(viewModel.iconName, "cloud.fill")
        XCTAssertEqual(viewModel.iconColor, .cyan)
    }
    
    func testLocalEventData() {
        var event = SportEventMock()
        event.isRemote = false
        let viewModel = SportEventsItemViewModel(event: event)
        XCTAssertEqual(viewModel.iconName, "externaldrive.fill")
        XCTAssertEqual(viewModel.iconColor, .gray)
    }
}
