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

    // use __block so gizmosBlock can change gizmo1
    __block NSString *gizmo1 = @"";

    [[BSGizmoManager sharedInstance] observeGizmos:^(NSArray *gizmos) {
        gizmo1 = gizmos[1];
    }];

    XCTAssertEqual([BSGizmoManager sharedInstance].gizmos.count, 3);

    XCTAssertTrue([gizmo1 isEqualToString:@"Bill"]);

    // clean up
    [BSGizmoManager sharedInstance].gizmos = @[];
}

@end
