//
//  ChatMessageCell.h
//  QuickStart
//
//  Created by Abir Majumdar on 12/3/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSChatMessageCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *deviceLabel;
@property (nonatomic, weak) IBOutlet UILabel *timestampLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UIImageView *messageStatus;

@end
