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


//#define CACHED_CONTENT
#define LOG_NETWORK
#define LOG_CONTENT
//#ifdef NO_COMPRESS_RESPONSE    

#define kTagStory                   @"story"
#define kTagId                      @"id"
#define kTagGuid                    @"guid"
#define kTagStoryType               @"story_type"
#define kTagUrl                     @"url"
#define kTagEstimate                @"estimate"
#define kTagCurrentState            @"current_state"
#define kTagDescription             @"description"
#define kTagName                    @"name"
#define kTagRequestedBy             @"requested_by"
#define kTagOwnedBy                 @"owned_by"
#define kTagCreatedAt               @"created_at"
#define kTagUpdatedAt               @"updated_at"
#define kTagAcceptedAt              @"accepted_at"
#define kTagProject                 @"project"
#define kTagIterationLength         @"iteration_length"
#define kTagWeekStartDay            @"week_start_day"
#define kTagpPointScale             @"point_scale"
#define kTagIteration               @"iteration"
#define kTagNumber                  @"number"
#define kTagStart                   @"start"
#define kTagFinish                  @"finish"
#define kTagAuthor                  @"author"
#define kTagWhen                    @"when"
#define kTagLabels                  @"labels"
#define kTagActivity                @"activity"
#define kTagNote                    @"note"
#define kTagText                    @"text"
#define kTagNotedAt                 @"noted_at"
#define kTagTask                    @"task"
#define kTagPosition                @"position"
#define kTagComplete                @"complete"
#define kTagMembership              @"membership"
#define kTagVelocityScheme          @"velocity_scheme"
#define kTagCurrentVelocity         @"current_velocity"
#define kTagInitialVelocity         @"initial_velocity"
#define kTagNumberOfDoneInterations @"number_of_done_iterations_to_show"
#define kTagAllowsAttachments       @"allow_attachments"
#define kTagPublic                      @"public"
#define kTagUseHttps                    @"use_https"
#define kTagBugAndChoresAreEstimatable  @"bugs_and_chores_are_estimatable"
#define kTagCommitMode                  @"commit_mode"
#define kTagRole                        @"role"
#define kTagIntegration                 @"integration" // integrations
#define kTagActive                      @"active" // integrations
#define kTagTitle                       @"title" // integrations
#define kTagInitials                    @"initials" // membership
#define kTagEmail                       @"email" // membership
#define kTagLastActivityAt              @"last_activity_at" // project
#define kTagOccuredAt                   @"occurred_at"
#define kTagVersion                     @"version" //activity 
#define kTagEventType                   @"event_type" //activity 
#define kTagProjectId                   @"project_id"
#define kTagLighthouseId                @"lighthouse_id"
#define kTagLighthouseUrl               @"lighthouse_url"
#define kTagAttachment                  @"attachment"
#define kTagFilename                    @"filename"
#define kTagUploadedBy                  @"uploaded_by"
#define kTagUploadedAt                  @"uploaded_at"



#define kBooleanTrue    @"true"
#define kBooleanFalse   @"false"

#define kDefaultsApiToken @"apiToken"
#define kDefaultsMyId     @"MyId"

#define kTrackerTokenHeader @"X-TrackerToken"

#define kTypeDone       @"done"
#define kTypeCurrent    @"current"
#define kTypeBacklog    @"backlog"
#define kTypeIcebox     @"icebox"

#define kTypeFeature    @"Feature"
#define kTypeBug        @"Bug"
#define kTypeChore      @"Chore"
#define kTypeRelease    @"Release"

#define kMatchFeature   @"feature"
#define kMatchBug       @"bug"
#define kMatchChore     @"chore"
#define kMatchRelease   @"release"

#define kStateAccepted       @"accepted"
#define kStateStarted        @"started"
#define kStateDelivered      @"delivered"
#define kStateUnStarted      @"unstarted"
#define kStateUnScheduled    @"unscheduled"
#define kStateRelease        @"release"
#define kStateFinished       @"finished"
#define kStateRejected       @"rejected"

