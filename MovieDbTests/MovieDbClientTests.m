//
//  MovieDbClientTests.m
//  MovieDb
//
//  Created by Saqib Saud on 14/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AFMovieDbClient.h"

@interface MovieDbClientTests : XCTestCase

@end

@implementation MovieDbClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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

- (void) testPopularMovies{
    [[AFMovieDbClient sharedInstance] GET:@"movie/popular" parameters:[@{@"page":[NSNumber numberWithInt:1], @"sort_by": @"popularity.asc"}mutableCopy] success:^(NSURLSessionDataTask * __unused task, id JSON) {
        if (!JSON) {
            XCTFail(@"No data returned");
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (error) {
            XCTFail(@"Error:%@",[error description]);
        }
    }];
}

- (void) testMovieDetails{
    [[AFMovieDbClient sharedInstance] GET:[NSString stringWithFormat:@"movie/%i",4989] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        if (!JSON) {
            XCTFail(@"No data returned");
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (error) {
            XCTFail(@"Error:%@",[error description]);
        }
    }];
}

@end
