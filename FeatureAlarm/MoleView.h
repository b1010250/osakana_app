//
//  MoleView.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PunchViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVAudioPlayer.h>


@interface MoleView : UIView{
    UIImageView	*moleImageView; 
    id	viewController; 
    UILabel*scoreLabel; //スコア表示
    
    IBOutlet UILabel *testLabel;//test用
    
}
- (void)setup; 
@property (readonly) UIImageView	*moleImageView; 
@property (readonly) UILabel *scoreLabel;

@end
