//
//  WLIConnect.m
//  WeLike
//
//  Created by Planet 1107 on 9/20/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLIConnect.h"
#import <AWSiOSSDKv2/S3.h>
#import <AWSiOSSDKv2/AWSCore.h>

#define kBaseLink @"http://fitovate.elasticbeanstalk.com"
#define kAPIKey @"!#wli!sdWQDScxzczFžŽYewQsq_?wdX09612627364[3072∑34260-#"
#define kConnectionTimeout 30
#define kCompressionQuality 1.0f

//Server status responses
#define kOK @"OK"
#define kBAD_REQUEST @"BAD_REQUEST"
#define kNO_CONNECTION @"NO_CONNECTION"
#define kSERVICE_UNAVAILABLE @"SERVICE_UNAVAILABLE"
#define kPARTIAL_CONTENT @"PARTIAL_CONTENT"
#define kCONFLICT @"CONFLICT"
#define kUNAUTHORIZED @"UNAUTHORIZED"
#define kNOT_FOUND @"NOT_FOUND"
#define kUSER_CREATED @"USER_CREATED"
#define kUSER_EXISTS @"USER_EXISTS"
#define kLIKE_CREATED @"LIKE_CREATED"
#define kLIKE_EXISTS @"LIKE_EXISTS"
#define kFORBIDDEN @"FORBIDDEN"
#define kCREATED @"CREATED"


@implementation WLIConnect

static WLIConnect *sharedConnect;

+ (WLIConnect*) sharedConnect {
    
    if (sharedConnect != nil) {
        return sharedConnect;
    }
    sharedConnect = [[WLIConnect alloc] init];
    return sharedConnect;
}

- (id)init {
    self = [super init];
    
    // comment for user persistance
    // [self removeCurrentUser];
    
    if (self) {
        //added for aws connection
        AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
        // Construct the NSURL for the download location.
        NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"downloaded-shoes.jpg"];
        NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
        
        // Construct the download request.
        AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
        
        downloadRequest.bucket = @"findatrainerv1";
        downloadRequest.key = @"shoes.jpg";
        downloadRequest.downloadingFileURL = downloadingFileURL;
        
        
        // Download the file.
        [[transferManager download:downloadRequest] continueWithExecutor:[BFExecutor mainThreadExecutor]
                                                               withBlock:^id(BFTask *task) {
                                                                   if (task.error){
                                                                       if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                           switch (task.error.code) {
                                                                               case AWSS3TransferManagerErrorCancelled:
                                                                               case AWSS3TransferManagerErrorPaused:
                                                                                   break;
                                                                                   
                                                                               default:
                                                                                   NSLog(@"Error: %@", task.error);
                                                                                   break;
                                                                           }
                                                                       } else {
                                                                           // Unknown error.
                                                                           NSLog(@"Error: %@", task.error);
                                                                       }
                                                                   }
                                                                   
                                                                   if (task.result) {
                                                                       AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
                                                                       //File downloaded successfully.
                                                                       NSLog(@"rr: %@", @"yayy: %@");NSLog(@"rr: %@", @"yayy: %@");NSLog(@"rr: %@", @"yayy: %@");NSLog(@"rr: %@", @"yayy: %@");NSLog(@"rr: %@", @"yayy: %@");NSLog(@"rr: %@", @"yayy: %@");
                                                                   }
                                                                   return nil;
                                                               }];
        //added for aws connection
        
        
        httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseLink]];
        [httpClient.requestSerializer setValue:kAPIKey forHTTPHeaderField:@"api_key"];
        httpClient.responseSerializer = [AFJSONResponseSerializer serializer];
        json = [[SBJsonParser alloc] init];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _dateOnlyFormatter = [[NSDateFormatter alloc] init];
        [_dateOnlyFormatter setDateFormat:@"MM/dd/yyyy"];
        [_dateOnlyFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
        NSData *archivedUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"_currentUser"];
        if (archivedUser) {
            _currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:archivedUser];
        }
    }
    return self;
}

- (void)saveCurrentUser {
    
    if (self.currentUser) {
        NSData *archivedUser = [NSKeyedArchiver archivedDataWithRootObject:_currentUser];
        [[NSUserDefaults standardUserDefaults] setObject:archivedUser forKey:@"_currentUser"];
    }
}

