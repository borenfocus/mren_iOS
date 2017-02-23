//
//  MENicknameViewModel.m
//  mrenApp
//
//  Created by zhouen on 16/8/30.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEUpdateViewModel.h"
#import "MEUser.h"
#import "MEUserRequest.h"

@interface MEUpdateViewModel ()
@property (nonatomic, strong) RACCommand *saveCommand;
@end

@implementation MEUpdateViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        self.saveCommand = [[RACCommand alloc] initWithEnabled:[self validateNickName] signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:_nickName];
                [subscriber sendCompleted];
                
                @strongify(self);
                [self updateNickName];
                
                
                return nil;
            }];
        }];
    }
    return self;
}

-(RACSignal *)validateNickName{
    return  [RACObserve(self, nickName) map:^id(NSString *usernameText) {
        NSString *name = [usernameText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSUInteger length = name.length;
        BOOL isChanged = ![name isEqualToString:[MEUser userDefaults].nickname];
        if (length >= 1 && length <= 10 && isChanged) {
            return @(YES);
        }
        return @(NO);
    }];
    
//    return [RACSignal combineLatest:@[RACObserve(self, nickName)] reduce:^id(NSString *nickName){
//        return @(nickName.length > 0 && nickName.length < 10);
//    }];
}

-(void)updateNickName{
    NSString *name = [_nickName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSDictionary *dict = @{@"userUuid":[MEUser userDefaults].uuid,@"nickname":name};
    
    RACSignal *signal = [MEUserRequest updateUserInfo:dict];
    [signal subscribeNext:^(id x) {
        [MEUser userDefaults].nickname = name;
        NSLog(@"修改昵称成功");
    }error:^(NSError *error) {
        NSLog(@"修改昵称失败");
    }];
}


+ (void)updateSex:(NSInteger)sex {
    NSDictionary *dict = @{@"userUuid":[MEUser userDefaults].uuid,@"sex":@(sex)};
    
    RACSignal *signal = [MEUserRequest updateUserInfo:dict];
    [signal subscribeNext:^(id x) {
        [MEUser userDefaults].sex = sex;
        NSLog(@"修改性别成功");
    }error:^(NSError *error) {
        NSLog(@"修改性别失败");
    }];

}


@end
