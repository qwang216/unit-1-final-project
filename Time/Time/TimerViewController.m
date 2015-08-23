//
//  TimerViewController.m
//  Time
//
//  Created by Artur Lan on 8/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (nonatomic) NSTimeInterval countDownDuration;
@property (nonatomic) NSTimeInterval totalTime;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (nonatomic) NSTimer *countdownTimer;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic) NSDate *startTime;


@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cancelButton setHidden:YES];
    [self.resumeButton setHidden:YES];
    
    [self.timer setHidden:YES];
    
    
    NSInteger seconds = 60;
    
    [self.pickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.pickerView setCountDownDuration:seconds];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender {
    [self.startButton setHidden:YES];
    [self.cancelButton setHidden:NO];
    
    self.startTime = [[NSDate alloc] init];
    
    if(sender == self.startButton){
        [self.timer setHidden:NO];
        [self.pickerView setHidden:YES];
        
        
        self.countdownTimer = [NSTimer timerWithTimeInterval:60/60 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];
        
        self.countDownDuration = self.pickerView.countDownDuration;
        
    }
}



- (IBAction)cancelButton:(id)sender {
    
    [self.startButton setHidden:NO];
    [self.cancelButton setHidden:YES];
    [self.pickerView setHidden:NO];
    [self.timer setHidden:YES];
    [self.countdownTimer invalidate];
}

- (IBAction)pauseButton:(id)sender {
    
    
    [self.countdownTimer invalidate];

    [self.pauseButton setHidden:YES];
    [self.resumeButton setHidden:NO];
    
}
- (IBAction)resumeButton:(id)sender {
    [self.pauseButton setHidden:NO];
    [self.resumeButton setHidden:YES];
    
    self.totalTime = self.totalTime - self.countDownDuration;
    
    self.resumeButton = self.startButton;
}

- (void)countDown:(NSTimer *) countdownTimer {
//    NSDate *now = [[NSDate alloc] init];
//    self.countDownDuration = [now timeIntervalSinceDate:self.startTime];
    
    self.countDownDuration = self.countDownDuration - 1;
    int secondsCount = self.countDownDuration;
    int minutes = secondsCount / 60;
    int seconds = secondsCount - (minutes * 60);
    
    self.timer.text = [NSString stringWithFormat:@"%02u:%02u", minutes, seconds];
 
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
