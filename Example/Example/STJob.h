//
//  MSEvent.h
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STJob : NSManagedObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *customer;

- (NSDate *)day; // Derived attribute to make it easy to sort events into days by equality

@end
