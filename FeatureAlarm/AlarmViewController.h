//
//  AlarmViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/12.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface AlarmViewController : UIViewController{
    IBOutlet UILabel *timeLabelH;
    IBOutlet UILabel *testLabel;//test用
    NSTimer*myTicker;
    AVAudioPlayer *alarmPlayer; //アラーム音の再生プレーヤー    
}

- (void)testTime:(NSTimer *)timer;
//- (IBAction)respondToButtonClick:(UIButton*)sender;
@property (readonly) UIImageView	*zzzImageView; // 追加行

@end
