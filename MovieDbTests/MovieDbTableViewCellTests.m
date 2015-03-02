//
//  MovieDbTableViewCellTests.m
//  MovieDb
//
//  Created by Saqib Saud on 02/03/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MovieDbTableViewCell.h"

@interface MovieDbTableViewCellTests : XCTestCase

@end

@implementation MovieDbTableViewCellTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMovieDbTableViewCellInit
{
    UINib *incomingCell = [MovieDbTableViewCell nib];
    XCTAssertNotNil(incomingCell, @"Nib should not be nil");
    
    NSString *incomingCellId = [MovieDbTableViewCell cellReuseIdentifier];
    XCTAssertNotNil(incomingCellId, @"Cell identifier should not be nil");
    XCTAssertEqualObjects(incomingCellId, NSStringFromClass([MovieDbTableViewCell class]));
}

@end
