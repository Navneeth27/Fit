//
//  WLIUserCell.m
//  WeLike
//
//  Created by Planet 1107 on 07/01/14.
//  Copyright (c) 2014 Planet 1107. All rights reserved.
//

#import "WLIUserCell.h"
#import "UIImageView+AFNetworking.h"

@implementation WLIUserCell

#pragma mark - Object lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.imageViewUserImage.layer.cornerRadius = self.imageViewUserImage.frame.size.height/2;
    self.imageViewUserImage.layer.masksToBounds = YES;
}


#pragma mark - Cell methods

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.imageViewUserImage setImageWithURL:[NSURL URLWithString:self.user.userAvatarPath]];
    self.labelUserName.text = self.user.userFullName;
    if (self.user.followingUser) {
        [self.buttonFollowUnfollow setImage:[UIImage imageNamed:@"btn-unfollow.png"] forState:UIControlStateNormal];
    } else {
        [self.buttonFollowUnfollow setImage:[UIImage imageNamed:@"btn-follow.png"] forState:UIControlStateNormal];
    }
}


#pragma mark - Action methods

- (IBAction)buttonUserTouchUpInside:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(showUser:sender:)]) {
        [self.delegate showUser:self.user sender:self];
    }
}

- (IBAction)buttonFollowUnfollowTouchUpInside:(UIButton *)sender {
    
    
    if (self.user.followingUser) {
        if ([self.delegate respondsToSelector:@selector(unfollowUser:sender:)]) {
            [self.delegate unfollowUser:self.user sender:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(followUser:sender:)]) {
            [self.delegate followUser:self.user sender:self];
        }
    }
}

@end
