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

- (void)testObserveGizmos {

    NSString *actual = [[BSGizmoManager sharedInstance] observeGizmos:^(NSArray *gizmos) {
    }];

    XCTAssertTrue([actual isEqualToString:@"all gizmos are ok"]);
}

@end