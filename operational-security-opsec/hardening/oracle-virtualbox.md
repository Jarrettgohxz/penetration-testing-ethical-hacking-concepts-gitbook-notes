# Oracle VirtualBox

### Create an isolated Virtualbox host machine for pentesting, security research, etc.

1.  General -> Advanced

    * [ ] Shared clipboard: **Disabled**
    * [ ] Drag n Drop: **Disabled**


2.  Only a single adapter enabled:

    * [ ] NAT network
    * [ ] NO port forwarding rules


3. Disable Audio & USB
   * [ ] USB -> Uncheck "_Enable USB Controller_"
   * [ ] Audio -> Uncheck "_Enable Audio_"



4.  User management

    * [ ] **DO NOT** login as _root_ user
    * [ ] Remove all unnecessary users
    * [ ] Use strong password for users, especially those with superuser privileges (_sudo_ group, and _root_ itself)
    * [ ] Ensure that permissions for all users are kept to the minimum (check with `sudo -l`, `groups <user>`)


5.  <mark style="color:orange;">**\*\***</mark>VM snapshot

    * [ ] Save a fresh install to revert back to after each engagement (or when required)


6. Additional tools:
   1. firejail
   2. opensnitch
   3. apparmor
