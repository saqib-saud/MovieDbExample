//
//  MovieDbTableViewCell.h
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDbTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumnail;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *popularity;

/**
 *  Returns UINib file initialized for this cell
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during
 *  initialization or the nib file could not be located.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify a reusable cell for text message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)cellReuseIdentifier;

/**
 *
 *
 *  @param movie CDMovie object to load cell properties
 */
- (void) setMovie:(CDMovie *) movie;
/**
 *
 *
 *  @return Height of cell
 */
+ (CGFloat)heightForCell;

@end
