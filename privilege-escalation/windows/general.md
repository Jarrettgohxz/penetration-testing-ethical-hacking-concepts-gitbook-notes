# General

### Windows Users

|                |                                                                                                                                                                                                                     |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Administrators | <p>These users have the most privileges. They can access any files on the system, and are also able to make changes any system configuration parameter.<br></p>                                                     |
| Standard Users | <p>These users can only perform limited tasks on the computer. They are generally not allowed to make any permanent or essential changes to the system. They are also limited to the files they can access.<br></p> |

Any user with administrative privileges will be part of the **Administrators** group. While standard users are part of the **Users** group.

Additionally,  there are some special built-in accounts used by the operating system in the context of privilege escalation:

| <p>SYSTEM / LocalSystem<br></p> | <p>An account used by the operating system to perform internal tasks. It has full access to all files and resources available on the host with even higher privileges than administrators.<br></p> |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <p>Local Service<br></p>        | <p>Default account used to run Windows services with <em>minimum</em> privileges. It will use anonymous connections over the network.<br></p>                                                      |
| <p>Network Service<br></p>      | Default account used to run Windows services with _minimum_ privileges. It will use the computer credentials to authenticate through the network.                                                  |
