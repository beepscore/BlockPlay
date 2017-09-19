//
//  BSGizmoManager.m
//  BlockPlay
//
//  Created by Steve Baker on 9/7/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import "BSGizmoManager.h"

@implementation BSGizmoManager

// http://stackoverflow.com/questions/5720029/create-singleton-using-gcds-dispatch-once-in-objective-c
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{

        // call designated initializer
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// designated initializer
- (instancetype)init {
    if(self = [super init]) {
        self.gizmos = @[];
    }
    return self;
}

- (void)observeGizmos:(BSGizmosBlock)gizmosBlock {

    self.gizmos = @[@"Mary", @"Bill", @"George"];

    // Take passed block gizmosBlock, specify local value gizmos as argument, and run it.
    NSString *gizmosBlockResult = gizmosBlock(self.gizmos);
    NSLog(@"log to silence unused variable warning, %@", gizmosBlockResult);
}


@end
