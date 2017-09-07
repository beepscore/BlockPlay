//
//  ViewController.m
//  BlockPlay
//
//  Created by Steve Baker on 9/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

#import "BSViewController.h"
#import "BSViewController_Tests.h"

@implementation BSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)foo:(void (^)(void))aBlock {
    NSLog(@"Hi from foo.");
    aBlock();
}

- (NSString *)bar:(NSString *)aString
            block:(BSBarBlock)aBlock {
    return aBlock(aString);
}

- (NSString *)baz:(BSBazBlock)aBlock {
    NSString* bazString = @"Only baz knows my value.";

    // Take passed block aBlock, specify local value bazString as argument, and run it.
    // This way we run the block using state from the caller object and from self.
    return aBlock(bazString);
}

- (IBAction)buttonTapped:(id)sender {
    
    // call foo with a block that takes no arguments and doesn't return anything
    [self foo:^(void){
        NSLog(@"Hi from block. sender %@", sender);
    }];
}

@end
