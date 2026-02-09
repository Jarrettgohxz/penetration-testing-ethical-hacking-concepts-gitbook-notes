# Research ideas

1. **Replicate steps to identify a zero-day buffer overflow type exploit that leads to RCE on an IoT device (eg. router)**

* Research known CVEs (with RCE PoC) on current routers
* Perform actions to replicate the steps a "blind" attacker will take to discover the zero-day vulnerability
  * UART shell -> dump source code, communicate with memory for binary exploitation
  * Firmware extraction + reversing -> dump filesystem + source code, etc.
  * PoC payload to gain RCE

{% embed url="https://chatgpt.com/share/6922a172-1aac-8009-b543-10070e718d38" %}
