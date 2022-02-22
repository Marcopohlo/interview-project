//
//  StorageTests.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import XCTest
@testable import InterviewProject

final class StorageTests: XCTestCase {

    func testSave() {
        let remoteStorageManager = StorageManagerMock(storageType: .server)
        let localStorageManager = StorageManagerMock(storageType: .local)
        
        let repository = StorageRepository(managers: [remoteStorageManager, localStorageManager])
        repository.start()
        
        XCTAssertTrue(remoteStorageManager.started)
        XCTAssertTrue(localStorageManager.started)
        
        let event = SportEventMock()
        repository.saveEvent(in: .server, event)
        
        XCTAssertEqual(remoteStorageManager.savedEvent?.id, event.id)
        XCTAssertNil(localStorageManager.savedEvent)
    }
    
    func testLoadDataSuccess() async {
        let remoteStorageManager = StorageManagerMock(storageType: .server)
        let localStorageManager = StorageManagerMock(storageType: .local)
        
        let repository = StorageRepository(managers: [remoteStorageManager, localStorageManager])
        repository.start()
        
        let mockData = [SportEventMock()]
        localStorageManager.data = mockData
        
        do {
            let data = try await repository.loadData(from: [.local])
            
            XCTAssertEqual(data.first?.id, mockData.first?.id)
            XCTAssertTrue(localStorageManager.loadDataMethodCalled)
            XCTAssertFalse(remoteStorageManager.loadDataMethodCalled)
        } catch {
            XCTFail("This call should not throw an error.")
        }
    }
    
    func testLoadDataFail() async {
        let remoteStorageManager = StorageManagerMock(storageType: .server, shouldThrow: true)
        
        let repository = StorageRepository(managers: [remoteStorageManager])
        repository.start()
        
        let mockData = [SportEventMock()]
        remoteStorageManager.data = mockData
        
        do {
            _ = try await repository.loadData(from: [.server])
            XCTFail("This call should throw an error.")
        } catch {
            XCTAssertEqual(error as? StorageError, StorageError.unableToFetch)
        }
    }

}
