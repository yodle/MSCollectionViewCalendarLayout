//
//  MSEventCell.h
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STJob;

@interface MSEventCell : UICollectionViewCell

@property (nonatomic, weak) STJob *job;

@property (nonatomic, strong) UILabel *summary;
@property (nonatomic, strong) UILabel *customer;

@end
