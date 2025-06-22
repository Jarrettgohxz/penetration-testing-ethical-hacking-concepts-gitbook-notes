# Table of contents

* [Introduction](README.md)

## 💿 Virtualbox network setup

* [What is VirtualBox?](virtualbox-network-setup/what-is-virtualbox.md)
* [NAT](virtualbox-network-setup/nat.md)
* [NAT network](virtualbox-network-setup/nat-network.md)
* [Bridged adapter](virtualbox-network-setup/bridged-adapter.md)
* [Internal network](virtualbox-network-setup/internal-network.md)
* [pfSense](virtualbox-network-setup/pfsense.md)
* [vboxmanage](virtualbox-network-setup/vboxmanage.md)
* [Overview](virtualbox-network-setup/overview.md)

## 🕵️ OSINT

* [What is OSINT?](osint/what-is-osint.md)
* [Google dorks](osint/google-dorks.md)
* [Metadata](osint/metadata.md)
* [Social media](osint/social-media/README.md)
  * [osintagram](osint/social-media/osintagram.md)

***

* [Tools](tools/README.md)
  * [waybackurls](tools/waybackurls.md)
  * [recon-ng](tools/recon-ng.md)
  * [sherlock](tools/sherlock.md)
  * [maltego](tools/maltego.md)
  * [theHarvester](tools/theharvester.md)
  * [photon](tools/photon.md)

## 😨 Social Engineering

* [What is social engineering?](social-engineering/what-is-social-engineering.md)
* [7 tricks of social engineering](social-engineering/7-tricks-of-social-engineering.md)
* [Email phishing](social-engineering/email-phishing.md)
* [Typosquatting](social-engineering/typosquatting.md)
* [Compiled resources](social-engineering/compiled-resources.md)

## 😈 MitM attack

* [What is MitM attack?](mitm-attack/what-is-mitm-attack.md)
* [ARP spoof/poison](mitm-attack/arp-spoof-poison.md)
* [DNS spoof/poison](mitm-attack/dns-spoof-poison.md)
* [HTTP MitM attack](mitm-attack/http-mitm-attack.md)
* [ICMP redirect attack](mitm-attack/icmp-redirect-attack.md)
* [DHCP spoofing](mitm-attack/dhcp-spoofing.md)
* [Evil twin attack](mitm-attack/evil-twin-attack.md)
* [Experiment (guest network)](mitm-attack/experiment-guest-network.md)
* [Compiled resources](mitm-attack/compiled-resources.md)

## 🔌 UPnP exploitation

* [What is UPnP?](upnp-exploitation/what-is-upnp.md)
* [What is SSDP?](upnp-exploitation/what-is-ssdp.md)
* [IGD functions](upnp-exploitation/igd-functions.md)
* [LAN devices](upnp-exploitation/lan-devices.md)
* [Compiled resources](upnp-exploitation/compiled-resources.md)

## Network Reconnaissance & Attacks

* [What is network recon & attacks?](network-reconnaissance-and-attacks/what-is-network-recon-and-attacks.md)

## 1️⃣ Network live host discovery

* [What is network live host discovery?](network-live-host-discovery/what-is-network-live-host-discovery.md)
* [nmap](network-live-host-discovery/nmap.md)
* [arp-scan](network-live-host-discovery/arp-scan.md)
* [masscan](network-live-host-discovery/masscan.md)

## 2️⃣ Network port scan/services enumeration

* [What is network port scan/services enumeration?](network-port-scan-services-enumeration/what-is-network-port-scan-services-enumeration.md)
* [nmap](network-port-scan-services-enumeration/nmap.md)
* [netcat](network-port-scan-services-enumeration/netcat.md)

## 3️⃣ Network services vulnerability scanning & exploitation

