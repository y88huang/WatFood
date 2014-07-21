//
//  YelpManager.h
//  WatFood
//
//  Created by Ken Huang on 2014-07-17.
//  Copyright (c) 2014 Ken Huang. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface FoodManager : AFHTTPRequestOperationManager

- (void)getFoodInfoForLocatoin:(NSString *)location radius:(NSString *)radius success:(void(^)(id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation))failure;

- (NSMutableArray *)getFoodInfoFromResponse:(id)responseObject;
+ (instancetype)sharedManager;

- (void)getFoodPhotoWithReference:(NSString *)reference success:(void(^)(id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation))failure;
- (void)downloadSomeshit;

@end
