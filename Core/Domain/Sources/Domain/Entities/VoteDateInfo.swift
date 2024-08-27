//
//  VoteDateInfo.swift
//
//
//  Created by Kim Dongjoo on 8/27/24.
//

import Foundation

public struct VoteDateInfo: Equatable {
    let meetStatus: String?
    let timeInfo: [TimeInfo]?
    let startVoteDate: Date?
    let endVoteDate: Date?
    
    public struct TimeInfo: Equatable {
        let timeId: Int?
        let voteTime: Date?
        
        public init(timeId: Int?, voteTime: Date?) {
            self.timeId = timeId
            self.voteTime = voteTime
        }
    }
    
    public init(meetStatus: String?, timeInfo: [TimeInfo]?, startVoteDate: Date?, endVoteDate: Date?) {
        self.meetStatus = meetStatus
        self.timeInfo = timeInfo
        self.startVoteDate = startVoteDate
        self.endVoteDate = endVoteDate
    }
}
