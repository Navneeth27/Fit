//
// ooVooController.h
//
// Created by ooVoo on July 22, 2013
//
// © 2013 ooVoo, LLC.  Used under license.
//
// This product includes software from the following open source projects:
//
// Google WebM project:
// http://www.webmproject.org/license/bitstream/
// http://www.webmproject.org/license/software/
// http://www.webmproject.org/license/additional/
// Copyright (c) 2010, Google Inc. All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// •         Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// •         Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// •         Neither the name of Google nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// OpenSSL project:
// http://www.openssl.org/source/license.html
// Copyright (c) 1998-2011 The OpenSSL Project.  All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software must display the following acknowledgment: "This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
// 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used to endorse or promote products derived from this software without prior written permission. For written permission, please contact openssl-core@openssl.org.
// 5. Products derived from this software may not be called "OpenSSL" nor may "OpenSSL" appear in their names without prior written permission of the OpenSSL Project.
// 6. Redistributions of any form whatsoever must retain the following acknowledgment: "This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit (http://www.openssl.org/)"
// THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE OpenSSL PROJECT OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// This license also includes a requirement to comply with the “Original SSLeay License,” which includes the following terms:
// This library is free for commercial and non-commercial use as long as the following conditions are adhered to.  The following conditions apply to all code found in this distribution, be it the RC4, RSA, lhash, DES, etc., code; not just the SSL code.  The SSL documentation included with this distribution is covered by the same copyright terms except that the holder is Tim Hudson (tjh@cryptsoft.com).
// Copyright remains Eric Young's, and as such any Copyright notices in the code are not to be removed.  If this package is used in a product, Eric Young should be given attribution as the author of the parts of the library used.  This can be in the form of a textual message at program startup or in documentation (online or textual) provided with the package.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the copyright notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software must display the following acknowledgement:  "This product includes cryptographic software written by Eric Young (eay@cryptsoft.com)" The word 'cryptographic' can be left out if the routines from the library being used are not cryptographic related :-).
// 4. If you include any Windows specific code (or a derivative thereof) from the apps directory (application code) you must include an acknowledgement: "This product includes software written by Tim Hudson (tjh@cryptsoft.com)"
// THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// The license and distribution terms for any publically available version or derivative of this code cannot be changed.  i.e. this code cannot simply be copied and put under another distribution license [including the GNU Public License.]

// boost:
// http://www.boost.org/users/license.html
// Boost Software License – Version 1.0 – August 17th, 2003
// Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the ‘Software”) to use, reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject to the following:
// The copyright notices in the Software and this entire statement, including the above license grant, this restriction and the following disclaimer, must be included in all copies of the Software, in whole or in part, and all derivative works of the software, unless such copies or derivative works are solely in the form of machine-executable object code generated by a source language processor.
// The software is provided “as is”, without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, title and non-infringement. In no event shall the copyright holders or anyone distributing the software be liable for any damages or other liability, whether in contract, tort or otherwise arising from, out of or in connection with the software or the use or other dealings in the software.

// LibYuv project:
// https://github.com/lemenkov/libyuv/blob/master/LICENSE
// Copyright 2011 The LibYuv Project Authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// o   Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// o   Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// o   Neither the name of Google nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// UTF8 convert:
// Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the “Software”) to use, reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject to the following:
// The copyright notices in the Software and this entire statement, including the above license grant, this restriction and the following disclaimer, must be included in all copies of the Software, in whole or in part, and all derivative works of the Software, unless such copies or derivative works are solely in the form of machine-executable object code generated by a source language processor.
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.”
//
//

#import <Foundation/Foundation.h>
#import "ooVooVideoFilter.h"

@interface ooVooController : NSObject

typedef enum
{
	ooVooInitResultOk,
    ooVooInitResultError,
	ooVooInitResultNotAuthorized,
    ooVooInitResultInvalidToken,
    ooVooInitResultExpiredToken,
    ooVooInitResultInvalidParameter,
    ooVooInitResultServerAddressNotValid,
    ooVooInitResultAppIdNotValid,
    ooVooInitResultSSLCertificateVerificationFailed
} ooVooInitResult;

+ (ooVooController*)sharedController;
- (NSString*)sdkVersion;
- (NSString*)errorMessageForOoVooInitResult:(ooVooInitResult)error;

