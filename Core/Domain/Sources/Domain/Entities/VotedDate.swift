//
//  VotedDate.swift
//
//
//  Created by Kim Dongjoo on 8/28/24.
//

import Foundation

public struct VoteDate: Equatable {
    /// 변환된 날짜와 시간
    let voteDate: Date
    
    public init?(voteDate: Date, times: Int) {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: voteDate)
        components.hour = times
        components.minute = 0
        components.second = 0
        
        guard let newDate = calendar.date(from: components) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let formattedDate = dateFormatter.string(from: newDate)
        
        guard let finalDate = dateFormatter.date(from: formattedDate) else {
            return nil
        }
        
        self.voteDate = finalDate
    }
}

extension VoteDate {
    public func getVoteDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: voteDate)
    }
}
