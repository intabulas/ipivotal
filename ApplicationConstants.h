
//#define CACHED_CONTENT
//#define LOG_NETWORK
//#ifdef NO_COMPRESS_RESPONSE    

#define kTagStory                   @"story"
#define kTagId                      @"id"
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
#define kUrlAddComment             @"https://www.pivotaltracker.com/services/v3/projects/%d/stories/%d/notes"

#define kResourceStatusKeyPath @"status"
#define kResourceErrorKeyPath @"error"
#define kResourceSavingStatusKeyPath @"savingStatus"



#define kXmlStoryStateTransitiion            @"<story><current_state>%@</current_state><estimate type=\"Integer\">%d</estimate></story>"
#define kXmlStoryStateTransitiionNoEstimate  @"<story><current_state>%@</current_state></story>"
#define kXmlAddStoryFeature                  @"<story><story_type>%@</story_type><name>%@</name><estimate type=\"Integer\">%d</estimate></story>"
#define kXmlAddStory                         @"<story><story_type>%@</story_type><name>%@</name></story>"
#define kXmlAddComment                       @"<note><text>%@</text></note>"

#define kEmptyString     @""


#define kHttpContentType     @"Content-type"
#define kHttpMimeTypeXml     @"application/xml"



#define kKeyType        @"Type"
#define kKeyStoryName   @"StoryName"
#define kKeyEstimate    @"Estimate"


#define kDateFormatUTC       @"yyyy/MM/dd HH:mm:ss 'UTC'"
//#define kDateFormatUTC       @"yyyy/MM/dd HH:mm:ss 'Z'"

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

#define RGB(r, g, b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#define kTextStoryNeedsName        @"please enter a story name"
#define kTextStoryDescription       @"please give this story a description"
#define kLabelNoDatesForIteration   @"no dates for this iteration yet"
#define kLabelLoading               @"Loading, please wait..."
#define kLabelNoIterations          @"there are no iterations"
#define kLabelNoStories             @"there are no stories"
#define kLabelAddStory              @"Add Story"
#define kLabelEditStory             @"Story Updated"

#define kLabelCommentHeader         @"%@ said %@"
#define kLabelComments              @"comments"
#define kLabelDateRange             @"%@ - %@"
#define kLabelStoryEstimation       @"a %@, estimated as %d point(s)"
#define kLabelStoryComments         @"%d Comments"
#define kLabelStoryAttachments      @"%d Attachments"
#define kLabelStoryTasks            @"%d Tasks"

#define kLableProjectActivity       @"last activity %@"
// Formats

#define kFormatPoints             @"%d Point(s)"
#define kFormatIterationNumber    @"Iteration %d"

// Cells

#define kIdentifierLabelCell           @"LabelCell"
#define kIdentifierImageLabelCell      @"ImageLabelCell"
#define kIdentifierCenteredCell        @"CenteredLabelCell"
#define kIdentifierActivityLabelCell   @"ActivityLabelCell"
#define kIdentifierIterationStoryCell  @"IterationStoryCell"


//UIActions

#define kButtonLabelEditStory      @"Edit Story"
#define kButtonLabelStart          @"Start"
#define kButtonLabelFinish         @"Finish"
#define kButtonLabelDeliver        @"Deliver"
#define kButtonLabelAccept         @"Accept"
#define kButtonLabelReject         @"Reject"
#define kButtonLabelRestart        @"Restart"
#define kButtonLabelCancel         @"Cancel"
#define kTitleStoryActions         @"Story Actions"


