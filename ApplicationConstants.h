
#define kDefaultsApiToken @"apiToken"


#define kTrackerTokenHeader @"X-TrackerToken"

#define kUrlProjectList            @"https://www.pivotaltracker.com/services/v2/projects"
#define kUrlIterationList          @"https://www.pivotaltracker.com/services/v2/projects/%d/iterations"    
#define kUrlIterationTypeList      @"https://www.pivotaltracker.com/services/v2/projects/%d/iterations/%@"
#define kUrlActivityStream         @"http://www.pivotaltracker.com/services/v2/activities"
#define kUrlProjectActivityStream  @"https://www.pivotaltracker.com/services/v2/projects/%d/activities"
#define kUrlIceboxStories          @"http://www.pivotaltracker.com/services/v2/projects/%d/stories?filter=current_state:unscheduled"
#define kUrlAddStory               @"http://www.pivotaltracker.com/services/v2/projects/%d/stories"

#define kResourceStatusKeyPath @"status"
#define kResourceErrorKeyPath @"error"


// Cache File Formats

#define kCacheFileStories            @"%@_stories_%@.xml"
#define kCacheActivityStream         @"activities.xml"
#define kCacheProjectActivityStream  @"%d_activities.xml"
// String Formats

#define kDefaultStoryTitle       @"please enter the story name"

// Images and Artwork

#define kIconTypeFeature         @"feature.png"
#define kIconTypeBug             @"bug.png"
#define kIconTypeRelease         @"release.png"
#define kIconTypeChore           @"chore.png"
#define kIconTypeProject         @"lightbulb.png"

#define kIconEstimateOnePoint    @"estimate_1pt.gif"
#define kIconEstimateTwoPoints   @"estimate_2pt.gif"
#define kIconEstimateThreePoints @"estimate_3pt.gif"
#define kIconEstimateNone        @"estimate_unestimated.gif"

#define RGB(r, g, b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]