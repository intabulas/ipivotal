
//#define CACHED_CONTENT
//#define LOG_NETWORK
//#ifdef NO_COMPRESS_RESPONSE    

#define kTagStory              @"story"
#define kTagId                 @"id"
#define kTagStoryType          @"story_type"
#define kTagUrl                @"url"
#define kTagEstimate           @"estimate"
#define kTagCurrentState       @"current_state"
#define kTagDescription        @"description"
#define kTagName               @"name"
#define kTagRequestedBy        @"requested_by"
#define kTagOwnedBy            @"owned_by"
#define kTagCreatedAt          @"created_at"
#define kTagAcceptedAt         @"accepted_at"
#define kTagProject            @"project"
#define kTagIterationLength    @"iteration_length"
#define kTagWeekStartDay       @"week_start_day"
#define kTagpPointScale        @"point_scale"
#define kTagIteration          @"iteration"
#define kTagNumber             @"number"
#define kTagStart              @"start"
#define kTagFinish             @"finish"
#define kTagAuthor             @"author"
#define kTagWhen               @"when"
#define kTagActivity           @"activity"
#define kTagNote               @"note"
#define kTagText               @"text"
#define kTagNotedAt            @"noted_at"

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
#define kUrlRetrieveToken          @"https://www.pivotaltracker.com/services/tokens/active"
#define kUrlProjectList            @"http://www.pivotaltracker.com/services/v2/projects"
#define kUrlIterationList          @"http://www.pivotaltracker.com/services/v2/projects/%d/iterations"    
#define kUrlIterationTypeList      @"http://www.pivotaltracker.com/services/v2/projects/%d/iterations/%@"
#define kUrlActivityStream         @"http://www.pivotaltracker.com/services/v2/activities"
#define kUrlProjectActivityStream  @"http://www.pivotaltracker.com/services/v2/projects/%d/activities"
#define kUrlIceboxStories          @"http://www.pivotaltracker.com/services/v2/projects/%d/stories?filter=current_state:unscheduled"
#define kUrlAddStory               @"http://www.pivotaltracker.com/services/v2/projects/%d/stories"
#define kUrlUpdateStory            @"http://www.pivotaltracker.com/services/v2/projects/%d/stories/%d"

#define kUrlAddComment             @"http://www.pivotaltracker.com/services/v2/projects/%d/stories/%d/notes"

#define kResourceStatusKeyPath @"status"
#define kResourceErrorKeyPath @"error"



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

#define RGB(r, g, b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#define kTextStoryNeedsName       @"please enter a story name"

#define kLabelNoDatesForIteration   @"no dates for this iteration yet"
#define kLabelLoading               @"Loading, please wait..."
#define kLabelNoIterations          @"there are no iterations"
#define kLabelNoStories             @"there are no stories"
#define kLabelAddStory              @"Add Story"
#define kLabelEditStory             @"Story Updated"


// Formats

#define kFormatPoints             @"%d Point(s)"
#define kFormatIterationNumber    @"Iteration %d"

// Cells

#define kIdentifierLabelCell           @"LabelCell"
#define kIdentifierImageLabelCell      @"ImageLabelCell"
#define kIdentifierCenteredCell        @"CenteredLabelCell"
#define kIdentifierActivityLabelCell   @"ActivityLabelCell"
#define kIdentifierIterationStoryCell  @"IterationStoryCell"




