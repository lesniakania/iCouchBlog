//
//  CBLJSON.h
//  CouchbaseLite
//
//  Created by Jens Alfke on 2/27/12.
//  Copyright (c) 2012 Couchbase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


// Conditional compilation for JSONKit and/or NSJSONSerialization.
// If the app supports OS versions prior to NSJSONSerialization, we'll use JSONKit.
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#define USE_NSJSON (__IPHONE_OS_VERSION_MIN_REQUIRED >= 50000)
#elif defined(TARGET_OS_MAC)
#define USE_NSJSON (MAC_OS_X_VERSION_MIN_REQUIRED >= 1070)
#elif defined(GNUSTEP)
#define USE_NSJSON 1
#else
#define USE_NSJSON 0
#endif


/** Identical to the corresponding NSJSON option flags. */
enum {
    CBLJSONReadingMutableContainers = (1UL << 0),
    CBLJSONReadingMutableLeaves = (1UL << 1),
    CBLJSONReadingAllowFragments = (1UL << 2)
};
typedef NSUInteger CBLJSONReadingOptions;

/** Identical to the corresponding NSJSON option flags, with one addition. */
enum {
    CBLJSONWritingPrettyPrinted = (1UL << 0),
    
    CBLJSONWritingAllowFragments = (1UL << 23)  /**< Allows input to be an NSString or NSValue. */
};
typedef NSUInteger CBLJSONWritingOptions;


#if USE_NSJSON

/** Useful extensions for JSON serialization/parsing. */
@interface CBLJSON : NSJSONSerialization
@end

#else

@interface CBLJSON : NSObject
+ (NSData *)dataWithJSONObject:(id)obj
                       options:(CBLJSONWritingOptions)opt
                         error:(NSError **)error;
+ (id)JSONObjectWithData:(NSData *)data
                 options:(CBLJSONReadingOptions)opt
                   error:(NSError **)error;
@end

#endif // USE_NSJSON


@interface CBLJSON (Extensions)
/** Same as -dataWithJSONObject... but returns an NSString. */
+ (NSString*) stringWithJSONObject:(id)obj
                           options:(CBLJSONWritingOptions)opt
                             error:(NSError **)error;

/** Given valid JSON data representing a dictionary, inserts the contents of the given NSDictionary into it and returns the resulting JSON data.
    This does not parse or regenerate the JSON, so it's quite fast.
    But it will generate invalid JSON if the input JSON begins or ends with whitespace, or if the dictionary contains any keys that are already in the original JSON. */
+ (NSData*) appendDictionary: (NSDictionary*)dict
        toJSONDictionaryData: (NSData*)json;

/** Encodes an NSDate as a string in ISO-8601 format. */
+ (NSString*) JSONObjectWithDate: (NSDate*)date;

/** Parses an ISO-8601 formatted date string.
    If the object is not a string, or not valid ISO-8601, it returns nil. */
+ (NSDate*) dateWithJSONObject: (id)jsonObject;

@end


/** Wrapper for an NSArray of JSON data, that avoids having to parse the data if it's not used.
    NSData objects in the array will be parsed into native objects before being returned to the caller from -objectAtIndex. */
@interface CBLLazyArrayOfJSON : NSArray
{
    NSMutableArray* _array;
}

/** Initialize a lazy array.
    @param array   An NSArray of NSData objects, each containing JSON. */
- (id) initWithArray: (NSMutableArray*)array;
@end
