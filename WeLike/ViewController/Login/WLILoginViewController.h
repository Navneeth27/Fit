//
//  WLILoginViewController.h
//  WeLike
//
//  Created by Planet 1107 on 20/11/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLIViewController.h"

@interface WLILoginViewController : WLIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewLogin;
@property (strong, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (strong, nonatomic) IBOutlet UIView *viewContentLogin;

- (IBAction)buttonRegisterTouchUpInside:(id)sender;

@end
