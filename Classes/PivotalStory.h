//
//	Copyright (c) 2008-2010, Mark Lussier
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

#import <Foundation/Foundation.h>
#import "PivotalResource.h"


@class PivotalProject;
@interface PivotalStory : PivotalResource {
    NSInteger storyId;
    NSString *storyType;	
    NSURL    *url;
    NSInteger estimate;
    NSString *currentState;
    NSString *description;
    NSString *name;
    NSString *requestedBy;
    NSString *owner;
    NSDate  *createdAt;
    NSDate *updatedAt;
    NSDate  *acceptedAt;
	NSString *lighthouseUrl;
	NSInteger lighthouseId;
	
    NSMutableArray *comments;
    NSMutableArray *tasks; 
	NSMutableArray *attachments;
    PivotalProject *project;
    NSMutableArray *labels;

}

@property (nonatomic, readwrite) NSInteger storyId;
@property (nonatomic, retain) NSString *storyType;
@property (nonatomic, retain) NSURL    *url;
@property (nonatomic, readwrite) NSInteger estimate;
@property (nonatomic, retain) NSString *currentState;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *requestedBy;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSDate  *createdAt;
@property (nonatomic, retain) NSDate  *updatedAt;
@property (nonatomic, retain) NSDate  *acceptedAt;
@property (nonatomic, retain) NSMutableArray  *comments;
@property (nonatomic, retain) NSMutableArray  *tasks;
@property (nonatomic, retain) NSMutableArray  *attachments;
@property (nonatomic, retain) NSMutableArray *labels;
@property (nonatomic, retain) NSString *lighthouseUrl;
@property (nonatomic, readwrite) NSInteger lighthouseId;



- (id)init;
- (id)initWithStoryId:(NSInteger)theId;
- (id)initWithStoryId:(NSInteger)theId andProject:(PivotalProject *)theProject;
- (NSString *)to_xml;

- (void)loadStory;

@end