// Init ooVoo SDK - this is a synchronized method
// Must be called before every other call to SDK.
// Returns indication of success by ConferenceCoreError enum
- (ooVooInitResult)initSdk:(NSString*)applicationId // The application identifier provided by ooVoo.
    applicationToken:(NSString*)applicationToken        // The application token provided by ooVoo.
    baseUrl:(NSString*)baseUrl;                         // The web address for ooVoo backend provided by ooVoo.

// Deprecated. To be removed in SDK version 1.2
// Joins an ooVoo video conference.
// Posts OOVOOConferenceDidBeginNotification if successful, else OOVOOConferenceDidFailNotification.
- (void)joinConference:(NSString*)conferenceId
	applicationToken:(NSString*)applicationToken  // The application token provided by ooVoo.
	applicationId:(NSString*)applicationId     // The application identifier provided by ooVoo.
	participantInfo:(NSString*)participantInfo;  // An optional string to be associated with local conference participant (limited to 1KB). Semantics is up to each application.

// Joins an ooVoo video conference.
// Posts OOVOOConferenceDidBeginNotification if successful, else OOVOOConferenceDidFailNotification.
- (void)joinConference:(NSString*)conferenceId
        participantId:(NSString*)participantId    // Participant ID in user application domain
       participantInfo:(NSString*)participantInfo;   // An optional string to be associated with local conference participant (limited to 1KB). Semantics is up to each application.

// Leaves the current conference.
// Posts OOVOOConferenceDidEndNotification.
- (void)leaveConference;


// Toggles receiving a remote conference participant's video stream.
// YES means the local participant will start to receive a remote participant's video stream. NO means the local participant will stop receiving a remote participant's video stream.
// Posts OOVOOParticipantVideoStateDidChangeNotification when completed.
- (void)receiveParticipantVideo:(BOOL)enable forParticipantID:(NSString*)participantID;

// Returns YES if has permissions to in call messages, else NO
- (BOOL)inCallMessagesPermitted;

// Send a special message to participant. Use nil participantID to send the message to all the participants in the conference.
- (void)sendMessage:(NSData *)message toParticipantID:(NSString*)participantID;

// Gets array of available video filter (ooVooVideoFilter)
- (NSArray *)availableVideoFilters;

// Set active video filter, return indication to the success of the operation
- (BOOL)setActiveVideoFilter:(NSString *)filterKey;

// Get active video filter key
- (NSString*)activeVideoFilter;

typedef enum
{
	ooVooRearCamera,
	ooVooFrontCamera,

} ooVooCameraDevice;

// Selects the active camera device for use by the local participant in a conference. Posts OOVOOVideoDidStartNotification.
- (void)selectCamera:(ooVooCameraDevice)camera;
- (ooVooCameraDevice)currentCamera; // The camera device selected.
- (NSArray *)availableCameras;

typedef enum
{
	ooVooCameraResolutionLow = 1,    // QSIF/QCIF and similar
	ooVooCameraResolutionMedium = 2, // SIF/CIF/QVGA and similar
    ooVooCameraResolutionHigh = 3,   // VGA
	ooVooCameraResolutionHD = 4,     // 720p

} ooVooCameraResolutionLevel;

typedef enum
{
    ooVooNone    = 0,
    ooVooFatal   = 1,
	ooVooError   = 2,
	ooVooWarning = 3,
	ooVooInfo    = 4,
	ooVooDebug   = 5,
	ooVooTrace   = 6
} ooVooLoggerLevel;

+ (void)setLogLevel:(ooVooLoggerLevel) loglevel;
// Sets the selected camera device's  video capture resolution level.
- (NSArray *)availableCameraResolutionLevels;
- (NSArray *)availableCameraResolutionLevelNames;  // An array of localized names for the available cameras resolution.
- (void)setCameraResolutionLevel:(ooVooCameraResolutionLevel)resolutionLevel;
- (ooVooCameraResolutionLevel)cameraResolutionLevel;
+ (ooVooCameraResolutionLevel) FrameSizeToResolutionLevel:(int) width height:(int) height;

@property(nonatomic) BOOL previewEnabled;
@property(nonatomic) BOOL cameraEnabled;
@property(nonatomic) BOOL transmitEnabled;
@property(nonatomic) BOOL microphoneEnabled;
@property(nonatomic) BOOL speakerEnabled;

