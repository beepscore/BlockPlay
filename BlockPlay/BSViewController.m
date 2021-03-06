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

/**
 * Questioner: what will be logged, in what order?
 * My answer
 * 1,
 * I know dispatch_sync can be risky.
 * dispatch_sync will block until it executes, so 2 will be followed by 3.
 * 4 will come after 3
 * 2 possible orders?
 * 1,2,3,4,5 or 1,5,2,3,4
 *
 * Questioner: Nope.
 * Execution deadlocks on dispatch_sync.
 *
 *
 @param sender object that called the method
 */
- (IBAction)logButtonTapped:(id)sender {

    // Serial queue
    // Both serial and concurrent queues are FIFO, start executing tasks in the order they were added to the queue.
    // Serial queue has only one thread, executes one task at a time.
    // In contrast, a concurrent queue starts tasks in queue order but they can finish in a different order.
    dispatch_queue_t q = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);

    NSLog(@"1");

    // dispatch_async returns control immediately.
    // It schedules task "2" to be done but doesn't wait for it
    dispatch_async(q, ^{
        NSLog(@"2");

        // Ray Wenderlich tutorial "Never dispatch sync onto current queue, this will deadlock"
        // https://stackoverflow.com/questions/15381209/how-do-i-create-a-deadlock-in-grand-central-dispatch
        // https://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd
        // dispatch_sync suspends execution of task "2" until task "3" completes
        // but serial queue won't start task 3 until 2 finishes
        // ==> deadlock

        // can see this in Xcode, tap logButton, app logs 1, 5, 2, then stops on dispatch_sync with message:
        // Thread 5: EXC_BAD_INSTRUCTION(code=EXC_I386_INVOP,subcode=0x0)
        // In call stack Thread 5 top line 0_dispatch_sync_wait, click to see detail:
        // "BUG IN CLIENT OF LIBDISPATCH: dispatch_sync called on queue already owned by current thread"
        dispatch_sync(q, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
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
    }];
}

- (void)doSomethingWithGizmos:(NSArray *)gizmos {
        self.gizmosCountLabel.text = [NSString stringWithFormat: @"%lu",
                                      (unsigned long)gizmos.count];
}

- (void)dealloc {
    NSLog(@"BSViewController dealloc");
}

@end
