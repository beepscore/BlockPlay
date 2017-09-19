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

    // https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1
    // https://stackoverflow.com/questions/12693197/dispatch-get-global-queue-vs-dispatch-get-main-queue#12693409
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // dispatch task asynchronously so it won't block caller
    dispatch_async(globalQueue, ^{

        // for prototype, use fake gizmos
        self.gizmos = @[@"Mary", @"Bill", @"George"];

        // use main queue to run gizmosBlock. Then it can safely update UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            // Take passed block gizmosBlock, specify local value gizmos as argument, and run it.
            gizmosBlock(self.gizmos);
        });

    });
}


@end
