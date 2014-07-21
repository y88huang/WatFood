//
//  YelpManager.m
//  WatFood
//
//  Created by Ken Huang on 2014-07-17.
//  Copyright (c) 2014 Ken Huang. All rights reserved.
//

#import "FoodManager.h"
#import "Place.h"

@implementation FoodManager

#define API_KEY @"AIzaSyBcEHSHXCIdwqkcMeCLabFaPZc4W3BjUgQ"
#define URL @"https://maps.googleapis.com/maps/api/place/nearbysearch/JSON?"


+ (instancetype)sharedManager
{
    static FoodManager *sharedManager;
    
    @synchronized(self)
    {
        if (!sharedManager) {
            sharedManager = [FoodManager manager];
        }
        
        return sharedManager;
    }
}

- (NSMutableArray *)getFoodInfoFromResponse:(id)responseObject
{
    NSArray *results = responseObject[@"results"];
//    NSLog(@"%@",results);
    NSMutableArray *foodArray = [NSMutableArray array];
    [results enumerateObjectsUsingBlock:^(NSDictionary *dataDict, NSUInteger idx, BOOL *stop) {
        Place *place = [[Place alloc] init];
        place.name = dataDict[@"name"];
        place.iconURL = dataDict[@"icon"];
        place.address = dataDict[@"vicinity"];
        NSDictionary *geometryDict = dataDict[@"geometry"];
        NSString *lat = geometryDict[@"location"][@"lat"];
        NSString *lng = geometryDict[@"location"][@"lng"];
        NSString *locatoin = [NSString stringWithFormat:@"%@,%@",lat,lng];
        place.locatoin = locatoin;
        NSArray *photos = dataDict[@"photos"];
        
        place.photoReference = photos[0][@"photo_reference"];
//        [self getFoodPhotoWithReference:place.photoReference success:^(id responseObject) {
//            NSLog(@"%@",responseObject);
//        } failure:^(AFHTTPRequestOperation *operation) {
//            NSLog(@"%@",operation.error);
//        }];
        [foodArray addObject:place];
    }];
    return foodArray;
}

- (void)getFoodPhotoWithReference:(NSString *)reference success:(void(^)(id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation))failure
{
//    NSString *string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@",@80,@80,reference,API_KEY];
    [self GET:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CoQBegAAAFg5U0y-iQEtUVMfqw4KpXYe60QwJC-wl59NZlcaxSQZNgAhGrjmUKD2NkXatfQF1QRap-PQCx3kMfsKQCcxtkZqQ&key=AIzaSyBcEHSHXCIdwqkcMeCLabFaPZc4W3BjUgQ" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)downloadSomeshit
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CoQBegAAAFg5U0y-iQEtUVMfqw4KpXYe60QwJC-wl59NZlcaxSQZNgAhGrjmUKD2NkXatfQF1QRap-PQCx3kMfsKQCcxtkZqQ&key=AIzaSyBcEHSHXCIdwqkcMeCLabFaPZc4W3BjUgQ"]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    requestOperation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
//        _imageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

- (void)getFoodInfoForLocatoin:(NSString *)location radius:(NSString *)radius  success:(void(^)(id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation))failure
{
    NSString *string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@&radius=%@&key=%@&types=food",location,radius,API_KEY];
    [self GET:string
   parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       if (success) {
           success(responseObject);
       }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation);
        }
    }];
}
@end
