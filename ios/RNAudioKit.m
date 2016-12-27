#import "RNAudioKit.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "AudioKit.framework/Headers/AudioKit.h"

@implementation RNAudioKit

@property (nonatomic, retain) AKMicrophone *_mic;
@property (nonatomic, retain) AKFrequencyTracker *_tracker;
@property (nonatomic, retain) NSTimer *_timer;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

@synthesize bridge = _bridge;

- (id) init {
    NSLog(@"FrequencyTracker init");
    self = [super init];
    return self;
}

RCT_EXPORT_METHOD(start) {
    NSLog(@"FrequencyTracker start");

    // Set up mic/tracker
    _mic = [[AKMicrophone alloc] init];
    _tracker = [[AKFrequencyTracker alloc] init:mic
                                        hopSize:512
                                      peakCount:20];
    _timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0) repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Frequency: %2.2f, Amplitude: %2.2f", _tracker.frequency, _tracker.amplitude);
        [self.bridge.eventDispatcher sendAppEventWithName:@"FrequencyTracker"
                                                     body:@{
                                                            @"frequency": _tracker.frequency,
                                                            @"amplitude": _tracker.amplitude
                                                            }];

    }];

    // Set up output
    AKBooster *silence = [[AKBooster alloc] init:tracker gain:0];
    AudioKit.output = silence;

    // Start listening
    [AudioKit start];
    [_mic start];
    [_tracker start];
}

RCT_EXPORT_METHOD(stop) {
    NSLog(@"FrequencyTracker stop");

    // Stop timer
    [_timer invalidate];
    _timer = nil;

    // Tear down mic and tracker
    [_tracker stop];
    [_mic stop];
    [AudioKit stop];
}

@end

