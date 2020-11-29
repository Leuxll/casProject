//
//  TextToSpeechDocument+CoreDataProperties.swift
//  casProject
//
//  Created by Yue Fung Lee on 29/11/2020.
//
//

import Foundation
import CoreData


extension TextToSpeechDocument {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TextToSpeechDocument> {
        return NSFetchRequest<TextToSpeechDocument>(entityName: "TextToSpeechDocument")
    }

    @NSManaged public var document: String?
    @NSManaged public var title: String?

}

extension TextToSpeechDocument : Identifiable {

}