- (void)removeCurrentUser {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"_currentUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - User

- (void)loginUserWithUsername:(NSString*)username andPassword:(NSString*)password onCompletion:(void (^)(WLIUser *user, ServerResponse serverResponseCode))completion {
    
    if (!username.length || !password.length) {
        completion(nil, BAD_REQUEST);
    } else {
        NSDictionary *parameters = @{@"username": username, @"password": password};
        [httpClient POST:@"/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rawUser = [responseObject objectForKey:@"item"];
            _currentUser = [[WLIUser alloc] initWithDictionary:rawUser];
            
            [self saveCurrentUser];
            
            [self debugger:parameters.description methodLog:@"api/login" dataLogFormatted:responseObject];
            completion(_currentUser, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/login" dataLog:error.description];
            if (operation.response) {
                completion(nil, operation.response.statusCode);
            } else {
                completion(nil, NO_CONNECTION);
            }
        }];
    }
}

- (void)registerUserWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email userAvatar:(UIImage*)userAvatar userType:(int)userType userFullName:(NSString*)userFullName userInfo:(NSString*)userInfo latitude:(float)latitude longitude:(float)longitude companyAddress:(NSString*)companyAddress companyPhone:(NSString*)companyPhone companyWeb:(NSString*)companyWeb onCompletion:(void (^)(WLIUser *user, ServerResponse serverResponseCode))completion {
    
    if (!username.length || !password.length || !email.length) {
        completion(nil, BAD_REQUEST);
    } else {
        NSDictionary *parameters = @{@"username" : username, @"password" : password, @"email" : email, @"userFullname" : userFullName, @"userTypeID" : @(userType), @"userInfo" : userInfo, @"userLat" : @(latitude), @"userLong" : @(longitude), @"userAddress" : companyAddress, @"userPhone" : companyPhone, @"userWeb" : companyWeb};
        [httpClient POST:@"/register" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (userAvatar) {
                NSData *imageData = UIImageJPEGRepresentation(userAvatar, kCompressionQuality);
                if (imageData) {
                    [formData appendPartWithFileData:imageData name:@"userAvatar" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rawUser = [responseObject objectForKey:@"item"];
            _currentUser = [[WLIUser alloc] initWithDictionary:rawUser];
            [self saveCurrentUser];
            [self debugger:parameters.description methodLog:@"api/register" dataLogFormatted:responseObject];
            completion(_currentUser, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/register" dataLog:error.description];
            if (operation.response) {
                completion(nil, operation.response.statusCode);
            } else {
                completion(nil, NO_CONNECTION);
            }
        }];
    }
}

- (void)userWithUserID:(int)userID onCompletion:(void (^)(WLIUser *user, ServerResponse serverResponseCode))completion {
    
    if (userID < 1) {
        completion(nil, BAD_REQUEST);
    } else {
        NSDictionary *parameters = @{@"userID": [NSString stringWithFormat:@"%d", self.currentUser.userID], @"forUserID": [NSString stringWithFormat:@"%d", userID]};
        [httpClient POST:@"getProfile" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rawUser = [responseObject objectForKey:@"item"];
            WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser];
            if (user.userID == _currentUser.userID) {
                _currentUser = user;
                [self saveCurrentUser];
            }
            [self debugger:parameters.description methodLog:@"api/getProfile" dataLogFormatted:responseObject];
            completion(user, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/getProfile" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
    }
}

- (void)updateUserWithUserID:(int)userID userType:(WLIUserType)userType userEmail:(NSString*)userEmail password:(NSString*)password userAvatar:(UIImage*)userAvatar userFullName:(NSString*)userFullName userInfo:(NSString*)userInfo latitude:(float)latitude longitude:(float)longitude companyAddress:(NSString*)companyAddress companyPhone:(NSString*)companyPhone companyWeb:(NSString*)companyWeb onCompletion:(void (^)(WLIUser *user, ServerResponse serverResponseCode))completion {
    
    if (userID < 1) {
        completion(nil, BAD_REQUEST);
    } else {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:[NSString stringWithFormat:@"%d", userID] forKey:@"userID"];
        if (userType) {
            [parameters setObject:[NSString stringWithFormat:@"%d", userType] forKey:@"userTypeID"];
        }
        if (userEmail.length) {
            [parameters setObject:userEmail forKey:@"email"];
        }
        if (password.length) {
            [parameters setObject:password forKey:@"password"];
        }
        if (userFullName.length) {
            [parameters setObject:userFullName forKey:@"userFullname"];
        }
        if (userInfo.length) {
            [parameters setObject:userInfo forKey:@"userInfo"];
        }
        [parameters setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"userLat"];
        [parameters setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"userLong"];
        if (companyAddress.length) {
            [parameters setObject:companyAddress forKey:@"userAddress"];
        }
        if (companyPhone.length) {
            [parameters setObject:companyPhone forKey:@"userPhone"];
        }
        if (companyWeb.length) {
            [parameters setObject:companyWeb forKey:@"userWeb"];
        }
        
        [httpClient POST:@"setProfile" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (userAvatar) {
                NSData *imageData = UIImageJPEGRepresentation(userAvatar, kCompressionQuality);
                if (imageData) {
                    [formData appendPartWithFileData:imageData name:@"userAvatar" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rawUser = [responseObject objectForKey:@"item"];
            WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser];
            self.currentUser = user;
            [self saveCurrentUser];
            
            [self debugger:parameters.description methodLog:@"api/setProfile" dataLogFormatted:responseObject];
            completion(user, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/setProfile" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
    }
}

- (void)newUsersWithPageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *users, ServerResponse serverResponseCode))completion {
    
    NSDictionary *parameters = @{@"userID": [NSString stringWithFormat:@"%d", self.currentUser.userID], @"take": [NSString stringWithFormat:@"%d", pageSize]};
    [httpClient POST:@"getNewUsers" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawUsers = [responseObject objectForKey:@"items"];
        
        NSMutableArray *users = [NSMutableArray arrayWithCapacity:rawUsers.count];
        for (NSDictionary *rawUser in rawUsers) {
            WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser];
            [users addObject:user];
        }
        
        [self debugger:parameters.description methodLog:@"api/getNewUsers" dataLogFormatted:responseObject];
        completion(users, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/getNewUsers" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}

- (void)usersForSearchString:(NSString*)searchString page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *users, ServerResponse serverResponseCode))completion {
    
    if (!searchString.length) {
        completion(nil, BAD_REQUEST);
    } else {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
        [parameters setObject:searchString forKey:@"searchTerm"];
        [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
        [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
        
        [httpClient POST:@"findUsers" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *rawUsers = [responseObject objectForKey:@"items"];
            
            NSMutableArray *users = [NSMutableArray arrayWithCapacity:rawUsers.count];
            for (NSDictionary *rawUser in rawUsers) {
                WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser];
                [users addObject:user];
            }
            
            [self debugger:parameters.description methodLog:@"api/findUsers" dataLogFormatted:responseObject];
            completion(users, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/findUsers" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
    }
}

- (void)timelineForUserID:(int)userID page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *posts, ServerResponse serverResponseCode))completion {
    
    if (userID < 1) {
        completion(nil, BAD_REQUEST);
    } else {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
        [parameters setObject:[NSString stringWithFormat:@"%d", userID] forKey:@"forUserID"];
        [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
        [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
        
        [httpClient POST:@"getTimeline" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *rawPosts = [responseObject objectForKey:@"items"];
            
            NSMutableArray *posts = [NSMutableArray arrayWithCapacity:rawPosts.count];
            for (NSDictionary *rawPost in rawPosts) {
                WLIPost *post = [[WLIPost alloc] initWithDictionary:rawPost];
                [posts addObject:post];
            }
            
            [self debugger:parameters.description methodLog:@"api/getTimeline" dataLogFormatted:responseObject];
            completion(posts, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/getTimeline" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
    }
}

- (void)usersAroundLatitude:(float)latitude longitude:(float)longitude distance:(float)distance page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *users, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"latitude"];
    [parameters setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"longitude"];
    [parameters setObject:[NSString stringWithFormat:@"%f", distance] forKey:@"distance"];
    [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
    
    [httpClient POST:@"getLocationsForLatLong" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawUsers = [responseObject objectForKey:@"items"];
        
        NSMutableArray *users = [NSMutableArray arrayWithCapacity:rawUsers.count];
        for (NSDictionary *rawUser in rawUsers) {
            WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser];
            [users addObject:user];
        }
        
        [self debugger:parameters.description methodLog:@"api/getLocationsForLatLong" dataLogFormatted:responseObject];
        completion(users, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/getLocationsForLatLong" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}


#pragma mark - posts

- (void)sendPostWithTitle:(NSString*)postTitle postKeywords:(NSArray*)postKeywords postImage:(UIImage*)postImage onCompletion:(void (^)(WLIPost *post, ServerResponse serverResponseCode))completion {
    
    if (!postTitle.length && !postImage) {
        completion(nil, BAD_REQUEST);
    } else {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
        [parameters setObject:postTitle forKey:@"postTitle"];
        
        [httpClient POST:@"sendPost" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (postImage) {
                NSData *imageData = UIImageJPEGRepresentation(postImage, kCompressionQuality);
                if (imageData) {
                    [formData appendPartWithFileData:imageData name:@"postImage" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rawPost = [responseObject objectForKey:@"item"];
            WLIPost *post = [[WLIPost alloc] initWithDictionary:rawPost];
            
            [self debugger:parameters.description methodLog:@"api/sendPost" dataLogFormatted:responseObject];
            completion(post, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/sendPost" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
        
        /*
        [httpClient POST:@"api/sendPost" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rawPost = [responseObject objectForKey:@"item"];
            WLIPost *post = [[WLIPost alloc] initWithDictionary:rawPost];
            
            [self debugger:parameters.description methodLog:@"api/sendPost" dataLogFormatted:responseObject];
            completion(post, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/sendPost" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
         */
    }
}

- (void)recentPostsWithPageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *posts, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
    
    [httpClient POST:@"getRecentPosts" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawPosts = [responseObject objectForKey:@"items"];
        
        NSMutableArray *posts = [NSMutableArray arrayWithCapacity:rawPosts.count];
        for (NSDictionary *rawPost in rawPosts) {
            WLIPost *post = [[WLIPost alloc] initWithDictionary:rawPost];
            [posts addObject:post];
        }
        
        [self debugger:parameters.description methodLog:@"api/getRecentPosts" dataLogFormatted:responseObject];
        completion(posts, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/getRecentPosts" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}

- (void)popularPostsOnPage:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *posts, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
    [httpClient POST:@"getPopularPosts" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawPosts = [responseObject objectForKey:@"items"];
        
        NSMutableArray *posts = [NSMutableArray arrayWithCapacity:rawPosts.count];
        for (NSDictionary *rawPost in rawPosts) {
            WLIPost *post = [[WLIPost alloc] initWithDictionary:rawPost];
            [posts addObject:post];
        }
        
        [self debugger:parameters.description methodLog:@"api/getPopularPosts" dataLogFormatted:responseObject];
        completion(posts, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/getPopularPosts" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}


#pragma mark - comments

- (void)sendCommentOnPostID:(int)postID withCommentText:(NSString*)commentText onCompletion:(void (^)(WLIComment *comment, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", postID] forKey:@"postID"];
    [parameters setObject:commentText forKey:@"commentText"];
    [httpClient POST:@"setComment" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *rawComment = [responseObject objectForKey:@"item"];
        WLIComment *comment = [[WLIComment alloc] initWithDictionary:rawComment];
        
        [self debugger:parameters.description methodLog:@"api/setComment" dataLogFormatted:responseObject];
        completion(comment, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/setComment" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}

- (void)removeCommentWithCommentID:(int)commentID onCompletion:(void (^)(ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", commentID] forKey:@"commentID"];
    [httpClient POST:@"removeComment" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary *rawComment = [responseObject objectForKey:@"item"];
        //WLIComment *comment = [[WLIComment alloc] initWithDictionary:rawComment];
        
        [self debugger:parameters.description methodLog:@"api/removeComment" dataLogFormatted:responseObject];
        completion(OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/removeComment" dataLog:error.description];
        completion(UNKNOWN_ERROR);
    }];
}

- (void)commentsForPostID:(int)postID page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *comments, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", postID] forKey:@"postID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
    [httpClient POST:@"getComments" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawComments = [responseObject objectForKey:@"items"];
        
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:rawComments.count];
        for (NSDictionary *rawComment in rawComments) {
            WLIComment *comment = [[WLIComment alloc] initWithDictionary:rawComment];
            [comments addObject:comment];
        }
        
        [self debugger:parameters.description methodLog:@"api/getComments" dataLogFormatted:responseObject];
        completion(comments, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/getComments" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}


#pragma mark - likes

- (void)setLikeOnPostID:(int)postID onCompletion:(void (^)(WLILike *like, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", postID] forKey:@"postID"];
    [httpClient POST:@"setLike" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *rawLike = [responseObject objectForKey:@"item"];
        WLILike *like = [[WLILike alloc] initWithDictionary:rawLike];
        
        [self debugger:parameters.description methodLog:@"api/setLike" dataLogFormatted:responseObject];
        completion(like, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/setLike" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}

- (void)removeLikeWithLikeID:(int)postID onCompletion:(void (^)(ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", postID] forKey:@"postID"];
    [httpClient POST:@"removeLike" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self debugger:parameters.description methodLog:@"api/removeLike" dataLogFormatted:responseObject];
        completion(OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/removeLike" dataLog:error.description];
        completion(UNKNOWN_ERROR);
    }];
}

- (void)likesForPostID:(int)postID page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *likes, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", postID] forKey:@"postID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
    [httpClient POST:@"getLikes" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rawLikes = [responseObject objectForKey:@"items"];
        
        NSMutableArray *likes = [NSMutableArray arrayWithCapacity:rawLikes.count];
        for (NSDictionary *rawLike in rawLikes) {
            WLILike *like = [[WLILike alloc] initWithDictionary:rawLike];
            [likes addObject:like];
        }
        
        [self debugger:parameters.description methodLog:@"api/getLikes" dataLogFormatted:responseObject];
        completion(likes, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/getLikes" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}


#pragma mark - follow

- (void)setFollowOnUserID:(int)userID onCompletion:(void (^)(WLIFollow *follow, ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", userID] forKey:@"followingID"];
    [httpClient POST:@"setFollow" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *rawFollow = [responseObject objectForKey:@"item"];
        WLIFollow *follow = [[WLIFollow alloc] initWithDictionary:rawFollow];
        self.currentUser.followingCount++;
        [self debugger:parameters.description methodLog:@"api/setFollow" dataLogFormatted:responseObject];
        completion(follow, OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/setFollow" dataLog:error.description];
        completion(nil, UNKNOWN_ERROR);
    }];
}

- (void)removeFollowWithFollowID:(int)followID onCompletion:(void (^)(ServerResponse serverResponseCode))completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
    [parameters setObject:[NSString stringWithFormat:@"%d", followID] forKey:@"followingID"];
    [httpClient POST:@"removeFollow" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary *rawFollow = [responseObject objectForKey:@"item"];
        //WLIFollow *follow = [[WLIFollow alloc] initWithDictionary:rawFollow];
        self.currentUser.followingCount--;
        [self debugger:parameters.description methodLog:@"api/removeFollow" dataLogFormatted:responseObject];
        completion(OK);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self debugger:parameters.description methodLog:@"api/removeFollow" dataLog:error.description];
        completion(UNKNOWN_ERROR);
    }];
}

- (void)followersForUserID:(int)userID page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *followers, ServerResponse serverResponseCode))completion {
    
    if (userID < 1) {
        completion(nil, BAD_REQUEST);
    } else {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
        [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
        [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
        [parameters setObject:[NSString stringWithFormat:@"%d", userID] forKey:@"forUserID"];
        [httpClient POST:@"getFollowers" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *rawUsers = responseObject[@"items"];
            
            NSMutableArray *users = [NSMutableArray arrayWithCapacity:rawUsers.count];
            for (NSDictionary *rawUser in rawUsers) {
                WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser[@"user"]];
                [users addObject:user];
            }
            
            [self debugger:parameters.description methodLog:@"api/getFollowers" dataLogFormatted:responseObject];
            completion(users, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/getFollowers" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
    }
}

- (void)followingForUserID:(int)userID page:(int)page pageSize:(int)pageSize onCompletion:(void (^)(NSMutableArray *following, ServerResponse serverResponseCode))completion {
    
    if (userID < 1) {
        completion(nil, BAD_REQUEST);
    } else {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:[NSString stringWithFormat:@"%d", self.currentUser.userID] forKey:@"userID"];
        [parameters setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
        [parameters setObject:[NSString stringWithFormat:@"%d", pageSize] forKey:@"take"];
        [parameters setObject:[NSString stringWithFormat:@"%d", userID] forKey:@"forUserID"];
        [httpClient POST:@"getFollowing" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *rawUsers = responseObject[@"items"];
            
            NSMutableArray *users = [NSMutableArray arrayWithCapacity:rawUsers.count];
            for (NSDictionary *rawUser in rawUsers) {
                WLIUser *user = [[WLIUser alloc] initWithDictionary:rawUser[@"user"]];
                [users addObject:user];
            }
            
            [self debugger:parameters.description methodLog:@"api/getFollowing" dataLogFormatted:responseObject];
            completion(users, OK);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self debugger:parameters.description methodLog:@"api/getFollowing" dataLog:error.description];
            completion(nil, UNKNOWN_ERROR);
        }];
    }
}

- (void)logout {
    
    _currentUser = nil;
    [self removeCurrentUser];
}

#pragma mark - debugger

- (void)debugger:(NSString *)post methodLog:(NSString *)method dataLog:(NSString *)data {
    
    #ifdef DEBUG
        NSLog(@"\n\nmethod: %@ \n\nparameters: %@ \n\nresponse: %@\n", method, post, (NSDictionary *) [json objectWithString:data]);
    #else
    #endif
}

- (void)debugger:(NSString *)post methodLog:(NSString *)method dataLogFormatted:(NSString *)data {
    
    #ifdef DEBUG
        NSLog(@"\n\nmethod: %@ \n\nparameters: %@ \n\nresponse: %@\n", method, post, data);
    #else
#endif
}

@end
