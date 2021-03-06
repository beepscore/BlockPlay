//
//  BSViewController.h
//  BlockPlay
//
//  Created by Steve Baker on 9/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGizmoManager.h"


@interface BSViewController : UIViewController

@property (nonatomic, strong) BSGizmoManager *gizmoManager;

@property (weak, nonatomic) IBOutlet UILabel *gizmosCountLabel;

/**
 type BSBazBlock is a block that takes a string argument and returns a string
 @return a string
 */
typedef NSString * (^BSBazBlock)(NSString *);

/**
 The caller supplies a block. Typically the block contains state from the caller.
 Method baz supplies the arguments to aBlock and runs it.
 This way both the caller object and BSViewController can supply state info to the block code.

 @param aBlock of type BSBazBlock.
 @return a string
 */
- (NSString *)baz:(BSBazBlock)aBlock;

@end

