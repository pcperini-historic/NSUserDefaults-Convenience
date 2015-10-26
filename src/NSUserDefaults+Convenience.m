//
//  NSUserDefaults+Convenience.m
//  NSUserDefaults-ConvenienceTests
//
//  Created by Patrick Perini on 2/27/12.
//  Licensing information available in README.md
//

#import "NSUserDefaults+Convenience.h"
#import <objc/runtime.h>

// Exceptions
NSString *const NSUserDefaultsCannotSyncException = @"NSUserDefaulstCannotSyncException";

// Private Variables
static void *NSUserDefaultsiCloudHandlerKey;

@implementation NSUserDefaults (Convenience_Private)

#define randint(lo, hi) arc4random_uniform(hi-lo)+lo

+ (NSString *)randomKey
{
    int keyLength = randint(10, 32);
    char key[keyLength];
    for (int i = 0; i < keyLength; i++)
        key[i] = (char) randint(33, 126);
    return [NSString stringWithCString: key encoding: NSASCIIStringEncoding];
}

+ (BOOL)isiCloudEnabled
{   
    if (!NSClassFromString(@"NSUbiquitousKeyValueStore"))
    {
        @throw [NSException exceptionWithName: NSUserDefaultsCannotSyncException
                                       reason: @"Class NSUbiquitousKeyValueStore does not exist."
                                     userInfo: nil];
        return NO;
    }
    
    if (![NSUbiquitousKeyValueStore defaultStore])
    {
        @throw [NSException exceptionWithName: NSUserDefaultsCannotSyncException
                                       reason: @"NSUbiquitousKeyValueStore instance defaultStore does not exist."
                                     userInfo: nil];
        return NO;
    }
    
    return YES;
}

@end

@implementation NSUserDefaults (Convenience)

// Fast Enumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    return [[self dictionaryRepresentation] countByEnumeratingWithState: state
                                                                objects: buffer
                                                                  count: len];
}

// Fast Additions
- (void)setObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    for (int keyIndex = 0; keyIndex < [keys count]; keyIndex++)
    {
        [self setObject: [objects objectAtIndex: keyIndex] forKey: [keys objectAtIndex: keyIndex]];
    }
}

- (void)addObjectsAndKeysFromDictionary:(NSDictionary *)keyValuePairs
{
    [self setObjects: [keyValuePairs allValues] forKeys: [keyValuePairs allKeys]];
    [self synchronize];
}

- (void)addObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
{
    NSMutableArray *objects = [NSMutableArray array];
    NSMutableArray *keys = [NSMutableArray array];
    
    va_list args;
    va_start(args, firstObject);
    for (id element = firstObject; element != nil; element = va_arg(args, id))
    {
        if ([objects count] > [keys count]) // it's a key
        {
            [keys addObject: element];
        }
        else // it's an object
        {
            [objects addObject: element];
        }
    }
    
    va_end(args);
    
    [self setObjects: objects forKeys: keys];
    [self synchronize];
}

// Getting User Defaults with Fallback Value
- (id)objectForKey: (NSString *)key or: (id)fallback
{
    id value = [self objectForKey: key];
    return [self hasValueForKey: key]? value : fallback;
}

- (NSString *)stringForKey: (NSString *)key or: (NSString *)fallback
{
    return (NSString *)[self objectForKey: key or: fallback];
}

- (NSArray *)arrayForKey: (NSString *)key or: (NSArray *)fallback
{
    return (NSArray *)[self objectForKey: key or: fallback];
}

- (NSDictionary *)dictionaryForKey: (NSString *)key or: (NSDictionary *)fallback
{
    return (NSDictionary *)[self objectForKey: key or: fallback];
}

- (NSData *)dataForKey: (NSString *)key or: (NSData *)fallback
{
    return (NSData *)[self objectForKey: key or: fallback];
}

- (NSInteger)integerForKey: (NSString *)key or: (NSInteger)fallback
{
    NSInteger value = [self integerForKey: key];
    return [self hasValueForKey: key]? value : fallback;
}

- (CGFloat)floatForKey: (NSString *)key or: (CGFloat)fallback
{
    CGFloat value = [self floatForKey: key];
    return [self hasValueForKey: key]? value : fallback;
}

