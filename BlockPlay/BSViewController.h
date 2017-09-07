//
//  BSViewController.h
//  BlockPlay
//
//  Created by Steve Baker on 9/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSViewController : UIViewController

// define type BSBazBlock as a block that takes a string argument and returns a string
typedef NSString * (^BSBazBlock)(NSString *);

// baz: takes a block argument of type BSBazBlock.
// Expose this method for use by other objects.
// The caller object supplies aBlock, typically the block contains state from the caller.
// BSBazBlock takes a string argument.
// Method baz: supplies the string argument to aBlock and runs it.
// This way both the caller object and BSViewController can supply state info to the block code.
- (NSString *)baz:(BSBazBlock)aBlock;

@end

