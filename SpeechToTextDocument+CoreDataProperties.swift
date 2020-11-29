//
//  SpeechToTextDocument+CoreDataProperties.swift
//  casProject
//
//  Created by Yue Fung Lee on 29/11/2020.
//
//

import Foundation
import CoreData


extension SpeechToTextDocument {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpeechToTextDocument> {
        return NSFetchRequest<SpeechToTextDocument>(entityName: "SpeechToTextDocument")
    }

    @NSManaged public var document: String?
    @NSManaged public var title: String?

}

extension SpeechToTextDocument : Identifiable {

}
