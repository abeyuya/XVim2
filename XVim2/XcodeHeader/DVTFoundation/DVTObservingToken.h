//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Mar 30 2018 09:30:25).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import <DVTFoundation/DVTCancellable-Protocol.h>

@class DVTStackBacktrace, NSString;

@interface DVTObservingToken : NSObject <DVTCancellable>
{
    BOOL _isCancelled;
    DVTStackBacktrace *_creationBacktrace;
}

+ (void)initialize;
@property(retain) DVTStackBacktrace *creationBacktrace; // @synthesize creationBacktrace=_creationBacktrace;
- (void).cxx_destruct;
- (void)dealloc;
@property(readonly, getter=isCancelled) BOOL cancelled;
- (void)cancel;
- (void)_primitiveCancelObservation;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

