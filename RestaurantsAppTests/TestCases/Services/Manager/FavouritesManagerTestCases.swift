//
//  FavouritesManagerTestCases.swift
//  RestaurantsAppTests
//
//  Created by Gabriel Azzinnari on 5/8/22.
//

import Foundation
import Quick
import Nimble
@testable import RestaurantsApp
import CoreData

class FavouritesManagerTestCases: QuickSpec {
    override func spec() {
        var containerMock: NSPersistentContainer!
        var coreDataManager: CoreDataManager!
        var subject: FavouritesManagerDefault!

        describe("FavouritesManagerDefault testcases") {
            beforeEach {
                containerMock = CoreDataMockBuilder.buildContainer()
                coreDataManager = CoreDataManager(persistentContainer: containerMock)
                subject = FavouritesManagerDefault(coreDataManager: coreDataManager)
            }

            describe("isFavourite") {
                context("when uuid stored") {
                    beforeEach {
                        subject.toggleFavourite(for: "1111")
                    }

                    it("should return true") {
                        expect(subject.isFavourite(uuid: "1111")).to(beTrue())
                    }

                    context("when toggling previously favourite restaurant") {
                        beforeEach {
                            subject.toggleFavourite(for: "1111")
                        }

                        it("should return false") {
                            expect(subject.isFavourite(uuid: "1111")).to(beFalse())
                        }
                    }
                }

                context("when restaurant was never marked favourite") {
                    it("should return false") {
                        expect(subject.isFavourite(uuid: "1234")).to(beFalse())
                    }
                }
            }
        }
    }
}
