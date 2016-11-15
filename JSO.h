//https://github.com/SZU-BDI/lib-ios-jso/blob/master/JSO.h
//Author: 双虎, Wanjo Chan

//TODO add (like copy ..) merge(to, from, [selected])
// copy(from, to, [selected])

#import <Foundation/Foundation.h>

#ifndef JSO_h
#define JSO_h

@interface JSO : NSObject{
    // _jv as "JSO-Value"
    id _jv;
}

+ (id)s2id:(NSString *)s;
+ (NSString *)id2s:(id)idid flagThrowEx:(BOOL)flagThrowEx;
+ (NSString *)id2s:(id)idid;

+ (JSO *)s2o:(NSString *)s;
+ (NSString *)o2s:(JSO *)o;

- (NSString *)toString;
- (NSString *)toString :(BOOL)quote;
- (void)fromString:(NSString *)s;

- (JSO *)getChild:(NSString *)k;
- (void)setChild:(NSString *)k JSO:(JSO *)o;
- (JSO *)getChildByPath:(NSString *)path;
- (void)removeChild:(NSString *)k;
- (NSArray *)getChildKeys;
-(JSO *) basicMerge:(JSO *)jso;

@end

#endif
