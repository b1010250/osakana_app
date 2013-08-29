//
//  WakeUpViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>

@interface WakeUpViewController : UIViewController{
    IBOutlet UILabel *timeLabelH;
    NSTimer*myTicker;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIButton *resultButton;

    AVAudioPlayer *funPlayer;

}

@end
