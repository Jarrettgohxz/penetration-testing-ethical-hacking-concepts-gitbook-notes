# Prerequisite for IoT Hacking

This content provides an introduction to prerequisite knowledge required in the [IoT Hacking Roadmap](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/iot-hacking-roadmap) course.

## **1.** Linux Fundamentals

**Purpose**: To introduce the Linux operating system used widely in IoT/embedded systems

{% embed url="https://youtu.be/0-HXrwpJ3ks" %}

**Setup Linux virtual machine (VM) on VirtualBox**:

Refer to [guide ](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/virtual-machines/virtualbox/installing-ubuntu)for the steps to install Ubuntu 26.04 on VirtualBox



**Topic overview**:

You will be provided with a simulated Linux router environment. More information in the **Lab exercise setup** section below



1. Linux filesystem

* Common naming shortcuts: `~`, `/`
* Folders: `etc`, `tmp`, `bin`, `sbin`
* Files: `/etc/preInit` , `/etc/init`, `/etc/rc`
* File permissions



2. Getting comfortable with the command-line (terminal) + other concepts

* Basic commands: `ls`, `cat`, `netstat`, etc.
* Processes:  `ps`, `kill`, `killall`



3. Introducing **busybox**

* Called the "swiss army knife of embedded Linux"
* Commands that comes with it: `pgrep`, `nc`&#x20;



**Lab exercise setup**

Practice your skills on a simulated Linux router environment. Download this file and run it from the default downloads (`~/Downloads`) directory:

{% file src="../../.gitbook/assets/linux-router-lab (3).run" %}

{% code overflow="wrap" %}
```shellscript
# 1. Navigate to directory where the file is stored
$ cd ~/Downloads

# 2. Run the file
$ ./linux-router-lab.run
# or
$ sh linux-router-lab.run
```
{% endcode %}



**Lab exercise questions**

1. What is the utility that provides a range of Linux command-line tools that may be missing on a standard IoT device, all packaged into a single binary executable file. People also call it the "swiss army knife of embedded Linux"&#x20;

<details>

<summary>Try it out yourself first!</summary>

**busybox** -> [https://busybox.net/downloads/binaries/](https://busybox.net/downloads/binaries/). Common architecture types for IoT devices are **ARM** and **MIPS**.

</details>

2. What is the content of flag.txt in the home directory (`~`)?

<details>

<summary>Try it out yourself first!</summary>

**linux-FUNdamentals**

{% code title="Linux router shell" %}
```sh
/# cat ~/flag.txt
```
{% endcode %}

</details>

3. What is the process ID (PID) of the httpd process?

<details>

<summary>Try it out yourself first!</summary>

We can use the `ps` command (with optional "w" option), or the `pgrep` command that comes with `busybox`

> Note that the PID will change across each new lab instance

{% code title="Linux router shell" %}
```sh
/# ps w
/# ps w | grep httpd
/# busybox pgrep httpd
```
{% endcode %}

</details>

4. What is the value of the "flag" nvram field?

<details>

<summary>Try it out yourself first!</summary>

**subscribe**

We can use the `nvram` command for this. You will not find this command on other Linux systems aside from IoT/embedded ones.

{% code title="Linux router shell" %}
```shellscript
/# nvram show | grep flag
/# nvram get flag
```
{% endcode %}

</details>

## **2. Network Security Basics**

**Purpose**: To introduce essential computer networking concepts that will be encountered in both IoT hacking, and everyday cybersecurity research

{% embed url="https://www.youtube.com/@Jarrettgxz" %}

**Tools:**

* ..

**Topic overview:**

1. Common network services

* **HTTP**
* **SSH**
* **Telnet**
* **UPnP**
  * [https://jumpcloud.com/blog/what-is-upnp](https://jumpcloud.com/blog/what-is-upnp)
* **SNMP**
  * [https://www.huntress.com/cybersecurity-101/topic/snmp-networking](https://www.huntress.com/cybersecurity-101/topic/snmp-networking)



2. Nmap and Nmap Scripting Engine (NSE)

* How to use Nmap to discover exposed network services
* How to use the Nmap Scripting Engine (NSE) to perform reconnaissance or check for known vulnerabilities on IoT devices. Refer to the [full list](https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/nmap-scripting-engine-nse)

```sh
$ nmap -p [PORT] --script [SCRIPT-NAME] <target-IP>

# NSE example
$ nmap -p [PORT] --script broadcast-upnp-info <target-IP>
```

NSE scripts example:&#x20;

* `broadcast-upnp-info` (**UDP/1900**)
* `upnp-info` (**UDP/1900**)
* `snmp-interfaces` (**UDP/161**)

> Add the `-v` option to enable verbose mode (output more information)

**Enumerate the open ports/services**

```bash
# Discover open UDP ports (most common ones)
$ sudo nmap <target-IP> -sU -T4 --max-retries 1 #  "--max-retries 2" may be more reliable
$ sudo nmap <target-IP> -sU --top-ports 20

# Alternatively, scan specific UDP ports for known services
$ nmap <target-IP> -sU -p1900 # upnp
$ nmap <target-IP> -sU -p161 # snmp
```



**Perform NSE script scan on each service**

```
$ sudo nmap -v 172.28.0.2 --script snmp-interfaces -Pn -sU -p161
```

```shellscript
$ sudo nmap -v 172.28.0.2 --script upnp-info -Pn -sU -p1900
```

<figure><img src="../../.gitbook/assets/image (176).png" alt=""><figcaption></figcaption></figure>



3. HyperText Transfer Protocol (HTTP)

* Learn about the network protocol used by web servers
* How to use the `wget` tool to send HTTP requests



4. ...



**Lab exercise setup**

Practice your skills on a simulated Linux router environment. Download this file and run it from the default downloads (`~/Downloads`) directory:

{% file src="../../.gitbook/assets/linux-router-lab (3).run" %}

{% code overflow="wrap" %}
```shellscript
# 1. Navigate to directory where the file is stored
$ cd ~/Downloads

# 2. Run the file
$ ./networking-router-lab.run
# or
$ sh networking-router-lab.run
```
{% endcode %}

**Lab exercise questions**

<details>

<summary>Try it out yourself first!</summary>

```shellscript
network@labs> nmap

network@labs> dhclient ...
network@labs> ip addr

network@labs> wget ...

```

</details>

## **3. `iotsec.tools` framework (WORKING ON IT!)**

`iotsec.tools` is a security research framework to ease the workflow of IoT pentesting&#x20;

> Pending development ...

{% embed url="https://www.youtube.com/@Jarrettgxz" %}

It will include multiple wrapper around popular tools for IoT security research workflows:

* Firmware-related research (firmware reverse engineering, analysis, emulation)
* Binary-related research (binary reverse engineering, analysis, emulation/debugger and exploit development)
* OSINT research (Google dork, FCC - covered in the later chapters)
* Automated network services enumeration (nmap scripts)

**Other features:**

1. LLM chatbot that can help with explaining usage of the tool, summarizing outputs, or for general queries
2. Access to a repository of firmware files for IoT research
3. Integration with `learn.iotsec.tools` learning platform&#x20;

* Access to dashboard (skills, progress, report)
* Access to custom lab challenges files and flag submissions

