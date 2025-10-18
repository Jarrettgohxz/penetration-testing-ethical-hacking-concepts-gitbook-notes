# PHP magic methods

{% embed url="https://www.php.net/manual/en/language.oop5.magic.php" %}

> Magic methods are special methods which override PHP's default's action when certain actions are performed on an object.

A few important methods are:

1. `__sleep()`: This method is called on an object before _**serialization**_. It can be used to clean up resources, such as database connections.
2. `__wakeup()`: This method is invoked upon _**deserialization**_. It can re-establish any connections that object might need to operate properly.
3. `__serialize()` and `__unserialize()` : These methods enable customization of the data returned after the _**serialization**_ and _**deserialization**_ processes respectively.