* [What is network vulnerability scanning/exploitation?](network-services-vulnerability-scanning-and-exploitation/what-is-network-vulnerability-scanning-exploitation.md)
* [20/21 \~ FTP](network-services-vulnerability-scanning-and-exploitation/20-21-ftp.md)
* [22 \~ SSH](network-services-vulnerability-scanning-and-exploitation/22-ssh.md)
* [25 \~ SMTP](network-services-vulnerability-scanning-and-exploitation/25-smtp.md)
* [53 \~ DNS](network-services-vulnerability-scanning-and-exploitation/53-dns.md)
* [80/443 \~ HTTP/HTTPS](network-services-vulnerability-scanning-and-exploitation/80-443-http-https.md)
* [110 \~ POP3](network-services-vulnerability-scanning-and-exploitation/110-pop3.md)
* [111/2049 \~ RPC/NFS](network-services-vulnerability-scanning-and-exploitation/111-2049-rpc-nfs.md)
* [139/445 \~ SMB](network-services-vulnerability-scanning-and-exploitation/139-445-smb.md)
* [143 \~ IMAP](network-services-vulnerability-scanning-and-exploitation/143-imap.md)
* [3389 \~ RDP](network-services-vulnerability-scanning-and-exploitation/3389-rdp.md)

## Vulnerability & exploitation

* [Database](vulnerability-and-exploitation/database.md)
* [Metasploit](vulnerability-and-exploitation/metasploit.md)
* [Msfvenom](vulnerability-and-exploitation/msfvenom.md)

***

* [Misconfigurations](misconfigurations/README.md)
  * [.DS\_Store](misconfigurations/.ds_store.md)

## Web Application Penetration Testing

* [Introduction](web-application-penetration-testing/introduction.md)
* [Web Content Discovery](web-application-penetration-testing/web-content-discovery/README.md)
  * [Directories/URLs gathering](web-application-penetration-testing/web-content-discovery/directories-urls-gathering.md)
  * [Subdomain enumeration](web-application-penetration-testing/web-content-discovery/subdomain-enumeration.md)
* [File inclusion & Path traversal](web-application-penetration-testing/file-inclusion-and-path-traversal.md)
* [Insecure Direct Object Reference (IDOR)](web-application-penetration-testing/insecure-direct-object-reference-idor.md)
* [Upload vulnerabilities](web-application-penetration-testing/upload-vulnerabilities/README.md)
  * [File extension cheat-sheet](web-application-penetration-testing/upload-vulnerabilities/file-extension-cheat-sheet.md)
* [SSRF](web-application-penetration-testing/ssrf.md)
* [CSRF](web-application-penetration-testing/csrf.md)
* [XSS](web-application-penetration-testing/xss.md)
* [SSTI](web-application-penetration-testing/ssti.md)
* [SQL injection](web-application-penetration-testing/sql-injection/README.md)
  * [Filter evasion techniques](web-application-penetration-testing/sql-injection/filter-evasion-techniques.md)
  * [Practical challenge examples](web-application-penetration-testing/sql-injection/practical-challenge-examples/README.md)
    * [TryHackMe](web-application-penetration-testing/sql-injection/practical-challenge-examples/tryhackme/README.md)
      * [TryHackMe Burp suite: Repeater room](web-application-penetration-testing/sql-injection/practical-challenge-examples/tryhackme/tryhackme-burp-suite-repeater-room.md)
      * [TryHackMe Advanced SQL Injection](web-application-penetration-testing/sql-injection/practical-challenge-examples/tryhackme/tryhackme-advanced-sql-injection.md)

***

* [Authentication/session management](authentication-session-management/README.md)
  * [OWASP WSTG-SESS-10 \~ JSON Web Token (JWT) ](authentication-session-management/json-web-token-jwt.md)
  * [OWASP WSTG-ATHZ-05 \~ OAuth weaknesses](authentication-session-management/oauth-weaknesses.md)
* [Webshell](webshell.md)
* [Web API pentesting](web-api-pentesting/README.md)
  * [Resources](web-api-pentesting/resources.md)
  * [Methodology](web-api-pentesting/methodology.md)
  * [jq](web-api-pentesting/jq.md)
  * [httpx](web-api-pentesting/httpx.md)
  * [ParamSpider](web-api-pentesting/paramspider.md)
