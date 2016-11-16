//https://github.com/SZU-BDI/lib-ios-jso/blob/master/JSO.m
//Author: 双虎, Wanjo Chan

#import "JSO.h"

@implementation JSO

+ (id) s2id :(NSString *)s
{
    NSError *error = nil;
    
    id idid = [NSJSONSerialization
               JSONObjectWithData:[[[@"[" stringByAppendingString:s] stringByAppendingString:@"]"] dataUsingEncoding:NSUTF8StringEncoding]
               options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
               error:&error];
    
    if (error.description) {
        NSLog(@"s2id(%@) err => %@", s, error.description);
        idid=s;
    }else{
        return [idid objectAtIndex:0];
    }
    return idid;
}

+ (NSString *) id2s :(id)idid :(BOOL)flagThrowEx
{
    if(nil==idid) return @"null";
    NSString * s=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@[idid] options:0 error:nil] encoding:NSUTF8StringEncoding];
    s=[[s substringToIndex:([s length]-1)] substringFromIndex:1];
    return s;
}
+ (NSString *) id2s :(id)idid
{
    return [self id2s:idid :NO];
}

+ (JSO *) s2o :(NSString *)s
{
    id idid = [self s2id:s];
    
    JSO *o = [[JSO alloc] init];
    
    [o setValue:idid forKey:@"_jv"];
    
    return o;
}

+ (NSString *) o2s:(JSO *)o :(BOOL) quote
{
    if(o==nil) return nil;
    return [o toString :quote];
}
+ (NSString *) o2s:(JSO *)o
{
    if(o==nil) return nil;
    return [o toString :FALSE];
}

- (NSString *) toString :(BOOL)quote
{
    if(nil==_jv){
        if(!quote){
            return nil;
        }
    }
    if ([_jv isKindOfClass:[NSString class]]){
        if(quote){
            [JSO id2s:_jv];
        }else{
            return (NSString *)_jv;
        }
    }
    return [JSO id2s:_jv];
}

- (NSString *) toString
{
    return [self toString :FALSE];
}

- (void) fromString :(NSString *)s
{
    id idid = [JSO s2id:s];
    
    [self setValue:idid forKey:@"_jv"];
}

- (JSO *) getChild :(NSString *)key
{
    return [self getChildByPath:key];
}

- (void) setChild:(NSString *)k JSO:(JSO *)o{
    if(k==nil) return;
    
    if (_jv==nil) _jv=@{};//turn my _jv into {} if null
    
    id childid=[o valueForKey:@"_jv"];
    
    //if(nil==childid)return;
    
    @try{
        NSMutableDictionary *ddd=(NSMutableDictionary *)_jv;
        [ddd setObject:childid forKey:k];
    }
    @catch (NSException *theException)
    {
        NSLog(@"setChild() Exception: %@", theException);
        //NSLog(@"setChild() %@", childid);
    }
}

-(JSO *) getChildByPath :(NSString *)path{
    JSO *o=[[JSO alloc] init];
    
    if (_jv==nil) return o;
    id subid;
    @try{
        subid=[_jv valueForKeyPath:path];
    }
    @catch (NSException *theException)
    {
        NSLog(@"getChildByPath() Exception: %@", theException);
        NSLog(@"getChildByPath() %@", subid);
    }
    if(subid!=nil){
        [o setValue:subid forKey:@"_jv"];
    }
    return o;
}

- (void) removeChild :(NSString *)k{
    if (_jv==nil) return;
    @try{
        NSMutableDictionary *ddd=(NSMutableDictionary *)_jv;
        [ddd removeObjectForKey:k];
    }
    @catch (NSException *theException)
    {
        NSLog(@"setChild() Exception: %@", theException);
    }
}

- (NSArray *) getChildKeys
{
    if (_jv!=nil) {
        @try{
            return [_jv allKeys];
        }
        @catch (NSException *theException)
        {
            NSLog(@"setChild() Exception: %@", theException);
        }
    }
    return [[NSMutableArray arrayWithCapacity:0] copy];
}

//shallow merge
-(JSO *) basicMerge:(JSO *)jso
{
    if(nil==jso) return self;
    
    if (_jv==nil) {
        _jv=@{};
    }
    [_jv addEntriesFromDictionary:[jso valueForKey:@"_jv"]];
    return self;
}

- (JSO *) copy
{
    return [JSO s2o:[self toString]];
}

@end
