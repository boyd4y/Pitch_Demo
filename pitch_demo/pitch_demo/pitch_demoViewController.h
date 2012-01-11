//
//  pitch_demoViewController.h
//  pitch_demo
//
//  Created by Winston on 12-1-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioServices.h>
#import "SCListener.h"
#import "dywapitchtrack.h"

@interface pitch_demoViewController : UIViewController<BufferFullDelegate> {
    IBOutlet UIButton *recordButton;

    IBOutlet UILabel *desLabel;
    IBOutlet UIView *mainView;
    NSThread *workerThread;
    BOOL isRecording;
    double *MyDoubleArray; 
    dywapitchtracker pitchtracker;
}

-(void)Start;
-(void)Stop;

-(IBAction)handleRecordEvent:(id)sender;

@property (nonatomic, retain) UIButton *recordButton;
@property (nonatomic, retain) UILabel *desLabel;
@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, assign) BOOL isRecording;


- (void)BufferFullCallback:(AudioQueueBufferRef)buffer withPacketDesc:(const AudioStreamPacketDescription *)inPacketDescs;

@end