* [Web app pentesting methodology](web-app-pentesting-methodology.md)
* [OWASP](owasp/README.md)
  * [OWASP top 10](owasp/owasp-top-10.md)
  * [OWASP API top 10](owasp/owasp-api-top-10.md)
  * [Web Security Testing Guide (WSTG)](owasp/web-security-testing-guide-wstg.md)
    * [WSTG-ATHZ](owasp/web-security-testing-guide-wstg/wstg-athz/README.md)
      * [WSTG-ATHZ-05 \~ OAuth weaknesses](owasp/web-security-testing-guide-wstg/wstg-athz/wstg-athz-05-oauth-weaknesses.md)
    * [WSTG-SESS](owasp/web-security-testing-guide-wstg/wstg-sess/README.md)
      * [WSTG-SESS-10 \~ JWT](owasp/web-security-testing-guide-wstg/wstg-sess/wstg-sess-10-jwt.md)
* [General web knowledge](general-web-knowledge/README.md)
  * [URI standard (RFC 3986)](general-web-knowledge/uri-standard-rfc-3986.md)
  * [HTTP headers](general-web-knowledge/http-headers.md)

## 🛣️ Attacks on routing protocols

* [What are attacks on routing protocols?](attacks-on-routing-protocols/what-are-attacks-on-routing-protocols.md)
* [BGP hijacking](attacks-on-routing-protocols/bgp-hijacking.md)

## 🏕️ To explore

* [MQTT](to-explore/mqtt.md)
* [Routersploit](to-explore/routersploit.md)
* [DNS rebinding attack](to-explore/dns-rebinding-attack.md)
* [LLMNR/mDNS poisoning](to-explore/llmnr-mdns-poisoning.md)

## 👤 Anonymity

* [VPN](anonymity/vpn.md)
* [Proxychains](anonymity/proxychains.md)
* [TOR](anonymity/tor.md)
* [Obfuscation](anonymity/obfuscation.md)

## Credentials brute-force/cracking

* [Introduction](credentials-brute-force-cracking/introduction.md)
* [Windows SAM database](credentials-brute-force-cracking/windows-sam-database.md)
* [Dictionary attack](credentials-brute-force-cracking/dictionary-attack.md)
* [Rainbow attack](credentials-brute-force-cracking/rainbow-attack/README.md)
  * [Hash database](credentials-brute-force-cracking/rainbow-attack/hash-database.md)
* [Tools](credentials-brute-force-cracking/tools/README.md)
  * [Hydra](credentials-brute-force-cracking/tools/hydra.md)
  * [John the ripper](credentials-brute-force-cracking/tools/john-the-ripper.md)
  * [Hashcat](credentials-brute-force-cracking/tools/hashcat.md)
  * [hash-identifier](credentials-brute-force-cracking/tools/hash-identifier.md)

## Post-exploitation

* [Gaining shell](post-exploitation/gaining-shell/README.md)
  * [netcat](post-exploitation/gaining-shell/netcat.md)
  * [socat](post-exploitation/gaining-shell/socat.md)
  * [powershell](post-exploitation/gaining-shell/powershell.md)
  * [bash](post-exploitation/gaining-shell/bash.md)
  * [PHP](post-exploitation/gaining-shell/php.md)
* [Repository](post-exploitation/repository.md)

## Privilege escalation