- (BOOL)boolForKey: (NSString *)key or: (BOOL)fallback
{
    BOOL value = [self boolForKey: key];
    return [self hasValueForKey: key]? value : fallback;
}

// Determining Existance of User Defaults
- (BOOL)hasValueForKey: (NSString *)key
{
    return [[[self dictionaryRepresentation] allKeys] indexOfObject: key] != NSNotFound;
}

// Quickly Setting User Default Values
- (void)saveObject:(id)value forKey:(NSString *)key
{
    [self setObject: value forKey: key];
    [self synchronize];
}

- (void)saveInteger:(NSInteger)value forKey:(NSString *)key
{
    [self setInteger: value forKey: key];
    [self synchronize];
}

- (void)saveFloat:(CGFloat)value forKey:(NSString *)key
{
    [self setFloat: value forKey: key];
    [self synchronize];
}

- (void)saveBool:(BOOL)value forKey:(NSString *)key
{
    [self setBool: value forKey: key];
    [self synchronize];
}

// Resetting User Defaults
- (void)removeAllValues
{
    for (NSString *key in self)
    {
        [self removeObjectForKey: key];
    }
}

- (void)removeValuesForKeys:(NSArray *)keys
{
    for (NSString *key in keys)
    {
        [self removeObjectForKey: key];
    }
}

- (void)resetAllValues
{
    [self removePersistentDomainForName: [[NSBundle mainBundle] bundleIdentifier]];
    [self synchronize];
}

- (void)resetValuesForKeys:(NSArray *)keys
{
    [self removeValuesForKeys: keys];
    [self synchronize];
}

// Store Values
- (NSString *)storeObject:(id)value
{
    NSString *key = [[self class] randomKey];
    [self saveObject: value forKey: key];
    return key;
}

- (NSString *)storeInteger:(NSInteger)value
{
    NSString *key = [[self class] randomKey];
    [self saveInteger: value forKey: key];
    return key;
}

- (NSString *)storeFloat:(CGFloat)value
{
    NSString *key = [[self class] randomKey];
    [self saveFloat: value forKey: key];
    return key;
}

- (NSString *)storeBool:(BOOL)value
{
    NSString *key = [[self class] randomKey];
    [self saveBool: value forKey: key];
    return key;
}

// Synchronization
- (void)startSyncingWithiCloud
{
    if (![[self class] isiCloudEnabled])
        return;
    
    void (^receiveUpdatesFromiCloud)(NSNotification *) = ^(NSNotification *notification)
    {        
        for (NSString *key in [[NSUbiquitousKeyValueStore defaultStore] dictionaryRepresentation])
        {
            [self setObject: [[NSUbiquitousKeyValueStore defaultStore] objectForKey: key]
                     forKey: key];
        }
        
        [self synchronize];
    };
    
    void (^pushUpdatesToiCloud)(NSNotification *) = ^(NSNotification *notification)
    {
        for (NSString *key in self)
        {
            [[NSUbiquitousKeyValueStore defaultStore] setObject: [self objectForKey: key]
                                                         forKey: key];
        }
        
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    };
    
    id currentiCloudHandler;
    currentiCloudHandler = [[NSNotificationCenter defaultCenter] addObserverForName: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                                             object: nil
                                                                              queue: nil
                                                                         usingBlock: receiveUpdatesFromiCloud];
    
    currentiCloudHandler = [[NSNotificationCenter defaultCenter] addObserverForName: NSUserDefaultsDidChangeNotification
                                                                             object: nil
                                                                              queue: nil
                                                                         usingBlock: pushUpdatesToiCloud];
    
    objc_setAssociatedObject(self,
                             NSUserDefaultsiCloudHandlerKey,
                             currentiCloudHandler,
                             OBJC_ASSOCIATION_RETAIN);
}

- (void)stopSyncingWithiCloud
{
    if (![[self class] isiCloudEnabled])
        return;
    
    id currentiCloudHandler = objc_getAssociatedObject(self, NSUserDefaultsiCloudHandlerKey);
    
    [[NSNotificationCenter defaultCenter] removeObserver: currentiCloudHandler
                                                    name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                  object: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: currentiCloudHandler
                                                    name: NSUserDefaultsDidChangeNotification
                                                  object: nil];
                                                  
    objc_setAssociatedObject(self,
                             NSUserDefaultsiCloudHandlerKey,
                             nil,
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
