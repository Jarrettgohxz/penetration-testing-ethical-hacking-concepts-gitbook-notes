# WinRM (\*\*pending test)

* **Ports:** 5985/TCP (WinRM HTTP) or 5986/TCP (WinRM HTTPS)
* **Required Group Memberships:** Remote Management Users

### Basic command

```powershell
winrs.exe -u:Administrator -p:Mypass123 -r:target cmd
```
