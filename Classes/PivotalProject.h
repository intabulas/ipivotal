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


@interface PivotalProject : NSObject {
    NSInteger projectId;
    NSString *name;
    NSInteger iterationLength;
    NSString *weekStartDay;
    NSString *pointScale;
	NSString *velocityScheme;
	NSInteger currentVelocity;
	NSInteger initialVelocity;
	NSInteger numberDoneIterations;
	BOOL      allowsAttachments;
	BOOL      publicProject;
	BOOL      useHttps;
	BOOL      estimateBugsAndChores;
	BOOL      commitMode;
	NSMutableArray *members;
	NSMutableArray *integrations;
	NSDate *lastActivityAt;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *weekStartDay;
@property (nonatomic, retain) NSString *pointScale;
@property (nonatomic, readwrite) NSInteger  projectId;
@property (nonatomic, readwrite) NSInteger iterationLength;
@property (nonatomic, retain) NSString *velocityScheme;
@property (nonatomic, readwrite) NSInteger currentVelocity;
@property (nonatomic, readwrite) NSInteger initialVelocity;
@property (nonatomic, readwrite) NSInteger numberDoneIterations;
@property (nonatomic, assign) BOOL allowsAttachments;
@property (nonatomic, assign) BOOL publicProject;
@property (nonatomic, assign) BOOL useHttps;
@property (nonatomic, assign) BOOL estimateBugsAndChores;
@property (nonatomic, assign) BOOL commitMode;
@property (nonatomic, retain) NSDate *lastActivityAt;

@property (nonatomic, retain) NSMutableArray *members;
@property (nonatomic, retain) NSMutableArray *integrations;




@end

