//
//  BSGizmoManagerTests.m
//  BlockPlay
//
//  Created by Steve Baker on 9/7/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSGizmoManager.h"

@interface BSGizmoManagerTests : XCTestCase
@property (strong, nonatomic) BSGizmoManager *gizmoManager;
@end

@implementation BSGizmoManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - test sharedInstance
- (void)testSharedInstance {
    self.gizmoManager = [BSGizmoManager sharedInstance];
    // call sharedInstance again to check it returns the same instance
    // XCTAssertEqual is the identical object
    // XCTAssertEqualObjects tests objectA isEqual:objectB
    XCTAssertEqual([BSGizmoManager sharedInstance],
                   self.gizmoManager,
                   @"expected sharedInstance returns same instance");
}

- (void)testSharedInstanceGizmosEmpty {
    self.gizmoManager = [BSGizmoManager sharedInstance];
    XCTAssertEqual([BSGizmoManager sharedInstance].gizmos.count, 0);
}

- (void)testObserveGizmos {

    XCTAssertEqual([BSGizmoManager sharedInstance].gizmos.count, 0);

    // expectation example in Objective C
    // https://www.bignerdranch.com/blog/asynchronous-testing-with-xcode-6/
    // Might be simpler to write this in Swift!
    XCTestExpectation *expectation = [self expectationWithDescription:@"gizmos"];

    [[BSGizmoManager sharedInstance] observeGizmos:^(NSArray *gizmos) {
        XCTAssertEqual([BSGizmoManager sharedInstance].gizmos.count, 3);
        XCTAssertTrue([gizmos[1] isEqualToString:@"Bill"]);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];

    // clean up
    [BSGizmoManager sharedInstance].gizmos = @[];
}

@end
