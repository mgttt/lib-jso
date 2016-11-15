//https://github.com/SZU-BDI/lib-ios-jso/blob/master/JSO.m
//Author: 双虎, Wanjo Chan

#import "JSO.h"

@implementation JSO

+ (id) s2id :(NSString *)s
{
    NSError *error = nil;
    
    id idid = [NSJSONSerialization
               JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding]
               options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
               error:&error];
    
    if (error.description) {
        NSLog(@"s2id(%@) maybe pure string => %@", s, error.description);
        idid=s;
    }
    return idid;
}

+ (NSString *) id2s :(id)idid :(BOOL)flagThrowEx
{
    if (idid==nil) return @"null";
    
    if ([idid isKindOfClass:[NSString class]]){
        return (NSString *)idid;
    }
    
    if([idid isKindOfClass:[NSNumber class]]){
        if (strcmp([idid objCType], [@(NO) objCType]) == 0){
            return [idid boolValue] ? @"true" : @"false";
        }
        return [idid stringValue];
    }
    
    NSError *error;
    NSData *result =nil;
    if (flagThrowEx) {
        result = [NSJSONSerialization dataWithJSONObject:idid options:0 error:&error];
    }else{
        @try
        {
            result = [NSJSONSerialization dataWithJSONObject:idid options:0 error:&error];
        }
        @catch (NSException *theException)
        {
            NSLog(@"id2s(%@) Exception: %@", idid, theException);
        }
    }
    if(error.description!=nil){
        NSLog(@"id2s() err=> %@", error.description);
    }
    
    NSString *rt = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    return rt;
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

////@ref http://www.codza.com/converting-nsstring-to-json-string
//-(NSString *) JSONString :(NSString *)aString {
//    NSMutableString *s = [NSMutableString stringWithString:aString];
//    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
//    return [NSString stringWithString:s];
//}
- (NSString *) toString :(BOOL)quote
{
    if(quote){
        //only string type needs quote...
        if ([_jv isKindOfClass:[NSString class]]){
            //NSString *s=[self JSONString:(NSString *)_jv];
            //            NSString *s= [JSO id2s:@[(NSString *)_jv]];
            
            //NSString *s = [[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@[(NSString *)_jv] encoding:NSUTF8StringEncoding]] ];
            //NSString *s=[JSO id2s:@[(NSString *)_jv]];
            
            NSString *s=(NSString *)_jv;
            s=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@[s] options:0 error:nil] encoding:NSUTF8StringEncoding];
            s=[[s substringToIndex:([s length]-2)] substringFromIndex:1];
            return s;
        }
    }
    return [JSO id2s:_jv];
}

- (NSString *) toString
{
    return [self toString :FALSE];
    //    //[PHP] return JSO::o2s($this);
    //    return [JSO o2s :self :FALSE];
}

- (void) fromString :(NSString *)s
{
    //[PHP] $idid=JSO::s2id($s);
    id idid = [JSO s2id:s];
    
    //[PHP] $this->setValue("_jv", $idid);
    [self setValue:idid forKey:@"_jv"];
}

- (JSO *) getChild :(NSString *)key
{
    if(true)
        return [self getChildByPath:key];
    
    if (key == nil) return nil;
    
    if (_jv==nil) return nil;
    
    id subid = [_jv valueForKey:key];
    
    if(subid != nil){
        //$o=new JSO;
        JSO *o =[[JSO alloc] init];
        
        //$o->setValue("_jv",$idid);
        [o setValue:subid forKey:@"_jv"];
        
        return o;
    }
    return nil;
}

- (void) setChild:(NSString *)k JSO:(JSO *)o{
    
    if (_jv==nil) return;
    id childid=[o valueForKey:@"_jv"];
    if(nil==childid)return;//TODO make self as object?
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
    if (_jv==nil) return nil;
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
        //$o=new JSO;
        JSO *o=[[JSO alloc] init];
        
        //$o->setValue("_jv",$idid);
        [o setValue:subid forKey:@"_jv"];
        return o;
    }else{
        return nil;
    }
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
    if (_jv==nil) {
        _jv=@{};
    }
    [_jv addEntriesFromDictionary:[jso valueForKey:@"_jv"]];
    return self;
}


@end