#define kPivotalTrackerHost        @"www.apple.com"
#define kUrlRetrieveToken          @"https://www.pivotaltracker.com/services/v3/tokens/active"
//#define kUrlRetrieveToken          @"https://www.pivotaltracker.com/services/v3/tokens/active?username=%@\&password=%@"
#define kUrlProjectList            @"https://www.pivotaltracker.com/services/v3/projects"
#define kUrlIterationList          @"https://www.pivotaltracker.com/services/v3/projects/%d/iterations"    
#define kUrlIterationTypeList      @"https://www.pivotaltracker.com/services/v3/projects/%d/iterations/%@"
#define kUrlActivityStream         @"https://www.pivotaltracker.com/services/v3/activities"
#define kUrlProjectActivityStream  @"https://www.pivotaltracker.com/services/v3/projects/%d/activities"
#define kUrlIceboxStories          @"https://www.pivotaltracker.com/services/v3/projects/%d/stories?filter=current_state:unscheduled"
#define kUrlAddStory               @"https://www.pivotaltracker.com/services/v3/projects/%d/stories"
#define kUrlUpdateStory            @"https://www.pivotaltracker.com/services/v3/projects/%d/stories/%d"
#define kUrlDeleteStory            @"https://www.pivotaltracker.com/services/v3/projects/%d/stories/%d"
#define kUrlAddComment             @"https://www.pivotaltracker.com/services/v3/projects/%d/stories/%d/notes"
#define kUrlUpdateTask             @"http://www.pivotaltracker.com/services/v3/projects/%d/stories/%d/tasks/%d"
#define kUrlAddProject             @"https://www.pivotaltracker.com/services/v3/projects"

#define kResourceStatusKeyPath @"status"
#define kResourceErrorKeyPath @"error"
#define kResourceSavingStatusKeyPath @"savingStatus"



#define kXmlStoryStateTransitiion            @"<story><current_state>%@</current_state><estimate type=\"Integer\">%d</estimate></story>"
#define kXmlStoryStateTransitiionNoEstimate  @"<story><current_state>%@</current_state></story>"
#define kXmlAddStoryFeature                  @"<story><story_type>%@</story_type><name>%@</name><estimate type=\"Integer\">%d</estimate><owned_by>%@</owned_by></story>"
#define kXmlAddStory                         @"<story><story_type>%@</story_type><name>%@</name><owned_by>%@</owned_by></story>"
#define kXmlAddComment                       @"<note><text>%@</text></note>"
#define kXmlAddTask                          @"<task><description>%@</description></task>"
#define kXmlAddProject                       @"<project><name>%@</name><iteration_length type=\"integer\">%d</iteration_length></project>"

#define kEmptyString     @""
#define kComma          @","
#define kFormatNumber    @"%d"
#define kFormatObject    @"%@"

#define kLabelYes        @"YES"
#define kLabelNo        @"NO"

#define kHttpContentType     @"Content-type"
#define kHttpMimeTypeXml     @"application/xml"



#define kKeyType        @"Type"
#define kKeyStoryName   @"StoryName"
#define kKeyEstimate    @"Estimate"
#define kKeyOwned       @"Owned"

#define kDateFormatUTC       @"yyyy/MM/dd HH:mm:ss 'UTC'"
//#define kDateFormatUTC       @"yyyy/MM/dd HH:mm:ss 'Z'"


#define kDateFormatItertion   @"MMMM dd"

#define kDateFormatActivity  @"MM/dd/yyyy hh:mm a"
// Cache File Formats
#define kCacheFileProjects           @"projects.xml"
#define kCacheFileIterations         @"%d_iterations.xml"
#define kCacheFileIterationsGrouped  @"%d_%@_iterations.xml"
#define kCacheFileStories            @"%@_stories_%@.xml"
#define kCacheActivityStream         @"activities.xml"
#define kCacheProjectActivityStream  @"%d_activities.xml"
// String Formats

#define kDefaultStoryTitle       @"please enter the story name"

// Images and Artwork

#define kIconActivity            @"77-ekg.png"

#define kIconTypeFeature         @"feature.png"
#define kIconTypeBug             @"bug.png"
#define kIconTypeRelease         @"release.png"
#define kIconTypeChore           @"chore.png"
#define kIconTypeProject         @"lightbulb.png"

#define kIconComments            @"comment.png"

#define kIconEstimateOnePoint    @"estimate_1pt.gif"
#define kIconEstimateTwoPoints   @"estimate_2pt.gif"
#define kIconEstimateThreePoints @"estimate_3pt.gif"
#define kIconEstimateNone        @"estimate_unestimated.gif"

