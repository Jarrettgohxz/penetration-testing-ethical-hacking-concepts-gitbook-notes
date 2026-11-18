# Case study 1 (Linksys E1200 router)

Refer here for the full research on this router:

{% embed url="https://jarrettgxz-sec.gitbook.io/penetration-testing-ethical-hacking-concepts/iot-hardware-hacking/research-projects/linksys-e1200-v2" %}

### Basic Nmap scans

#### TCP scan

```shellscript
$ nmap -sS -p- <TARGET> # scan all TCP ports 
```

<figure><img src="../../.gitbook/assets/image (248).png" alt=""><figcaption></figcaption></figure>

* http (80/tcp)
* 1780/tcp, 1990/tcp - both found to be serving UPnP XML files (more on this later)

#### UDP scan

```shellscript
# scan UDP ports
$ nmap -sU -p- <TARGET> 
$ nmap -sU -T4 --max-retries 2 <TARGET>
```



#### OS detection, script, version scans (`-A`)

```shellscript
$ nmap -A <TARGET> # scan all TCP ports 

# equivalen to
$ nmap -O -sV -sC --traceroute <TARGET>
```



### Nmap script scans (NSE)

Due to certain issues with the existing scripts, I have modified a few of them to get better results. You may access ...

Place the updated scripts in:

* `~/.nmap/scripts/hnap-info.nse`
* `~/.nmap/nselib/upnp.lua`



#### Universal Plug-n-Play (UPnP)

```shellscript
$ nmap --script broadcast-upnp-info <TARGET>
$ nmap -sU -p1900 --script upnp-info <TARGET>
```



#### Home Network Administration Protocol (HNAP)

```shellscript
$ nmap --script hnap-info <TARGET>
$ curl http://<TARGET>/HNAP1
```



