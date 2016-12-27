//
//  FrequencyTracker.m
//  RNAudioKit
//
//  Created by Jason R Ardell on 12/27/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "FrequencyTracker.h"
#import "AudioKit.framework/Headers/AudioKit.h"

@implementation FrequencyTracker

@property (nonatomic, retain) AKMicrophone *_mic;
@property (nonatomic, retain) AKFrequencyTracker *_tracker;
@property (nonatomic, retain) NSTimer *_timer;

@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    return self;
}

RCT_EXPORT_METHOD(start) {
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
    // Stop timer
    [_timer invalidate];
    _timer = nil;

    // Tear down mic and tracker
    [_tracker stop];
    [_mic stop];
    [AudioKit stop];
}

@end
