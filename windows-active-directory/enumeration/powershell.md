# Powershell

Powershell is an extension to the command prompt, and provides more control over commands.&#x20;

{% embed url="https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.5" %}

{% embed url="https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_exe?view=powershell-5.1" %}

### Common options&#x20;

1. **Execution policies**

> PowerShell's execution policy is a safety feature that controls the conditions under which PowerShell loads configuration files and runs scripts. This feature helps prevent the execution of malicious scripts.

```powershell
C:\> powershell -ep Bypass
C:\> powershell -ex Bypass
C:\> powershell -ExecutionPolicy Bypass 
```

* `Bypass`&#x20;
  * Nothing is blocked and there are no warnings or prompts
  * This execution policy is designed for configurations in which a PowerShell script is built into a larger application or for configurations in which PowerShell is the foundation for a program that has its own security model

Depending on the current execution policy (eg. `AllSigned` or `Restricted`), we may not be able to load or run a module (eg. `PowerView.ps1`) to perform any relevant tasks. However with the `Bypass` option, we are able to bypass these restrictions to execute any script of our choice.

_**Example**_

We want to import the `PowerView.ps1` module:

```powershell
C:\> powershell -ep Bypass
PS> Import-Module PowerView.ps1
```

