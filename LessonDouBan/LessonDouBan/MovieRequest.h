//
//  MovieRequest.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieRequest : NSObject
//- (void)movieRequestWithUrl:(NSString *)url
//                     parameter:(NSDictionary *)parameterDic
//                       success:(SuccessResponse)success
//                       failure:(FailureResponse)failure;

- (void)movieRequestWithParameter:(NSDictionary *)parameter
                    success:(SuccessResponse)success
                    failure:(FailureResponse)failure;
@end
