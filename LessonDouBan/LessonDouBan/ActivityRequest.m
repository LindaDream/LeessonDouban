//
//  ActivityRequest.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityRequest.h"

@implementation ActivityRequest
- (void)activityRequestWithParameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure{

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request requestWithUrl:ActivityRequest_Url parameters:parameterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}
@end
