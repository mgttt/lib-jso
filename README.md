# lib-jso

small-and-practical JsonObject<=>String library for iOS/Android

## Spec:

```php
$o=JSO::s2o($s);
$s=JSO::o2s($o);

$s=$o->toString();//to a JSON-lized String
$s=$o->asString();//if predicted value is String

$child=$o->getChild($k);
$o->setChild($k,$child);
```