* [Linux](privilege-escalation/linux/README.md)
  * [Repositories](privilege-escalation/linux/repositories.md)
  * [Enumeration](privilege-escalation/linux/enumeration.md)
  * [Vulnerabilities exploit](privilege-escalation/linux/vulnerabilities-exploit/README.md)
    * [General](privilege-escalation/linux/vulnerabilities-exploit/general.md)
    * [Kernel exploit](privilege-escalation/linux/vulnerabilities-exploit/kernel-exploit.md)
    * [Sudo](privilege-escalation/linux/vulnerabilities-exploit/sudo.md)
    * [SUID](privilege-escalation/linux/vulnerabilities-exploit/suid.md)
    * [Capabilities](privilege-escalation/linux/vulnerabilities-exploit/capabilities.md)
    * [Cronjobs](privilege-escalation/linux/vulnerabilities-exploit/cronjobs.md)
    * [$PATH](privilege-escalation/linux/vulnerabilities-exploit/usdpath.md)
    * [NFS (target-machine)](privilege-escalation/linux/vulnerabilities-exploit/nfs-target-machine.md)
    * [Filesystem sharing](privilege-escalation/linux/vulnerabilities-exploit/filesystem-sharing/README.md)
      * [NFS (attacker-machine)](privilege-escalation/linux/vulnerabilities-exploit/filesystem-sharing/nfs-attacker-machine.md)
* [Windows](privilege-escalation/windows/README.md)
  * [Password harvesting](privilege-escalation/windows/password-harvesting.md)
  * [Vulnerabilities exploit](privilege-escalation/windows/vulnerabilities-exploit/README.md)
    * [Scheduled tasks](privilege-escalation/windows/vulnerabilities-exploit/scheduled-tasks.md)
    * [AlwaysInstallElevated](privilege-escalation/windows/vulnerabilities-exploit/alwaysinstallelevated.md)
    * [Service misconfigurations](privilege-escalation/windows/vulnerabilities-exploit/service-misconfigurations/README.md)
      * [Insecure permissions on service executable](privilege-escalation/windows/vulnerabilities-exploit/service-misconfigurations/insecure-permissions-on-service-executable.md)
      * [Unquoted service path](privilege-escalation/windows/vulnerabilities-exploit/service-misconfigurations/unquoted-service-path.md)
      * [Insecure service permission](privilege-escalation/windows/vulnerabilities-exploit/service-misconfigurations/insecure-service-permission.md)
    * [Abusing privileges](privilege-escalation/windows/vulnerabilities-exploit/abusing-privileges.md)

## Ⓜ️ MITRE ATT\&CK&#x20;

* [Introduction](mitre-att-and-ck/introduction.md)

## 🧰 Tools/services

* [Introduction](tools-services/introduction.md)
* [Web application pentesting](tools-services/web-application-pentesting/README.md)
  * [Web discovery/fuzzing](tools-services/web-application-pentesting/web-discovery-fuzzing/README.md)
    * [paramspider](tools-services/web-application-pentesting/web-discovery-fuzzing/paramspider.md)
    * [arjun](tools-services/web-application-pentesting/web-discovery-fuzzing/arjun.md)
    * [katana](tools-services/web-application-pentesting/web-discovery-fuzzing/katana.md)
  * [uro](tools-services/web-application-pentesting/uro.md)
  * [Password brute-forcing](tools-services/web-application-pentesting/password-brute-forcing.md)
  * [Burp Suite (Community)](tools-services/web-application-pentesting/burp-suite-community.md)
  * [scanners](tools-services/web-application-pentesting/scanners/README.md)
    * [ZAP (Zed Attack Proxy)](tools-services/web-application-pentesting/scanners/zap-zed-attack-proxy.md)
    * [nikto](tools-services/web-application-pentesting/scanners/nikto.md)
    * [nuclei](tools-services/web-application-pentesting/scanners/nuclei.md)
* [Information gathering/reconnaissance](tools-services/information-gathering-reconnaissance.md)
* [Network recon & attacks](tools-services/network-recon-and-attacks/README.md)
  * [nmap (general overview)](tools-services/network-recon-and-attacks/nmap-general-overview.md)
  * [scapy](tools-services/network-recon-and-attacks/scapy.md)
  * [bettercap](tools-services/network-recon-and-attacks/bettercap.md)
* [General](tools-services/general/README.md)
  * [impacket](tools-services/general/impacket.md)
