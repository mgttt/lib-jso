# lib-ios-jso

a tiny JSON Object-String bidirectional library for iOS (JSO.h/JSO.m)

Development should be done.  but github-pull-request is welcome!

# 【CHS】

一个迷你的 iOS-JSON 库，使用 id 类做为中转，本质上其实是 原生 json的一个小封装，让代码写得更轻松

基本已经完成，不过仍然欢迎 PULL REQUEST

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
