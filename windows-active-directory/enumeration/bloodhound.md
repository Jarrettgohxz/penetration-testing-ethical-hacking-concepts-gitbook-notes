# Bloodhound

Bloodhound is a GUI tool that works together with the enumeration tool _Sharphound_. Generally, _Sharphound_ will be executed to enumerate through the AD environment to collect information, before being passed to _Bloodhound_ to be displayed visually. Essentially, _Sharphound_ can be viewed as the data collector for _Bloodhound_.

> Note: the Bloodhound and Sharphound versions should match for the best results.

There are different types of data collectors for _Bloodhound:_

1. SharpHound: as a Powershell script (`.ps1`) or a Windows executable version (`.exe` )

> The official data collector for BloodHound Community Edition (CE), written in C# and uses native Windows API and LDAP namespace functions to collect data from domain controllers and domain-joined Windows systems.



2. AzureHound: as a Powershell script (`.ps1` ) or pre-compiled binary

> AzureHound Community Edition collects data from Entra ID (formerly known as AzureAD) and AzureRM via the Microsoft Graph and Azure REST APIs. It does not use any external dependencies and will run on any operating system.



{% embed url="https://bloodhound.specterops.io/collect-data/ce-collection/sharphound" %}

{% embed url="https://bloodhound.specterops.io/collect-data/ce-collection/azurehound" %}
