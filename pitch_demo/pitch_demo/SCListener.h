//
// SCListener 1.0.1
// http://github.com/stephencelis/sc_listener
//
// (c) 2009-* Stephen Celis, <stephen@stephencelis.com>.
// Released under the MIT License.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioServices.h>

//Define the protocol for the delegate
@protocol BufferFullDelegate
- (void)BufferFullCallback:(AudioQueueBufferRef)buffer withPacketDesc:(const AudioStreamPacketDescription *)inPacketDescs;
@end

@interface SCListener : NSObject {
	AudioQueueLevelMeterState *levels;
	
	AudioQueueRef queue;
	AudioStreamBasicDescription format;
	Float64 sampleRate;
    
    id <BufferFullDelegate> delegate;
}

+ (SCListener *)sharedListener;

- (void)listen;
- (BOOL)isListening;
- (void)pause;
- (void)stop;

- (Float32)averagePower;
- (Float32)peakPower;
- (AudioQueueLevelMeterState *)levels;

@property (nonatomic, assign) id  <BufferFullDelegate> delegate;  

@end
