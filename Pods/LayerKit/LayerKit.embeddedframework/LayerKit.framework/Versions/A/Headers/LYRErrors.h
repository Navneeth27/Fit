//
//  LYRErrors.h
//  LayerKit
//
//  Created by Blake Watters on 4/29/14.
//  Copyright (c) 2014 Layer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const LYRErrorDomain;

typedef NS_ENUM(NSUInteger, LYRError) {
    LYRErrorUnknownError                            = 1000,
    
    /* Messaging Errors */
    LYRErrorUnauthenticated                         = 1001,
    LYRErrorInvalidMessage                          = 1002,
    LYRErrorTooManyParticipants                     = 1003,
    LYRErrorDataLengthExceedsMaximum                = 1004,
    LYRErrorMessageAlreadyMarkedAsRead              = 1005,
    LYRErrorObjectNotSent                           = 1006,
    
    /* Validation Errors */
    LYRErrorInvalidKey                              = 2000,
    LYRErrorInvalidValue                            = 2001
};

typedef NS_ENUM(NSUInteger, LYRClientError) {
    // Client Errors
    LYRClientErrorAlreadyConnected                  = 6000,
    LYRClientErrorInvalidAppID                      = 6001,
    LYRClientErrorNetworkRequestFailed              = 6002,
    LYRClientErrorConnectionTimeout                 = 6003,
    
    // Crypto Configuration Errors
    LYRClientErrorKeyPairNotFound                   = 7000,
    LYRClientErrorCertificateNotFound               = 7001,
    LYRClientErrorIdentityNotFound                  = 7002,
    
    // Authentication
    LYRClientErrorNotAuthenticated                  = 7004,
    LYRClientErrorAlreadyAuthenticated              = 7005,
    
    // Push Notification Errors
    LYRClientErrorDeviceTokenInvalid                = 8000,
    
    // Synchronization Errors
    LYRClientErrorUndefinedSyncFaliure              = 9000,
    LYRClientErrorDevicePersistenceFailure          = 9001,
    LYRClientErrorSynchronizationFailure            = 9002
};

extern NSString *const LYRErrorAuthenticatedUserIDUserInfoKey;
extern NSString *const LYRErrorUnderlyingErrorsKey;
