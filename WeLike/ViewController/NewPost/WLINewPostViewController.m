//
//  WLINewPostViewController.m
//  WeLike
//
//  Created by Planet 1107 on 20/11/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLINewPostViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation WLINewPostViewController


#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"New post";
        [AFPhotoEditorController setAPIKey:kAviaryKey secret:kAviarySecret];
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.imageViewPost.layer.cornerRadius = 3.0f;
    self.imageViewPost.layer.masksToBounds = YES;
    self.textViewPost.layer.cornerRadius = 3.0f;
    
    [self.textViewPost becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Buttons methods

- (IBAction)buttonPostImageTouchUpInside:(id)sender {
    
    if ([self.textViewPost isFirstResponder]) {
        [self.textViewPost resignFirstResponder];
    }
    [[[UIActionSheet alloc] initWithTitle:@"Where do you want to choose your image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Gallery", @"Camera", nil] showInView:self.view];
}

- (IBAction)buttonSendTouchUpInside:(id)sender {
    
    if (!self.textViewPost.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter text." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else if (!self.imageViewPost.image) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please choose image." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        [hud show:YES];
        if ([self.textViewPost isFirstResponder]) {
            [self.textViewPost resignFirstResponder];
        }
        [sharedConnect sendPostWithTitle:self.textViewPost.text postKeywords:nil postImage:self.imageViewPost.image onCompletion:^(WLIPost *post, ServerResponse serverResponseCode) {
            [hud hide:YES];
            self.imageViewPost.image = nil;
            self.textViewPost.text = @"";
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}


#pragma mark - UIImagePickerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    AFPhotoEditorController *photoEditorController = [[AFPhotoEditorController alloc] initWithImage:image];
    photoEditorController.delegate = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:photoEditorController animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (![self.textViewPost isFirstResponder]) {
            [self.textViewPost becomeFirstResponder];
        }
    }];
}


#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Gallery"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


#pragma - AFPhotoEditorController methods

- (void) photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image {
    
    self.imageViewPost.image = image;
    [self.buttonPostImage setTitle:@"" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:^{
        if (![self.textViewPost isFirstResponder]) {
            [self.textViewPost becomeFirstResponder];
        }
    }];
}

- (void) photoEditorCanceled:(AFPhotoEditorController *)editor {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