#define kIconCommentSmall        @"chat_small_inverted.png"
#define kIconComment             @"story_comment_icon.png"

#define RGB(r, g, b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#define kTextStoryNeedsName        @"please enter a story name"
#define kTextStoryDescription       @"please give this story a description"
#define kLabelNoDatesForIteration   @"no dates for this iteration yet"
#define kLabelLoadingProgress       @"Loading, please wait..."
#define kLabelNoIterations          @"there are no iterations"
#define kLabelNoStories             @"there are no stories"
#define kLabelAddStory              @"Add Story"


#define kLabelCommentHeader         @"%@ said %@"
#define kLabelComments              @"comments"
#define kLabelDateRange             @"%@ - %@"
#define kLabelStoryEstimation       @"a %@, estimated as %d point(s)"
#define kLabelStoryComments         @"%d Comments"
#define kLabelStoryAttachments      @"%d Attachments"
#define kLabelStoryTasks            @"%d Tasks"

#define kLableProjectActivity       @"last activity %@"
#define kLabelLastUpdated           @"last updated: "


#define kLabelName                  @"Name"
#define kLabelId                    @"Id"
#define kLabelIterationLength       @"Iteration Length"
#define kLabelWeekStart             @"Week Start"
#define kLabelPointScale            @"Point Scale"
#define kLabelVelocityScheme        @"Velocity Scheme"
#define kLabelCurrentVelocity       @"Current Velocity"
#define kLabelInitialVelocity       @"Initial Velocity"
#define kLabelDoneIterations        @"Done Iterations"
#define kLabelAllowsAttachments     @"Allows Attachments"
#define kLabelPublic                @"Public"
#define kLabelUseHttps              @"User HTTPS"
#define kLabelEstimateBugsChores    @"Estimate Bugs/Chores"
#define kLabelCommitMode            @"Commit Mode"
#define kLabelLastActivity          @"Last Activity"

#define kLabelLoading               @"Loading"
#define kLabelAddComment            @"Add Comment"
#define kLabelActivity              @"Activity"
#define kLabelEditStory             @"Edit Story"
#define kLabelSaving                @"Saving"
#define kLabelEditingStory          @"Editing Story"
#define kLabelSetOwner              @"please select owner"
#define kLabelEditExisting          @"Edit Existing Story"
#define kLabelAddNewStory           @"Add a New Story" 
#define kLabelInformation           @"Information"
#define kLabelProjectDetailInfo     @"Project Detail Information"
#define kLabelProjectMembers        @"Project Members"
#define kLabelDeletingStory         @"Deleting Story"
#define kLabelProjects              @"Projects"
#define kLabelDashboard             @"Dashboard"
#define kLabelIterations            @"Iterations"
#define kLabelComment               @"Comments"
#define kLabelTasks                 @"Tasks"
// Formats

#define kFormatPoints             @"%d Point(s)"
#define kFormatIterationNumber    @"Iteration %d"

#define kFormatMemberCellRole           @"Role: %@"
#define kFormatMemberCellNameIntitials  @"%@ (%@)"
// Cells

#define kIdentifierLabelCell           @"LabelCell"
#define kIdentifierLabelInputCell      @"LabelInputCell"
#define kIdentifierImageLabelCell      @"ImageLabelCell"
#define kIdentifierCenteredCell        @"CenteredLabelCell"
#define kIdentifierActivityLabelCell   @"ActivityLabelCell"
#define kIdentifierIterationStoryCell  @"IterationStoryCell"
#define kIdentifierPlaceholderCell     @"PlaceholderCell"
#define kIdentifierTitleLabelCell      @"TitleLabelCell"
#define kIdentifierCommentCell         @"CommentCell"
#define kIdentifierCell                @"Cell"


//UIActions

#define kButtonLabelEditStory      @"Edit Story"
#define kButtonLabelStart          @"Start Story"
#define kButtonLabelFinish         @"Finish Story"
#define kButtonLabelDeliver        @"Deliver Story"
#define kButtonLabelAccept         @"Accept Story"
#define kButtonLabelReject         @"Reject Reject"
#define kButtonLabelRestart        @"Restart Story"
#define kButtonLabelCancel         @"Cancel"
#define kLabelStoryDetails         @"Story Details"


