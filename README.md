#NSUserDefaults+Convenience#



Category On:    NSUserDefaults

Declared In:    NSUserDefaults+Convenience.h


##Overview##

The `NSUserDefaults` class provides a programmatic interface for interacting with the defaults system.

This category adds a series of miscellaneous improvements for increase speed of implementation and bolster the overall capability of the `NSUserDefaults` class.

These improvements include convenient macros for accessing the standard user defaults database, methods for determining if a defaults database has a given key, and synchronizing defaults with iCloud.

The category is also designed to be extensible, where applicable. For example, more options for synchronization can be added without interfering with running synchronization options.

##Tasks##

###Getting the Standard User Defaults Instance###
    NSStandardUserDefaults

###Getting User Defaults with Fallback Value###
    - objectForKey:or:      
    - stringForKey:or:
    - arrayForKey:or:       
    - dictionaryForKey:or:     
    - dataForKey:or:        
    - integerForKey:or:     
    - floatForKey:or:       
    - boolForKey:or:        

###Determining Existance of User Defaults###
    - hasValueForKey:

###Quickly Setting User Defaults###
    - saveObject:forKey:
    - saveInteger:forKey:
    - saveFloat:forKey:
    - saveBool:forKey:

###Resetting and Removing User Defaults###
    - resetAllValues
    - resetValuesForKeys:
    - removeAllValues
    - removeValuesForKeys:  

###Storing Values###
    - storeObject:
    - storeInteger:
    - storeFloat:
    - storeBool:
    
###Synchronizing User Defaults###
    - startSyncingWithiCloud
    - stopSyncingWithiCloud
    
##Instance Methods##

**arrayForKey:or:**

> Returns the array associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (NSArray *)arrayForKey:(NSString *)key or:(NSArray *)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The array associated with the specified key, or the given fallback value if the key does not exist.
    
**boolForKey:or:**

> Returns the Boolean associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (BOOL)boolForKey:(NSString *)key or:(BOOL)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The Boolean associated with the specified key, or the given fallback value if the key does not exist.

**dataForKey:or:**

> Returns the data associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (NSData *)dataForKey:(NSString *)key or:(NSData *)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The data associated with the specified key, or the given fallback value if the key does not exist.

**dictionaryForKey:or:**

> Returns the dictionary associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (NSDictionary *)dictionaryForKey:(NSString *)key or:(NSDictionary *)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The dictionary associated with the specified key, or the given fallback value if the key does not exist.

**floatForKey:or:**

> Returns the float associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (CGFloat)floatForKey:(NSString *)key or:(CGFloat)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The float associated with the specified key, or the given fallback value if the key does not exist.

**hasValueForKey:**

> Returns a Boolean indicating whether or not the user's defaults database contains a key/value pair for the given key.

    - (BOOL)hasValueForKey:(NSString *)key
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

> *Return Value*

>> A Boolean indicating whether or not the user's defaults database contains a key/value pair for the given key.

**integerForKey:or:**

> Returns the integer associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (NSInteger)integerForKey:(NSString *)key or:(NSInteger)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The integer associated with the specified key, or the given fallback value if the key does not exist.

**objectForKey:or:**

> Returns the object associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (id)objectForKey:(NSString *)key or:(id)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The object associated with the specified key, or the given fallback value if the key does not exist.

**removeAllValues**

> Removes all values in the user's defaults database.

    - (void)removeAllValues
    
> *Discussion*

>> This method is equivalent to calling `removeObjectForKey:` for each key in the defaults database. In order to apply this change, call `synchronize` on the `NSUserDefaults` instance afterwards.

**removeValuesForKeys:**

> Removes the values in the user's defaults database that correspond to the given keys.

    - (void)removeValuesForKeys: (NSArray *)keys
    
> *Discussion*

>> This method is equivalent to calling `removeObjectForKey:` for each of the given keys. In order to apply this change, call `synchronize` on the `NSUserDefaults` instance afterwards.

**resetAllValues**

> Resets all values in the user's defaults database.

    - (void)resetAllValues
    
> *Discussion*

>> This method is equivalent to calling `removePersistentDomain:` for the current persistent domain.

**resetValuesForKeys:**

> Immediately removes the values in the user's defaults database that correspond to the given keys.

    - (void)resetValuesForKeys: (NSArray *)keys
    
