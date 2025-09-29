# Useful queries

### 1. Find instances where a computer has the "AdminTo" relationship over another computer

{% code overflow="wrap" %}
```cypher
MATCH p=(c1:Computer)-[r1:MemberOf*1..]->(g:Group)-[r2:AdminTo]->(n:Computer) RETURN p
```
{% endcode %}

### 2. ..



