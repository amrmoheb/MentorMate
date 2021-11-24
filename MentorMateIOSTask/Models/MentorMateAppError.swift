//
//  File.swift
//  MentorMateIOSTask
//
//  Created by Mac on 11/24/21.
//

import Foundation

enum MentorMateAppError : Error
{
    case NetworkingError(message : String)
    case ParsingError(message : String)
    case CoreDataError(message : String)
}
