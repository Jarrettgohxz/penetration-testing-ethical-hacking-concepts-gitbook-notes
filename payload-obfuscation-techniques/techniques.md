# Techniques

1. **Back ticks (`` ` ``)**

1.1 Empty back ticks

* essentially resolves to empty string, to bypass naive filters
* eg. direct string matching filter: `rm -rf /`&#x20;
  * &#x20;` rm -rf /`` `&#x20;
  * `r``m -rf /`&#x20;

1.2 Execute shell command&#x20;

*



2. **Backslash**
3. **Variable Expression**
4. **Encoding**
5. **Shell substitution**



6. **Brace expansion**
7. **Internal-File Separator (IFS)**
8. **Common shell bypass characters**

* semi-colon (`;`), ,pipe (`|`), double-ampersand (`&&`)
* possible bypasses
  * newline character (`\n`, `%0a`)



9. Globbing, wildcard expansion



