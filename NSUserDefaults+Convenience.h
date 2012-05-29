//
//  NSUserDefaults+Convenience.h
//  NSUserDefaults-ConvenienceTests
//
//  Created by Patrick Perini on 2/27/12.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>

// Macros
#define NSStandardUserDefaults [NSUserDefaults standardUserDefaults]

@interface NSUserDefaults (Convenience) <NSFastEnumeration>

// Fast Additions
- (void)setObjects:                      (NSArray *)objects forKeys: (NSArray *)keys;
- (void)addObjectsAndKeysFromDictionary: (NSDictionary *)keyValuePairs;
- (void)addObjectsAndKeys:               (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

// Getting User Defaults with Fallback Value
- (id)objectForKey:                 (NSString *)key or: (id)fallback;
- (NSString *)stringForKey:         (NSString *)key or: (NSString *)fallback;
- (NSArray *)arrayForKey:           (NSString *)key or: (NSArray *)fallback;
- (NSDictionary *)dictionaryForKey: (NSString *)key or: (NSDictionary *)fallback;
- (NSData *)dataForKey:             (NSString *)key or: (NSData *)fallback;
- (NSInteger)integerForKey:         (NSString *)key or: (NSInteger)fallback;
- (CGFloat)floatForKey:             (NSString *)key or: (CGFloat)fallback;
- (BOOL)boolForKey:                 (NSString *)key or: (BOOL)fallback;

// Determining Existance of User Defaults
- (BOOL)hasValueForKey: (NSString *)key;

// Quickly Setting User Default Values
- (void)saveObject:  (id)value        forKey: (NSString *)key;
- (void)saveInteger: (NSInteger)value forKey: (NSString *)key;
- (void)saveFloat:   (CGFloat)value   forKey:(NSString *)key;
- (void)saveBool:    (BOOL)value      forKey:(NSString *)key;

// Resetting and Removing User Defaults
- (void)resetAllValues;
- (void)resetValuesForKeys: (NSArray *)keys;
- (void)removeAllValues;
- (void)removeValuesForKeys: (NSArray *)keys;

// Storing Values
- (NSString *)storeObject:  (id)value;
- (NSString *)storeInteger: (NSInteger)value;
- (NSString *)storeFloat:   (CGFloat)value;
- (NSString *)storeBool:    (BOOL)value;

// Synchronizing User Defaults
- (void)startSyncingWithiCloud;
- (void)stopSyncingWithiCloud;

@end
