/*!
 * @header NSRecursiveCondition Class
 * Created by Bradley Snyder on 2/12/14.
 * @copyright
 *   Copyright 2014 Bradley J. Snyder <snyder.bradleyj@gmail.com>
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
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
