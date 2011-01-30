//
//	Copyright (c) 2008-2011, Mark Lussier
//	http://github.com/intabulas/ipivotal
//	All rights reserved.
//
//	This software is released under the terms of the BSD License.
//	http://www.opensource.org/licenses/bsd-license.php
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	* Redistributions of source code must retain the above copyright notice, this
//	  list of conditions and the following disclaimer.
//	* Redistributions in binary form must reproduce the above copyright notice,
//	  this list of conditions and the following disclaimer
//	  in the documentation and/or other materials provided with the distribution.
//	* Neither the name of iPivotal nor the names of its contributors may be used
//	  to endorse or promote products derived from this software without specific
//	  prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//	OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "PivotalManager.h"
#import "Reachability.h"
#import "PivotalTrackerEngine.h"

@implementation PivotalManager

@synthesize logLevel, engine, entities;

#pragma mark -
#pragma mark Static access

static PivotalManager* _main;
+ (PivotalManager*) main { return _main; }
+ (void) setMain:(PivotalManager*) newMain { _main = newMain; }


#pragma mark -
#pragma mark Configuration

- (id) init {
    if (self = [super init]) {        
        if (_main == nil) {
            _main = self;
        }        
        logLevel = 1;
        
        engine   = [[PivotalTrackerEngine alloc] init];
        entities = [[NSMutableDictionary  alloc] initWithCapacity:50];
        
    }
    return self;
}


//- (void)addEntity:(NSObject*)entity forKey:(NSString*)key {
//    NSMutableDictionary *entityDict = [[NSMutableDictionary alloc] initWithCapacity: 10];
//    [entityDict setObject:entity forKey:@"self"];
//    [entityDict setValue:[NSDate date] forKeyPath:@"lastUpdated"];    
//    [entities setObject:entityDict forKey:key];
//}
//
//- (id)entityForKey:(NSString*)key {
//  return [entities valueForKeyPath:key];
//}
//
//- (id)entitiyForProject:(NSString*)projectId withEntityId:(NSString*)entity {
//    return [self entityForKey:[NSString stringWithFormat:@"%@.%@", projectId, entity]]; 
//    
//}
//
//- (NSString*)addEntityToProject:(NSString*)projectId entity:(PivotalObject*)entity {
//    
//    NSMutableDictionary *projectDict = [entities objectForKey:projectId];    
//    [projectDict setValue:[NSDate date] forKeyPath:@"lastUpdated"];
//    NSString *key = [NSString  stringWithFormat:@"%d", [entity objectId]];
//    [projectDict setObject:entity forKey:key];
//    NSLog(@"%@", entities);
//    
//    return key;
//}
//
//

#pragma mark -
# pragma mark Alerts

+ (void) alertWithError:(NSError*)error {
    [self alertWithTitle:@"Error" andMessage:[error localizedDescription]];
}

+ (void) alertWithTitle:(NSString*)title andMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void) dealloc {
    [entities removeAllObjects]; [entities release]; entities = nil;
    [engine release]; engine = nil;
    [super dealloc];
}

@end
