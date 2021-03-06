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

#import "ASIHTTPRequest.h"
#import "PivotalObject.h"
@class PivotalTrackerEngine;
@interface PivotalManager : NSObject {

    int logLevel;
    PivotalTrackerEngine *engine;
    
    NSMutableDictionary *entities;
    
    
}

@property (nonatomic, assign) int logLevel;
@property (nonatomic, retain) PivotalTrackerEngine *engine;
@property (nonatomic, retain) NSMutableDictionary *entities;

+ (PivotalManager*) main;
+ (void) setMain: (PivotalManager*)newMain;

#pragma mark -
#pragma mark Alerts & Errors
+ (void) alertWithError:(NSError*)error;
+ (void) alertWithTitle:(NSString*)title andMessage:(NSString*)message;


//- (void)addEntity:(NSObject*)entity forKey:(NSString*)key;
//- (id)entityForKey:(NSString*)key;
//
//- (id)entitiyForProject:(NSString*)projectId withEntityId:(NSString*)entity;
//- (NSString*)addEntityToProject:(NSString*)projectId entity:(PivotalObject*)entity;


@end