- (NSArray*)cameraNames;  // An array of localized names for the available device cameras.

@end

//////////////////////////////////////////////////////////////////////////
// Notifications
//////////////////////////////////////////////////////////////////////////

// Posted after joinConference has succeeded. The Participant ID assigned dynamically by ooVoo is stored as a string in userInfo as OOVOOParticipantIdKey.
extern NSString* const OOVOOConferenceDidBeginNotification;

// Posted after an error has occurred to a conference.
extern NSString* const OOVOOConferenceDidFailNotification;

// User info keys for OOVOOConferenceDidFailNotification
extern NSString* const OOVOOConferenceFailureReasonKey;
extern NSString* const OOVOOErrorKey;

// Posted after leaveConference is completed or failed with a status code.
extern NSString* const OOVOOConferenceDidEndNotification;


// Posted after a new participant has joined the conference.
// User info:
// - OOVOOParticipantIdKey: the new participant's Participant ID
// - OOVOOParticipantInfoKey: the new participant's participantInfo set by the application.
extern NSString* const OOVOOParticipantDidJoinNotification;

// Posted after a participant has left the conference.
// User info:
// - OOVOOParticipantIdKey: the participant ID of the participant who left the conference.
extern NSString* const OOVOOParticipantDidLeaveNotification;

// Posted after any remote video stream is turned off or resumed by either side, or paused due to network conditions.
// User info:
// - OOVOOParticipantIdKey: the Participant ID of the remote participant whose video the local user is enabling/disabling to receive
// - OOVOOParticipantStateKey: the state indicates whether receiving the corresponding participant's video is enabled or disabled.
extern NSString* const OOVOOParticipantVideoStateDidChangeNotification;

typedef enum
{
	ooVooVideoUninitialized,
	ooVooVideoOn,
	ooVooVideoOff,
	ooVooVideoPaused

} ooVooVideoState;

// User info keys for OOVOOVideoDidStartNotification and OOVOOParticipantVideoStateDidChangeNotification. Conveys the actual size of the video frame.
extern NSString* const OOVOOVideoWidth;
extern NSString* const OOVOOVideoHeight;


// User info keys for Participants
extern NSString* const OOVOOParticipantIdKey;
extern NSString* const OOVOOParticipantInfoKey;
extern NSString* const OOVOOParticipantStateKey;


// Posted after the local participant's camera has been turned off / turned back on.
extern NSString* const OOVOOVideoTransmitDidStopNotification;
extern NSString* const OOVOOVideoTransmitDidStartNotification;

extern NSString* const OOVOOPreviewDidStopNotification;
extern NSString* const OOVOOPreviewDidStartNotification;

extern NSString* const OOVOOCameraDidStopNotification;
extern NSString* const OOVOOCameraDidStartNotification;

// Posted after the local participant's microphone has been muted / unmuted.
extern NSString* const OOVOOUserDidMuteMicrophoneNotification;
extern NSString* const OOVOOUserDidUnmuteMicrophoneNotification;

// Posted after the local participant's speaker has been muted / unmuted.
extern NSString* const OOVOOUserDidMuteSpeakerNotification;
extern NSString* const OOVOOUserDidUnmuteSpeakerNotification;


// Posted when receiving new connection statistics from ooVoo conference server.
extern NSString* const OOVOOConnectionStatisticsNotification;

// User info keys for connection statistics notifications
extern NSString* const OOVOOStatisticsInboundBandwidthKey;  // uint32
extern NSString* const OOVOOStatisticsOutboundBandwidthKey;
extern NSString* const OOVOOStatisticsInboundPacketLossKey;  //double
extern NSString* const OOVOOStatisticsOutboundPacketLossKey;


// Posted on reception of an in-call message.
// User info:
// - OOVOOParticipantIdKey: the Participant ID of the remote participant who sent the message.
// - OOVOOParticipantInfoKey: the message, as NSData.

extern NSString* const OOVOOInCallMessageNotification;

extern NSString * const OOVOO_OnHoldReasonKey;
extern NSString * const OOVOO_OnHoldNotification;
extern NSString * const OOVOO_OnUnHoldNotification;

extern NSString * const OOVOOLogNotification;
extern NSString * const OOVOOLogKey;
extern NSString * const OOVOOLogLevelKey;

