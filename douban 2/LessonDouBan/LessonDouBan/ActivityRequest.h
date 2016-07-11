//
//  ActivityRequest.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequest.h"
@interface ActivityRequest : NSObject
- (void)activityRequestWithParameter:(NSDictionary *)parameterDic
                       success:(SuccessResponse)success
                       failure:(FailureResponse)failure;
@end