* [Wordlists](tools-services/wordlists/README.md)
  * [cewl](tools-services/wordlists/cewl.md)

## Professional report writing

* [Report template](professional-report-writing/report-template/README.md)
  * [Web applicaton pentesting](professional-report-writing/report-template/web-applicaton-pentesting/README.md)
    * [OWASP report layout](professional-report-writing/report-template/web-applicaton-pentesting/owasp-report-layout.md)

***

* [Tasks on-the-go](tasks-on-the-go/README.md)
  * [Note taking on-the-go](tasks-on-the-go/note-taking-on-the-go.md)
  * [Other tips](tasks-on-the-go/other-tips.md)
* [Practice](practice/README.md)
  * [Web Application Pentesting](practice/web-application-pentesting/README.md)
    * [OWASP](practice/web-application-pentesting/owasp/README.md)
      * [OWASP Juice Shop](practice/web-application-pentesting/owasp/owasp-juice-shop.md)
      * [OWASP Mutillidae II](practice/web-application-pentesting/owasp/owasp-mutillidae-ii.md)
      * [OWASP Hackademic](practice/web-application-pentesting/owasp/owasp-hackademic.md)
    * [Vulnhub](practice/web-application-pentesting/vulnhub/README.md)
      * [...](practice/web-application-pentesting/vulnhub/....md)
    * [Damn Vulnerable Web Application (DVWA)](practice/web-application-pentesting/damn-vulnerable-web-application-dvwa.md)
  * [Metasploitable 2](practice/metasploitable-2.md)

## Operational Security (OpSec)

* [Hardening](operational-security-opsec/hardening/README.md)
  * [General](operational-security-opsec/hardening/general.md)
  * [Oracle VirtualBox](operational-security-opsec/hardening/oracle-virtualbox.md)
  * [Web Browser](operational-security-opsec/hardening/web-browser.md)
  * [VPN/Proxy](operational-security-opsec/hardening/vpn-proxy.md)

***

* [Safe document viewer](safe-document-viewer/README.md)
  * [PDF](safe-document-viewer/pdf.md)
  * [.docx](safe-document-viewer/.docx.md)

## Write-ups

* [TryHackMe](write-ups/tryhackme/README.md)
  * [Silver Platter](write-ups/tryhackme/silver-platter.md)
  * [Light](write-ups/tryhackme/light.md)
  * [Pickle Rick](write-ups/tryhackme/pickle-rick.md)
  * [Hammer](write-ups/tryhackme/hammer.md)
    * [Enumeration (active recon)](write-ups/tryhackme/hammer/enumeration-active-recon/README.md)
      * [/hmr](write-ups/tryhackme/hammer/enumeration-active-recon/hmr.md)
      * [Further directory discovery](write-ups/tryhackme/hammer/enumeration-active-recon/further-directory-discovery.md)
      * [/phpmyadmin](write-ups/tryhackme/hammer/enumeration-active-recon/phpmyadmin.md)
      * [burp suite sitemap](write-ups/tryhackme/hammer/enumeration-active-recon/burp-suite-sitemap.md)
    * [Brute forcing 4-digit code](write-ups/tryhackme/hammer/brute-forcing-4-digit-code.md)
    * [Retrieving the flag](write-ups/tryhackme/hammer/retrieving-the-flag.md)
  * [OWASP Top 10 - 2021 (task 22)](write-ups/tryhackme/owasp-top-10-2021-task-22.md)
  * [sqlmap](write-ups/tryhackme/sqlmap.md)
  * [Injectics](write-ups/tryhackme/injectics.md)
* [OverTheWire](write-ups/overthewire/README.md)
  * [Untitled](write-ups/overthewire/untitled.md)
* [OWASP](write-ups/owasp/README.md)
  * [OWASP Juice Shop](write-ups/owasp/owasp-juice-shop.md)
  * [OWASP WebGoat](write-ups/owasp/owasp-webgoat.md)

## AI prompt

* [ChatGPT](ai-prompt/chatgpt.md)
