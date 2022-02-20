//
//  SportEventsViewState.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation

enum SportEventsViewState {
    case loading
    case data([SportEventsData])
    case error(Error)

    // MARK: - Properties
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .data, .error:
            return false
        }
    }
    
    var weatherData: [SportEventsData]? {
        switch self {
        case .data(let weatherData):
            return weatherData
        case .error, .loading:
            return nil
        }
    }
    
    var weatherDataError: Error? {
        switch self {
        case .error(let weatherDataError):
            return weatherDataError
        case .data,
             .loading:
            return nil
        }
    }

}
