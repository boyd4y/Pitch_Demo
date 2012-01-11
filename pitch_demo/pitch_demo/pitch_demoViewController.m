//
//  pitch_demoViewController.m
//  pitch_demo
//
//  Created by Winston on 12-1-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "pitch_demoViewController.h"
#import "dywapitchtrack.h"
#import "SCListener.h"

@implementation pitch_demoViewController

@synthesize recordButton;
@synthesize desLabel;
@synthesize mainView;
@synthesize isRecording;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // init double array
    MyDoubleArray = malloc(4096 * sizeof(double)); 

    
    // load button
    CGRect cgRct = CGRectMake(0.0, 0.0, 480, 320); //define size and position of view
    mainView = [[UIView alloc]initWithFrame:cgRct];
    mainView.autoresizesSubviews = YES;
    self.view = mainView;
    
    recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    recordButton.frame = CGRectMake(50, 100, 200, 50);
    [recordButton setTitle:@"Start" forState:UIControlStateNormal];
    recordButton.adjustsImageWhenHighlighted = YES;
    [recordButton addTarget:self action:@selector(handleRecordEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    desLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 350, 50)];
    desLabel.text = @"Press to start";
    
    [self.view addSubview:recordButton];

    [self.view addSubview:desLabel];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)handleRecordEvent:(id)sender
{
    if (isRecording)
    {
        [self Stop];
    }
    else
    {
        [self Start];
    }
}

- (void)BufferFullCallback:(AudioQueueBufferRef)buffer withPacketDesc:(const AudioStreamPacketDescription *)inPacketDescs
{
    /* Usage
     
     // Allocate your audio buffers and start the audio stream.
     // Allocate a 'dywapitchtracker' structure.
     // Start the pitch tracking by calling 'dywapitch_inittracking'.
     dywapitchtracker pitchtracker;
     dywapitch_inittracking(&pitchtracker);
     
     // For each available audio buffer, call 'dywapitch_computepitch'
     double thepitch = dywapitch_computepitch(&pitchtracker, samples, start, count);
    */
    
    // this creates an array of short pointer that pointer to the audio data of the incoming buffer. It forces C to consider mAudioData as an array of shorts. 
    short *audioDataAsShort = (short *)buffer->mAudioData; 
    
    // then you can convert to double : 
    for (int i =0;i<4096;i++){ 
        MyDoubleArray[i]= (double)audioDataAsShort[i]; 
    } 
    
    double thepitch = 0.0;
    thepitch = (int)dywapitch_computepitch(&pitchtracker, MyDoubleArray, 0, 4096);
    
    NSLog(@"Pitch detected %g....", thepitch);
    
    [desLabel performSelectorOnMainThread:@selector(setText:) 
                               withObject:[NSString stringWithFormat:@"Recording pitch %g", thepitch]
                            waitUntilDone:YES];
}

-(void)Start
{
    [recordButton setTitle:@"Stop" forState:UIControlStateNormal];
    [desLabel setText:@"Recording...."];
    
    SCListener* listener = [SCListener sharedListener];
    [listener setDelegate:self];
    [[SCListener sharedListener] listen];
    
    isRecording = YES;
    
    dywapitch_inittracking(&pitchtracker);
}

-(void)Stop
{
    [recordButton setTitle:@"Start" forState:UIControlStateNormal];
    [desLabel setText:@"Press to start"];
    
    SCListener* listener = [SCListener sharedListener];
    [listener setDelegate:nil];
    [[SCListener sharedListener] stop];
    
    isRecording = NO;
}

@end
