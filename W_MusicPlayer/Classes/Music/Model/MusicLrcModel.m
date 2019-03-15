//
//  MusicLrcModel.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicLrcModel.h"

@implementation MusicLrcModel

+ (NSArray <MusicLrcModel *>*)musicLrcListWithFileName:(NSString *)fileName
{
    NSMutableArray *list = [NSMutableArray array];
    
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *lrcString = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcArray = [lrcString componentsSeparatedByString:@"\n"];
   
    for (NSString *lrc in lrcArray) {
        if ([lrc hasPrefix:@"[ti"] || [lrc hasPrefix:@"[ar"] || [lrc hasPrefix:@"[al"] || ![lrc hasPrefix:@"["]) {
            continue;
        }
        
        NSArray *lrcLines =[lrc componentsSeparatedByString:@"]"];
        if (lrcLines.count == 2 || lrcLines.count == 1) {
            MusicLrcModel *model = [[MusicLrcModel alloc] init];
            NSString *timeString = lrcLines[0];
            model.time = [self timeWithString:timeString];
            if (lrcLines.count == 1) {
                model.lrcText = @"";
            }else{
                model.lrcText = lrcLines[1];
            }
            [list addObject:model];
        }else{
            for (int i = 0; i<lrcLines.count-1; i++) {
                MusicLrcModel *model = [[MusicLrcModel alloc] init];
                model.lrcText = [lrcLines lastObject];
                model.time = [self timeWithString:lrcLines[i]];
                [list addObject:model];
            }
        }
        
    }
    
    
    [list sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
    {
        MusicLrcModel *model1 = obj1;
        MusicLrcModel *model2 = obj2;
        if (model1.time  > model2.time){
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    
    return list;
}


+ (NSTimeInterval)timeWithString:(NSString *)timeString
{
    timeString = [timeString stringByReplacingOccurrencesOfString:@"[" withString:@""];
    timeString = [timeString stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSArray *times = [timeString componentsSeparatedByString:@":"];
    NSTimeInterval time = [times[0] integerValue]*60 + [times[1] floatValue];
    return time;
}




@end
