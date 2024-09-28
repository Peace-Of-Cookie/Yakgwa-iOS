//
//  MeetStatus.swift
//  Domain
//
//  Created by Kim Dongjoo on 9/26/24.
//

public enum MeetStatus: String, Decodable {
    case confirm = "CONFIRM"
    case beforeConfirm = "BEFORE_CONFIRM"
    case vote = "VOTE"
    case beforeVote = "BEFORE_VOTE"
}
