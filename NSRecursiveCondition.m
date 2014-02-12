/*!
 * NSRecursiveCondition.m
 *
 * Created by Bradley Snyder on 2/12/14.
 * 
 * Copyright 2014 Bradley J. Snyder <snyder.bradleyj@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "NSRecursiveCondition.h"
#import <pthread.h>

@interface NSRecursiveCondition() {
    pthread_mutex_t _lock;
    pthread_cond_t _cond;
}
@end

@implementation NSRecursiveCondition

- (id)init
{
    self = [super init];
    if( self )
    {
        // Init recursive mutex
        pthread_mutexattr_t mattr;
        pthread_mutexattr_init( &mattr );
        pthread_mutexattr_settype( &mattr, PTHREAD_MUTEX_RECURSIVE );
        pthread_mutex_init( &_lock, &mattr );
        pthread_mutexattr_destroy( &mattr );
        
        // Init condition variable
        pthread_condattr_t cattr;
        pthread_condattr_init( &cattr );
        pthread_cond_init( &_cond, &cattr );
        pthread_condattr_destroy( &cattr );
    }
    return self;
}

- (void)dealloc
{
    // Destroy pthread vars
    pthread_cond_destroy( &_cond );
    pthread_mutex_destroy( &_lock );
}

- (void)lock
{
    pthread_mutex_lock( &_lock );
}

- (void)unlock
{
    pthread_mutex_unlock( &_lock );
}

- (void)signal
{
    pthread_cond_signal( &_cond );
}

- (void)broadcast
{
    pthread_cond_broadcast( &_cond );
}

- (void)wait
{
    pthread_cond_wait( &_cond, &_lock );
}

- (BOOL)waitUntilDate:(NSDate*)limit
{
    // Convert NSDate value to struct timespec representation
    struct timespec expireTime;
    NSTimeInterval utime = [limit timeIntervalSince1970];
    expireTime.tv_sec = utime;
    expireTime.tv_nsec = (utime - expireTime.tv_sec) * 1000000000.f;

    return !(pthread_cond_timedwait( &_cond, &_lock, &expireTime ));
}


@end
