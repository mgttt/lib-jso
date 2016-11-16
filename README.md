# lib-ios-jso

a tiny JSON Object-String bidirectional library for iOS (JSO.h/JSO.m)

Development should be done.  but github-pull-request is welcome!

for Android/Java Version, please click (https://github.com/SZU-BDI/app-hybrid-core/blob/master/lib-android/szu.bdi.hybrid.core/src/main/java/szu/bdi/hybrid/core/JSO.java)

# Trick

using "id" as a data holder and JSON converter

# Usage

https://github.com/SZU-BDI/lib-ios-jso/blob/master/JSO.h

https://github.com/SZU-BDI/lib-ios-jso/blob/master/JSO.m

## Pseudo Code:

```php
$o=JSO::s2o($s);
$s=JSO::o2s($o);

$o->fromString($s);
$s=$o->toString();

$o2=$o->getChild($k);
$o2=$o->getChildByPath($kp);
$o->setChild($k,$o3);
$o->removeChild($k);
```


# Real Code Examples

showValueForKey

```
NSString *k = _keyField.text;
NSString *s = _jsonLabel.text;

JSO *o = [JSO s2o:s];

JSO *o2 =[o getChild:k];

NSString *ss = [JSO o2s:o2];

_valueLabel.text=ss;

```

setJsoChildForKey

```objc

NSString *ttt =_field.text;

NSString *key = [NSString stringWithFormat:@"%@", _setKeyField.text];

NSString *value = [NSString stringWithFormat:@"%@", _setValueField.text];

JSO *o1 = [JSO s2o:ttt];

JSO *o2 = [JSO s2o:value];

[o1 setChild:key JSO:o2];

NSString *s1=[JSO o2s:o1];

_field.text=s1;


```
