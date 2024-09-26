//
//  VoteDateInfo.swift
//
//
//  Created by Kim Dongjoo on 8/27/24.
//

import Foundation

public struct VoteDateInfo: Equatable {
    let meetStatus: MeetStatus?
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
    
    public init(meetStatus: MeetStatus?, timeInfo: [TimeInfo]?, startVoteDate: Date?, endVoteDate: Date?) {
        self.meetStatus = meetStatus
        self.timeInfo = timeInfo
        self.startVoteDate = startVoteDate
        self.endVoteDate = endVoteDate
    }
}

extension VoteDateInfo {
    public func getCandidateDate() -> (Date, Date) {
        if let startVoteDate = startVoteDate, let endVoteDate = endVoteDate {
            return (startVoteDate, endVoteDate)
        } else {
            return (Date(), Date())
        }
    }
    
    public func getTimeInfoCount() -> Int {
        return timeInfo?.count ?? 0
    }
    
    public func getTimeInfo() -> [TimeInfo]? {
        return timeInfo
    }
    
    public func getMeetStatus() -> MeetStatus? {
        return meetStatus
    }
}

extension VoteDateInfo.TimeInfo {
    public func getVoteTime() -> Date? {
        return voteTime
    }
}
