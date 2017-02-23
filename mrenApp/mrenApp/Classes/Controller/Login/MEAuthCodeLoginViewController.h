//
//  PTETAuthCodeLoginViewController.h
//  PeanutEntertainment
//
//  Created by zhouen on 16/8/23.
//
//

#import <UIKit/UIKit.h>
typedef void (^AuthLoginBlock)();

@interface MEAuthCodeLoginViewController : UIViewController

@property (nonatomic, copy) AuthLoginBlock authLoginSuccessBlock;

- (void)authLoginSuccessfulJump:(AuthLoginBlock)block;
@end
