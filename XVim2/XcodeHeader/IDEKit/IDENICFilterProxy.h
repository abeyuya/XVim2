//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Mar 30 2018 09:30:25).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <IDEKit/IDENavigableItem.h>

@class NSHashTable;

@interface IDENICFilterProxy : IDENavigableItem
{
    NSHashTable *_rootItems;
}

@property(readonly) NSHashTable *rootItems; // @synthesize rootItems=_rootItems;
- (void).cxx_destruct;
- (BOOL)_alwaysBypassFilter;
- (id)_childItems;
- (id)childItems;
- (BOOL)isLeaf;
- (id)description;
- (void)_setItems:(id)arg1;
- (id)initWithRepresentedObject:(id)arg1;

@end

