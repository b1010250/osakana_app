//
//  ShoutViewController.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/16.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "Audio.h"



@interface ShoutViewController : UIViewController{
    IBOutlet UILabel *timeLabelH;
    AVAudioPlayer *alarmPlayer; //アラーム音の再生プレーヤー 
    AVAudioPlayer *PPlayer;
}
@property (strong, nonatomic) IBOutlet UILabel *char_box3;
@property (strong, nonatomic) IBOutlet UILabel *char_box2;
@property (strong, nonatomic) IBOutlet UILabel *char_box1;
@property (strong, nonatomic) IBOutlet UIButton *go_shout;
@property (strong, nonatomic) IBOutlet UIButton *char_box3_down;
@property (strong, nonatomic) IBOutlet UIButton *char_box2_down;
@property (strong, nonatomic) IBOutlet UIButton *char_box1_down;
@property (strong, nonatomic) IBOutlet UIButton *char_box3_up;
@property (strong, nonatomic) IBOutlet UIButton *char_box2_up;
@property (strong, nonatomic) IBOutlet UIButton *char_box1_up;
@property (strong, nonatomic) IBOutlet UIImageView *shout_frame;
@property (strong, nonatomic) IBOutlet UILabel *quest;
@property NSMutableArray *char_list1;
@property NSMutableArray *char_list2;
@property NSMutableArray *char_list3;

-(IBAction)GoShoutPush:(id)sender;
-(void)ShoutRandom;
-(void)shout_item_0;
-(void)shout_item_1;
-(void)shout_item_2;
-(void)shout_item_3;
-(void)shout_item_4;
-(void)shout_item_5;
-(void)shout_item_6;
-(void)shout_item_7;
-(void)shout_item_8;
-(void)shout_item_9;

-(IBAction)CharBox1UpPush:(id)sender;
-(IBAction)CharBox2UpPush:(id)sender;
-(IBAction)CharBox3UpPush:(id)sender;
-(IBAction)CharBox1DownPush:(id)sender;
-(IBAction)CharBox2DownPush:(id)sender;
-(IBAction)CharBox3DownPush:(id)sender;






@end
