# Purpose
Practice using blocks.

# References
Apple Blocks Programming Topics Getting Started with Blocks

# Results

## Blocks can be used instead of delegates.

### Review of delegate pattern
A delegator has a delegate.
When the delegator wants the delegate to do something, it "calls back" via a delegate method.
For example a tableView has a delegate, typically a tableViewController.

#### Delegate protocol
Specifies methods ("callbacks") delegate will implement.
E.g. UITableViewDelegate Protocol
    tableView:didSelectRowAtIndexPath:
    tableView:heightForRowAtIndexPath:

#### Delegate
Implements at least some methods in the protocol.

#### Delegator
Has a property 'delegate' that points to its delegate.
Generally the delegate sets the delegator's delegate property.
Calls delegate when it wants delegate to do something.

---

### Block pattern
Object "called" can have a method that accepts a block as an argument.
Object "caller" can create a block, call object "called" method and pass the block.
The block can contain info from within the scope of "caller".
"called" can execute the block.
If the block takes arguments, "called" can supply them.
This way, called can execute the block code using state from both caller and called.

This pattern eliminates the need for a delegate protocol.

This pattern keeps related code within the caller, making it easier to write and read.
The caller specifies the block code, typically using locally scoped variables.
The programmer can write and see the block code from the caller object, then just pass the block to the called object to run it.
Generally this is clearer and shorter than delegate having to extract info about delegator object.
e.g. Avoids delegate tableViewController extracting info about delegator tableView from delegate method argument "tableView".
If the block needs to use information from the called object, the block can specify parameters and the called object can supply the arguments to the block when it runs the block.