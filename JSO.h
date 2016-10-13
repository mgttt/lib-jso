//https://github.com/SZU-BDI/app-hybrid-demo/blob/master/proj-ios-jso-dev/proj-ios-jso-dev/JSO.h
//Author: 双虎, Wanjo Chan

#import <Foundation/Foundation.h>

@interface JSO : NSObject{
    id _innerid;
}

+ (id)s2id:(NSString *)s;
+ (NSString *)id2s:(id)idid,...;

+ (JSO *)s2o:(NSString *)s;
+ (NSString *)o2s:(JSO *)o;

- (NSString *)toString;
- (void)fromString:(NSString *)s;

- (JSO *)getChild:(NSString *)k;
- (void)setChild:(NSString *)k JSO:(JSO *)o;
- (JSO *)getChildByPath:(NSString *)path;
- (void)removeChild:(NSString *)k;

@end
