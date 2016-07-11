//
//  MovieRequest.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieRequest.h"

@implementation MovieRequest
//- (void)movieRequestWithUrl:(NSString *)url parameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure{
//    
//    NetworkRequest *request = [[NetworkRequest alloc] init];
//    [request requestWithUrl:url parameters:parameterDic successResponse:^(NSDictionary *dic) {
//        success(dic);
//    } failureResponse:^(NSError *error) {
//        failure(error);
//    }];
//    
//}

- (void)movieRequestWithParameter:(NSDictionary *)parameter
                          success:(SuccessResponse)success
                          failure:(FailureResponse)failure {

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request requestWithUrl:MovieRequest_Url parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
}

@end
