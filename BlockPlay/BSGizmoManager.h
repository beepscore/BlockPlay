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

+ (BSGizmoManager *)sharedInstance;

/**
 The caller supplies gizmosBlock. Typically the block contains state from the caller.
 Method observeGizmos supplies the arguments to gizmosBlock and runs it.
 This way both the caller object and BSGizmoManager can control the block.

 In production, method might talk with physical gizmos, e.g. to get their names and status.
 This might be relatively slow, so we don't want to block UI while observing gizmos.
 Instead we can run gizmosBlock as a completion block.

 @param gizmosBlock of type BSGizmosBlock.
 */
- (void)observeGizmos:(BSGizmosBlock)gizmosBlock;

@end
