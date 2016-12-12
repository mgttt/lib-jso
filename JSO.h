//https://github.com/SZU-BDI/lib-ios-jso/blob/master/JSO.h
//Author: 双虎, Wanjo Chan

//TODO add (like copy ..) merge(to, from, [selected])
// copy(from, to, [selected])

#import <Foundation/Foundation.h>

#ifndef JSO_h
#define JSO_h

@interface JSO : NSObject{
    id _jv;// internal "JSO-Value"
}

+ (id)s2id:(NSString *)s;
+ (NSString *) id2s :(id)idid :(BOOL)flagThrowEx;
+ (NSString *) id2s :(id)idid;

+ (JSO *) id2o :(id) idid;

+ (JSO *) s2o:(NSString *)s;
+ (NSString *) o2s:(JSO *)o;

- (id) toId;
- (NSString *) toString :(BOOL)quote;
- (NSString *) toString;
- (void) fromString :(NSString *)s;

- (void) setChild :(NSString *)k JSO:(JSO *)o;
- (JSO *) getChild :(NSString *)k;
- (JSO *) getChildByPath :(NSString *)path;
- (void) removeChild :(NSString *)k;
- (NSArray *) getChildKeys;
- (JSO *) basicMerge :(JSO *)jso;

- (JSO *) copy;

//#warning TODO func from JsonValue
//- (BOOL) isNumber;
- (BOOL) isNull;
//- (BOOL) isString;
////- (BOOL) isUnknown;
//- (BOOL) isObject;
//- (BOOL) isArray;
//- (BOOL) isTure;
//- (BOOL) isFalse;
//- (NSDictionary *) asObject;//after isObject
//- (NSArray *) asArray;//after isArray

@end

#endif
