//
//  BSViewController_Tests.h
//  BlockPlay
//
//  Created by Steve Baker on 4/18/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

// Declare "private" methods for use by unit tests.
// Use extension () instead of category (Tests) and import in BSViewController.m
// This way, compiler checks for incomplete implementation
// Reference
// http://stackoverflow.com/questions/1098550/unit-testing-of-private-methods-in-xcode
// http://lisles.net/accessing-private-methods-and-properties-in-objc-unit-tests/

@interface BSViewController ()

typedef double (^BSDoubleBlock)(double, double);
typedef NSString * (^BSBarBlock)(NSString *);

// declare property so we can use the block similar to a function
@property (strong) BSDoubleBlock doubleBlock;

- (void)foo:(void (^)(void))aBlock;

- (NSString *)bar:(NSString *)aString
            block:(BSBarBlock)aBlock;

@end
