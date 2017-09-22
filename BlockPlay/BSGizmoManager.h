//
//  BSGizmoManager.h
//  BlockPlay
//
//  Created by Steve Baker on 9/7/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSGizmoManager : NSObject

/**
 type BSGizmosBlock is a block that takes an array
 */
typedef void (^BSGizmosBlock)(NSArray *);

// for simple prototype, don't create a Gizmo class for array elements.
// instead use elements of type NSString
@property NSArray *gizmos;

// will be used to purposely create a retain cycle
@property (nonatomic, strong) BSGizmosBlock gizmosBlock;

+ (BSGizmoManager *)sharedInstance;

/**
 Method runs asynchronously on a background queue.
 In production, observeGizmos might talk with physical gizmos, e.g. to get their names and status.
 This might be relatively slow, so we don't want to block caller while observing gizmos.

 After it gets gizmos status, it gets main queue,
 supplies arguments to gizmosBlock and runs gizmosBlock as a completion block.
 Then gizmosBlock can safely update UI.

 @param gizmosBlock of type BSGizmosBlock. Typically the block contains state from the caller.
 */
- (void)observeGizmos:(BSGizmosBlock)gizmosBlock;

@end