**saveBool:forKey:**

> Immediately sets the value of the specified default key to the specified Boolean value.

    - (void)saveBool:(BOOL)value forKey:(NSString *)key
    
> *Parameters*

>> `value`
>> The Boolean value to store in the defaults database.

>> `key`
>> The key with which to associate with the value.

**saveFloat:forKey:**

> Immediately sets the value of the specified default key to the specified float value.

    - (void)saveFloat:(CGFloat)value forKey:(NSString *)key
    
> *Parameters*

>> `value`
>> The float value to store in the defaults database.

>> `key`
>> The key with which to associate with the value.

**saveInteger:forKey:**

> Immediately sets the value of the specified default key to the specified integer value.

    - (void)saveInteger:(NSInteger)value forKey:(NSString *)key
    
> *Parameters*

>> `value`
>> The integer value to store in the defaults database.

>> `key`
>> The key with which to associate with the value.

**saveObject:forKey:**

> Immediately sets the value of the specified default key to the specified object value.

    - (void)saveObject:(id)value forKey:(NSString *)key
    
> *Parameters*

>> `value`
>> The object value to store in the defaults database.

>> `key`
>> The key with which to associate with the value.

**startSyncingWithiCloud:**

> Begins observing for changes in both the user's defaults database and iCloud key/value storage database

    - (void)startSyncingWithiCloud
    
> *Discussion*

>> Whenever a change occurs in either the user's defaults database or iCloud key/value storage database, the change will be automatically reflected in both databases.

**stopSyncingWithiCloud:**

> Stops observing for changes in both the user's defaults database and iCloud key/value storage database

    - (void)stopSyncingWithiCloud
    
**storeBool:**

> Associates the given Boolean value with an arbitrary key, and returns that key.

    - (NSString *)storeBool:(BOOL)value
    
> *Parameters*

>> `value`
>> The Boolean value to store in the defaults database.

> *Return Value*

>> The arbitrary key associated with the given Boolean value in the defaults database.

**storeFloat:**

> Associates the given float value with an arbitrary key, and returns that key.

    - (NSString *)storeFloat:(CGFloat)value
    
> *Parameters*

>> `value`
>> The float value to store in the defaults database.

> *Return Value*

>> The arbitrary key associated with the given float value in the defaults database.

**storeInteger:**

> Associates the given integer value with an arbitrary key, and returns that key.

    - (NSString *)storeInteger:(NSInteger)value
    
> *Parameters*

>> `value`
>> The integer value to store in the defaults database.

> *Return Value*

>> The arbitrary key associated with the given integer value in the defaults database.
    
**storeObject:**

> Associates the given object value with an arbitrary key, and returns that key.

    - (NSString *)storeObject:(id)value
    
> *Parameters*

>> `value`
>> The object value to store in the defaults database.

> *Return Value*

>> The arbitrary key associated with the given object value in the defaults database.

**stringForKey:or:**

> Returns the string associated with the specified key, if the key/value pair exists. Otherwise returns the given fallback value.

    - (NSString *)stringForKey:(NSString *)key or:(NSString *)fallbackValue
    
> *Parameters*

>> `key`
>> A key in the current user's defaults database.

>> `fallbackValue`
>> The value to return if the requested key/value pair is not in the user's defaults database.

> *Return Value*

>> The string associated with the specified key, or the given fallback value if the key does not exist.

    
##Constants and Macros##

**NSStandardUserDefaults**

> Returns the shared object representing the standard user defaults database.

    #define NSStandardUserDefaults [NSUserDefaults standardUserDefaults]
    
##Other Functionality##

**Fast Enumeration**

> Allows the user's defaults database to be enumerated over like so:

    for (NSString *key in userDefaultsInstance)
    
> *Discussion*

>> This functionality is equivalent to fast-enumerating over the defaults database's `dictionaryRepresentation`.

#License#

License Agreement for Source Code provided by Patrick Perini

This software is supplied to you by Patrick Perini in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute this software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Patrick Perini grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms; provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the software, and that in all cases attribution of Patrick Perini as the original author of the source code shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Patrick Perini may be used to endorse or promote products derived from the software without specific prior written permission from Patrick Perini. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Patrick Perini herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.

The software is provided by Patrick Perini on an "AS IS" basis. Patrick Perini MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL Patrick Perini BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Patrick Perini HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.