//
//  BSViewControllerTests.m
//  BlockPlay
//
//  Created by Steve Baker on 9/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSViewController.h"
#import "BSViewController_Tests.h"

@interface BSViewControllerTests : XCTestCase
@property BSViewController *bsViewController;
@end

@implementation BSViewControllerTests

- (void)setUp {
    [super setUp];

    _bsViewController = [[BSViewController alloc] init];
}

- (void)tearDown {
    _bsViewController = nil;

    [super tearDown];
}

- (void)testBarBlock {
    NSString *testString = @"Larry";
    BSBarBlock testBlock = ^(NSString *aString) {
        return [@"testBar " stringByAppendingString:aString];
    };

    NSString *actualResult = [self.bsViewController bar:testString
                                                  block:testBlock];
    NSString *expectedResult = @"testBar Larry";
    XCTAssertEqualObjects(expectedResult, actualResult,
                          @"Expected %@ but got %@", expectedResult, actualResult);

    testString = @"Moe";

    //variables in scope are available to testBlock
    NSString *personL = @"Larry";
    NSString *personC = @"Curly";
    testBlock = ^(NSString *someString) {
        return [NSString stringWithFormat:@"%@ %@ %@", someString, personL, personC];
    };

    actualResult = [self.bsViewController bar:testString
                                        block:testBlock];
    expectedResult = @"Moe Larry Curly";
    XCTAssertEqualObjects(expectedResult, actualResult,
                          @"Expected %@ but got %@", expectedResult, actualResult);
}

- (void)testBaz {
    BSBazBlock testBlock = ^(NSString *aString) {
        // object that runs testBlock will supply block with argument aString
        return [aString stringByAppendingString:@" Caller supplied me."];
    };

    NSString *actualResult = [self.bsViewController baz:testBlock];
    NSString *expectedResult = @"Only baz knows my value. Caller supplied me.";
    XCTAssertEqualObjects(expectedResult, actualResult,
                          @"Expected %@ but got %@", expectedResult, actualResult);


    NSString * testString = @" I'm the test string from the caller.";
    testBlock = ^(NSString *aString) {
        // object that runs testBlock will supply block with argument aString
        // testBlock gets testString value from scope just outside this block
        return [aString stringByAppendingString:testString];
    };

    actualResult = [self.bsViewController baz:testBlock];
    expectedResult = @"Only baz knows my value. I'm the test string from the caller.";
    XCTAssertEqualObjects(expectedResult, actualResult,
                          @"Expected %@ but got %@", expectedResult, actualResult);
}

- (void)testUsingDoubleBlockToDivide {
    self.bsViewController.doubleBlock = ^(double a, double b){

        double result = 0;

        if (0 == b) {
            result = DBL_MAX;
        } else {
            result = (a / b);
        }
        return result;
    };

    double first = 6.0;
    double second = 2.0;

    double actualResult = self.bsViewController.doubleBlock(first, second);
    double expectedResult = 3.0;
    XCTAssertEqualWithAccuracy(expectedResult, actualResult, 0.01,
                               @"Expected %f but got %f", expectedResult, actualResult);
    first = 6.0;
    second = 0.0;

    actualResult = self.bsViewController.doubleBlock(first, second);
    expectedResult = DBL_MAX;
    XCTAssertEqualWithAccuracy(expectedResult, actualResult, 0.01,
                               @"Divide by zero expected %f but got %f", expectedResult, actualResult);
}

- (void)testUsingDoubleBlockToMultiply {
    self.bsViewController.doubleBlock = ^(double a, double b){
        return a * b;
    };

    double first = 2.0;
    double second = 3.1;

    double actualResult = self.bsViewController.doubleBlock(first, second);

    double expectedResult = 6.2;
    XCTAssertEqualWithAccuracy(expectedResult, actualResult, 0.01,
                               @"Expected %f but got %f", expectedResult, actualResult);
}

- (void)testViewDidLoadSetsGizmoManager {
    // https://developer.apple.com/documentation/foundation/nsbundle?language=objc
    NSBundle *bundle = [NSBundle bundleForClass:[BSViewController class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: bundle];
    BSViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BSViewController"];

    XCTAssertNil(viewController.gizmoManager);

    // call view to trigger viewDidLoad()
    // https://stackoverflow.com/questions/28733016/view-controller-tdd
    UIView *unusedDontCare = viewController.view;

    XCTAssertNotNil(viewController.gizmoManager);

    // XCTAssertEqual is the identical object
    // XCTAssertEqualObjects tests objectA isEqual:objectB
    XCTAssertEqual([BSGizmoManager sharedInstance],
                   viewController.gizmoManager,
                   @"expected sharedInstance returns same instance");
}

@end
