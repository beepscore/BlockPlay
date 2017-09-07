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

@end
