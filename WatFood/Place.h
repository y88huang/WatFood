//
//  Place.h
//  WatFood
//
//  Created by Ken Huang on 2014-07-18.
//  Copyright (c) 2014 Ken Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (nonatomic, strong) NSString *locatoin;
@property (nonatomic, strong) NSString *iconURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *photoReference;
@end
