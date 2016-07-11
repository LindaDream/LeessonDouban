//
//  RegisterRequest.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

- (void)RegisterWithUserName:(NSString *)userName passWord:(NSString *)passWord avatar:(UIImage *)avatar success:(SuccessResponse)success failure:(FailureResponse)failure{

    NSDictionary *parameter = @{@"userName":userName,@"password":passWord};
    NetworkRequest *request = [[NetworkRequest alloc]init];
    [request sendImageWithUrl:RegisterRequest_Url parameters:parameter image:avatar successResponse:^(NSDictionary *dic) {
        success(dic);
                
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

@end
