# Powershell

Powershell is an extension to the command prompt, and provides more control over commands.&#x20;

{% embed url="https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.5" %}

{% embed url="https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_exe?view=powershell-5.1" %}

### Common options&#x20;

1. **Execution policies**

> PowerShell's execution policy is a safety feature that controls the conditions under which PowerShell loads configuration files and runs scripts. This feature helps prevent the execution of malicious scripts.

```powershell
C:\> powershell -eq Bypass
C:\> powershell -ex Bypass
```

* `Bypass`&#x20;
  * Nothing is blocked and there are no warnings or prompts
  * This execution policy is designed for configurations in which a PowerShell script is built into a larger application or for configurations in which PowerShell is the foundation for a program that has its own security model

Without the `Bypass` option, we will not be allowed to import a module (eg. `PowerView.ps1`) with the `Import-Module` command — to perform any relevant task.

