//
//  MovieDbTableViewCell.m
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import "MovieDbTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@implementation MovieDbTableViewCell

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}


#pragma mark - Initialization

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMovie:(CDMovie *) movie{
    self.name.text = movie.name;
    self.year.text = [movie yearString];
    self.popularity.text = [NSString stringWithFormat:@"%.1f", [movie.popularity floatValue]];
    self.thumnail.image = nil;
    [self.thumnail setImageWithURL:movie.thumbNailUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

+ (CGFloat)heightForCell {
    return 70.0;
}

@end
