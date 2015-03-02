//
//  PopularMoviesViewControllerTests.m
//  MovieDb
//
//  Created by Saqib Saud on 02/03/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PopularMoviesViewController.h"

@interface PopularMoviesViewControllerTests : XCTestCase

@property (nonatomic) PopularMoviesViewController *vcToTest;
@end

@implementation PopularMoviesViewControllerTests

- (void)setUp {
    [super setUp];
    self.vcToTest = [PopularMoviesViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
