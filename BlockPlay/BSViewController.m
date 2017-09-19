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
    
    self.gizmoManager = [BSGizmoManager sharedInstance];
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

- (IBAction)fooButtonTapped:(id)sender {

    // call foo with a block that takes no arguments and doesn't return anything
    [self foo:^(void){
        NSLog(@"Hi from foo block. sender %@", sender);
    }];
}

- (IBAction)gizmosButtonTapped:(id)sender {

    // Discussion
    // Objective C
    // Block captures self, but I think it doesn't have retain cycles between any objects.
    // But may be safest to use weak reference.
    // In addition, if user navigates away from view, we might want viewController to be deallocated.
    // Block could accomplish by using weak self
    // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html

    // Swift
    // Similar to Swift closure capture list [weak self]
    // gizmoManager.observeGizmos { [weak self] (error) -> Void in
    //
    // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html
    // Weak and Unowned References
    // unowned may be faster than weak, so more performant to use it if ok.

    // https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift
    // https://stackoverflow.com/questions/30920576/swift-closures-weak-self-and-async-tasks?rq=1

    // Could test memory usage using Xcode debug navigator and/or instruments and uiautomation tests

    // TODO: consider use weakSelf inside block
    // __weak typeof(self)weakSelf = self;

    [self.gizmoManager observeGizmos:^(NSArray *gizmos) {

        // block captures self (self is the viewController not the gizmoManager)
        [self doSomethingWithGizmos:gizmos];
        //[weakSelf doSomethingWithGizmos:gizmos];

        return @"ran BSViewController gizmosBlock";
    }];
}

- (void)doSomethingWithGizmos:(NSArray *)gizmos {
        self.gizmosCountLabel.text = [NSString stringWithFormat: @"%lu",
                                      (unsigned long)gizmos.count];
}

@end
