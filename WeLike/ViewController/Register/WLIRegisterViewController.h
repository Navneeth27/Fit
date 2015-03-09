//
//  WLIRegisterViewController.h
//  WeLike
//
//  Created by Planet 1107 on 20/11/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLIViewController.h"
#import "NIDropDown.h"

@interface WLIRegisterViewController : WLIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, MKMapViewDelegate, NIDropDownDelegate> {
    
    BOOL locatedUser;
    NIDropDown *dropDown;
    
   IBOutlet UIButton *chooseSpeciality;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewRegister;
@property (strong, nonatomic) IBOutlet UIView *viewContentRegister;
@property (strong, nonatomic) IBOutlet UIView *viewCompany;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewAvatar;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (strong, nonatomic) IBOutlet UITextField *textFieldRepassword;
@property (strong, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *textFieldFullName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlUserType;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (strong, nonatomic) IBOutlet UITextField *textFieldWeb;
@property (strong, nonatomic) IBOutlet UITextField *textFieldAddress;
@property (strong, nonatomic) IBOutlet MKMapView *mapViewLocation;
@property (strong, nonatomic) IBOutlet UIButton *buttonRegister;

@property (retain, nonatomic) IBOutlet UIButton *chooseSpeciality;


- (IBAction)selectClients:(id)sender;


//@property (weak, nonatomic) IBOutlet UIPickerView *picker;



- (IBAction)buttonSelectAvatarTouchUpInside:(UIButton *)sender;
- (IBAction)segmentedControlUserTypeValueChanged:(UISegmentedControl *)sender;
- (IBAction)buttonRegisterTouchUpInside:(id)sender;



-(void)rel;

@end
