/*!
 * @header NSRecursiveCondition Class
 * Created by Bradley Snyder on 2/12/14.
 * @copyright Copyright (c) 2014 Bradley J. Snyder. All rights reserved.
 */

#import <Foundation/Foundation.h>

/*!
 * @class NSRecursiveCondition
 * Class with identical functionality to NSCondition, but with a recursive mutex for locking,
 * effectively combining the functionality of NSCondition with NSRecursiveLock.
 */
@interface NSRecursiveCondition : NSObject<NSLocking>

@property NSString *name;

- (void)lock;
- (void)unlock;
- (void)signal;
- (void)broadcast;
- (void)wait;
- (BOOL)waitUntilDate:(NSDate*)limit;

@end
