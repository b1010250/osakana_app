//
//  PunchViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolBox.h>
#import <AudioToolbox/AudioServices.h>
#import "MoleView.h"
#import "AppDelegate.h"
#import "Audio.h"



@interface PunchViewController : UIViewController {
    
    IBOutlet UILabel *timeLabelH;
    NSTimer*myTicker;
    
    id viewController;
    
    IBOutlet UIView	*gameView; //パンチゲームのビュー(透明です)
    IBOutlet UILabel*scoreLabel; // スコア表示
    //IBOutlet UIView*viewController;
    NSTimer	*moleTimer; //ランダム表示のタイマー
    
    AVAudioPlayer *alarmPlayer; //アラーム音の再生プレーヤー
    AVAudioPlayer *punchPlayer; //パンチ音の再生プレーヤー
    
    
    
    // UIImageView	*moleImageView; // 追加行
    
}
//@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (readonly) UIImageView	*moleImageView; // 追加行
@property (readonly) UILabel *scoreLabel;




- (void)addScore; // 追加行
@end
