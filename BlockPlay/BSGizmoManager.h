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

+ (BSGizmoManager *)sharedInstance;

/**
 The caller supplies gizmosBlock. Typically the block contains state from the caller.
 Method observeGizmos supplies the arguments to gizmosBlock and runs it.
 This way both the caller object and BSGizmoManager can control the block.

 @param gizmosBlock of type BSGizmosBlock.
 @return a string describing gizmos status
 */
- (NSString *)observeGizmos:(BSGizmosBlock)gizmosBlock;

@end
