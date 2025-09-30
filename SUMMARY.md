# Table of contents

* [Introduction](README.md)
  * [Resources](introduction/resources.md)

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
  * [spiderfoot](tools/spiderfoot.md)

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
* [88 \~ Kerberos](3-network-services-vulnerability-scanning-and-exploitation/88-kerberos.md)
* [110 \~ POP3](network-services-vulnerability-scanning-and-exploitation/110-pop3.md)
* [111/2049 \~ RPC/NFS](network-services-vulnerability-scanning-and-exploitation/111-2049-rpc-nfs.md)
* [139/445 \~ SMB](network-services-vulnerability-scanning-and-exploitation/139-445-smb.md)
* [143 \~ IMAP](network-services-vulnerability-scanning-and-exploitation/143-imap.md)
* [3389 \~ RDP](network-services-vulnerability-scanning-and-exploitation/3389-rdp.md)

## Vulnerability & exploitation

* [Database](vulnerability-and-exploitation/database.md)
* [Metasploit](vulnerability-and-exploitation/metasploit/README.md)
  * [Meterpreter](vulnerability-and-exploitation/metasploit/meterpreter.md)
* [Msfvenom](vulnerability-and-exploitation/msfvenom.md)
* [Binary Exploitation](vulnerability-and-exploitation/binary-exploitation/README.md)
  * [Computer architecture](vulnerability-and-exploitation/binary-exploitation/computer-architecture/README.md)
    * [Instruction Set Architecture (ISA)](vulnerability-and-exploitation/binary-exploitation/computer-architecture/instruction-set-architecture-isa/README.md)
      * [x86 (32-bit)](vulnerability-and-exploitation/binary-exploitation/computer-architecture/instruction-set-architecture-isa/x86-architecture.md)
      * [x64 (64-bit)](vulnerability-and-exploitation/binary-exploitation/computer-architecture/instruction-set-architecture-isa/x64-64-bit.md)
      * [ARM32](vulnerability-and-exploitation/binary-exploitation/computer-architecture/instruction-set-architecture-isa/arm32.md)
      * [ARM64/AArch64](vulnerability-and-exploitation/binary-exploitation/computer-architecture/instruction-set-architecture-isa/arm64-aarch64.md)
    * [Memory Organization](vulnerability-and-exploitation/binary-exploitation/computer-architecture/memory-organization/README.md)
      * [General memory layout](vulnerability-and-exploitation/binary-exploitation/computer-architecture/memory-organization/general-memory-layout.md)
    * [System-Level Architecture](vulnerability-and-exploitation/binary-exploitation/computer-architecture/system-level-architecture/README.md)
      * [User vs Kernel space](vulnerability-and-exploitation/binary-exploitation/computer-architecture/system-level-architecture/user-vs-kernel-space.md)
  * [Buffer Overflow](vulnerability-and-exploitation/binary-exploitation/buffer-overflow/README.md)
    * [x86 (32-bit)](vulnerability-and-exploitation/binary-exploitation/buffer-overflow/x86.md)
  * [Tools](vulnerability-and-exploitation/binary-exploitation/tools/README.md)
    * [gdb, mona, ghidra, ...](vulnerability-and-exploitation/binary-exploitation/tools/gdb-mona-ghidra-....md)

***

* [Misconfigurations](misconfigurations/README.md)
  * [.DS\_Store](misconfigurations/.ds_store.md)

## Web Application Penetration Testing

* [Introduction](web-application-penetration-testing/introduction.md)
* [Injection attacks](web-application-penetration-testing/injection-attacks/README.md)
  * [SSTI](web-application-penetration-testing/injection-attacks/ssti.md)
  * [SQL injection](web-application-penetration-testing/injection-attacks/sql-injection/README.md)
    * [Filter evasion techniques](web-application-penetration-testing/injection-attacks/sql-injection/filter-evasion-techniques.md)
    * [Practical challenge examples](web-application-penetration-testing/injection-attacks/sql-injection/practical-challenge-examples/README.md)
      * [TryHackMe](web-application-penetration-testing/injection-attacks/sql-injection/practical-challenge-examples/tryhackme/README.md)
        * [Burp suite: Repeater room](web-application-penetration-testing/injection-attacks/sql-injection/practical-challenge-examples/tryhackme/burp-suite-repeater-room.md)
        * [Advanced SQL Injection](web-application-penetration-testing/injection-attacks/sql-injection/practical-challenge-examples/tryhackme/advanced-sql-injection.md)
* [Server-Side attacks](web-application-penetration-testing/server-side-attacks/README.md)
  * [Server-side Request Forgery (SSRF)](web-application-penetration-testing/server-side-attacks/server-side-request-forgery-ssrf.md)
  * [File inclusion & Path traversal](web-application-penetration-testing/server-side-attacks/file-inclusion-and-path-traversal/README.md)
    * [PHP wrappers](web-application-penetration-testing/server-side-attacks/file-inclusion-and-path-traversal/php-wrappers.md)
  * [Insecure Direct Object Reference (IDOR)](web-application-penetration-testing/server-side-attacks/insecure-direct-object-reference-idor.md)
  * [Upload vulnerabilities](web-application-penetration-testing/server-side-attacks/upload-vulnerabilities/README.md)
    * [File extension cheat-sheet](web-application-penetration-testing/server-side-attacks/upload-vulnerabilities/file-extension-cheat-sheet.md)
  * [Insecure deserialization](web-application-penetration-testing/server-side-attacks/insecure-deserialization/README.md)
    * [PHP magic methods](web-application-penetration-testing/server-side-attacks/insecure-deserialization/php-magic-methods.md)
    * [Tools](web-application-penetration-testing/server-side-attacks/insecure-deserialization/tools.md)
  * [Prototype pollution](web-application-penetration-testing/server-side-attacks/prototype-pollution.md)
* [Client-Side attacks](web-application-penetration-testing/client-side-attacks/README.md)
  * [CSRF](web-application-penetration-testing/client-side-attacks/csrf.md)
  * [CORS & SOP](web-application-penetration-testing/client-side-attacks/cors-and-sop.md)
  * [CORS vs CSRF](web-application-penetration-testing/client-side-attacks/cors-vs-csrf.md)
  * [Cross-site scripting (XSS)](web-application-penetration-testing/client-side-attacks/cross-site-scripting-xss.md)
* [HTTP Request Smuggling](web-application-penetration-testing/http-request-smuggling/README.md)
  * [HTTP](web-application-penetration-testing/http-request-smuggling/http.md)
  * [HTTP/2](web-application-penetration-testing/http-request-smuggling/http-2.md)
* [Web Content Discovery](web-application-penetration-testing/web-content-discovery/README.md)
  * [Directories/URLs gathering](web-application-penetration-testing/web-content-discovery/directories-urls-gathering.md)
  * [Subdomain enumeration](web-application-penetration-testing/web-content-discovery/subdomain-enumeration.md)

***

* [Authentication/session management](authentication-session-management/README.md)
  * [OWASP WSTG-SESS-10 \~ JSON Web Token (JWT)](authentication-session-management/json-web-token-jwt.md)
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
  * [OWASP top 10 2021](owasp/owasp-top-10-2021.md)
  * [OWASP API top 10 2023](owasp/owasp-api-top-10-2023.md)
  * [Web Security Testing Guide (WSTG)](owasp/web-security-testing-guide-wstg.md)
    * [WSTG-ATHZ](owasp/web-security-testing-guide-wstg/wstg-athz/README.md)
      * [WSTG-ATHZ-05 \~ OAuth weaknesses](owasp/web-security-testing-guide-wstg/wstg-athz/wstg-athz-05-oauth-weaknesses.md)
    * [WSTG-SESS](owasp/web-security-testing-guide-wstg/wstg-sess/README.md)
      * [WSTG-SESS-10 \~ JWT](owasp/web-security-testing-guide-wstg/wstg-sess/wstg-sess-10-jwt.md)
* [General web knowledge](general-web-knowledge/README.md)
  * [URI standard (RFC 3986)](general-web-knowledge/uri-standard-rfc-3986.md)
  * [HTTP headers](general-web-knowledge/http-headers/README.md)
    * [Exploitable headers](general-web-knowledge/http-headers/exploitable-headers.md)
    * [Request Smuggling](general-web-knowledge/http-headers/request-smuggling.md)

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

## Ⓜ️ MITRE ATT\&CK

* [Introduction](mitre-att-and-ck/introduction.md)
* [OS Credential Dumping (T1003)](mitre-att-and-ck/os-credential-dumping-t1003/README.md)
  * [LSASS memory (T1003.001)](mitre-att-and-ck/os-credential-dumping-t1003/lsass-memory-t1003.001.md)

## 🧰 Tools/services

* [Introduction](tools-services/introduction.md)
* [Web application pentesting](tools-services/web-application-pentesting/README.md)
  * [Web discovery/fuzzing](tools-services/web-application-pentesting/web-discovery-fuzzing/README.md)
    * [paramspider](tools-services/web-application-pentesting/web-discovery-fuzzing/paramspider.md)
    * [arjun](tools-services/web-application-pentesting/web-discovery-fuzzing/arjun.md)
    * [katana](tools-services/web-application-pentesting/web-discovery-fuzzing/katana.md)
  * [dirsearch](tools-services/web-application-pentesting/dirsearch.md)
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

## Forensics

* [Steganography](forensics/steganography/README.md)
  * [Resources](forensics/steganography/resources.md)
  * [Tools](forensics/steganography/tools/README.md)
    * [xxd, hexdump](forensics/steganography/tools/xxd-hexdump.md)
    * [strings](forensics/steganography/tools/strings.md)
    * [binwalk](forensics/steganography/tools/binwalk.md)
    * [exiftool](forensics/steganography/tools/exiftool.md)
    * [stegcracker](forensics/steganography/tools/stegcracker.md)

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
  * [Include](write-ups/tryhackme/include/README.md)
    * [Initial enumeration](write-ups/tryhackme/include/initial-enumeration.md)
    * [Express app (port 4000)](write-ups/tryhackme/include/express-app-port-4000/README.md)
      * [SSRF vulnerability](write-ups/tryhackme/include/express-app-port-4000/ssrf-vulnerability.md)
    * [Apache web server (port 50000)](write-ups/tryhackme/include/apache-web-server-port-50000/README.md)
      * [LFI + path traversal](write-ups/tryhackme/include/apache-web-server-port-50000/lfi-+-path-traversal.md)
    * [Further learning](write-ups/tryhackme/include/further-learning/README.md)
      * [Other access methods](write-ups/tryhackme/include/further-learning/other-access-methods.md)
      * [Gaining remote shell with LFI2RCE](write-ups/tryhackme/include/further-learning/gaining-remote-shell-with-lfi2rce.md)
      * [Inspecting Express app source code](write-ups/tryhackme/include/further-learning/inspecting-express-app-source-code.md)
* [OverTheWire](write-ups/overthewire/README.md)
  * [Untitled](write-ups/overthewire/untitled.md)
* [OWASP](write-ups/owasp/README.md)
  * [OWASP Juice Shop](write-ups/owasp/owasp-juice-shop.md)
  * [OWASP WebGoat](write-ups/owasp/owasp-webgoat.md)

## AI prompt

* [ChatGPT](ai-prompt/chatgpt.md)

## Windows Active Directory

* [Introduction](windows-active-directory/introduction/README.md)
  * [Resources](windows-active-directory/introduction/resources.md)
* [Initial Access](windows-active-directory/initial-access/README.md)
  * [Authentication](windows-active-directory/initial-access/authentication/README.md)
    * [NetNTLM](windows-active-directory/initial-access/authentication/netntlm.md)
  * [Others](windows-active-directory/initial-access/others.md)
* [Enumeration](windows-active-directory/enumeration/README.md)
  * [runas.exe](windows-active-directory/enumeration/runas.exe.md)
  * [Microsoft Management Console (MMC)](windows-active-directory/enumeration/microsoft-management-console-mmc.md)
  * [Command Prompt (cmd)](windows-active-directory/enumeration/command-prompt-cmd.md)
  * [Powershell](windows-active-directory/enumeration/powershell.md)
    * [Active Directory Module](windows-active-directory/enumeration/powershell/active-directory-module.md)
    * [Powerview](windows-active-directory/enumeration/powershell/powerview.md)
    * [ObjectClass](windows-active-directory/enumeration/powershell/objectclass.md)
  * [Bloodhound](windows-active-directory/enumeration/bloodhound/README.md)
    * [Data collectors](windows-active-directory/enumeration/bloodhound/data-collectors/README.md)
      * [Sharphound](windows-active-directory/enumeration/bloodhound/data-collectors/sharphound.md)
    * [Cypher](windows-active-directory/enumeration/bloodhound/cypher/README.md)
      * [Useful queries](windows-active-directory/enumeration/bloodhound/cypher/useful-queries.md)
    * [Icon mapping](windows-active-directory/enumeration/bloodhound/icon-mapping.md)
* [Lateral movement & Pivoting](windows-active-directory/lateral-movement-and-pivoting/README.md)
  * [Example scenario](windows-active-directory/lateral-movement-and-pivoting/example-scenario.md)
  * [Spawning remote processes](windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/README.md)
    * [Psexec](windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/psexec.md)
    * [WinRM](windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/winrm.md)
    * [sc.exe](windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/sc.exe.md)
    * [schtasks](windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/schtasks.md)
    * [Example](windows-active-directory/lateral-movement-and-pivoting/spawning-remote-processes/example.md)
  * [Windows Management Instrumentation (WMI)](windows-active-directory/lateral-movement-and-pivoting/windows-management-instrumentation-wmi/README.md)
    * [Example](windows-active-directory/lateral-movement-and-pivoting/windows-management-instrumentation-wmi/example.md)
  * [Leveraging alternate authentication materials](windows-active-directory/lateral-movement-and-pivoting/leveraging-alternate-authentication-materials/README.md)
    * [Pass-the-Hash (NTLM)](windows-active-directory/lateral-movement-and-pivoting/leveraging-alternate-authentication-materials/pass-the-hash-ntlm.md)
    * [Pass-the-Ticket (Kerberos)](windows-active-directory/lateral-movement-and-pivoting/leveraging-alternate-authentication-materials/pass-the-ticket-kerberos.md)
    * [Pass-the-Key/Overpass-the-Hash (Kerberos)](windows-active-directory/lateral-movement-and-pivoting/leveraging-alternate-authentication-materials/pass-the-key-overpass-the-hash-kerberos.md)
  * [Abusing user behavior](windows-active-directory/lateral-movement-and-pivoting/abusing-user-behavior/README.md)
    * [Abusing writable shares](windows-active-directory/lateral-movement-and-pivoting/abusing-user-behavior/abusing-writable-shares.md)
    * [RDP hijacking](windows-active-directory/lateral-movement-and-pivoting/abusing-user-behavior/rdp-hijacking.md)
* [Exploitation techniques](windows-active-directory/exploitation-techniques/README.md)
  * [Permission delegation](windows-active-directory/exploitation-techniques/permission-delegation.md)
  * [Kerberos delegation](windows-active-directory/exploitation-techniques/kerberos-delegation.md)
  * [Exploiting authentication relay \~ Print Spooler Service](windows-active-directory/exploitation-techniques/exploiting-authentication-relay-print-spooler-service.md)
  * [Group Policy Objects (GPOs)](windows-active-directory/exploitation-techniques/group-policy-objects-gpos.md)
  * [Exploiting Certificates](windows-active-directory/exploitation-techniques/exploiting-certificates.md)
  * [Exploiting domain trusts](windows-active-directory/exploitation-techniques/exploiting-domain-trusts-kerberos-golden-ticket.md)
  * [Kerberoasting (TGS-REP roasting)](windows-active-directory/exploitation-techniques/kerberoasting-tgs-rep-roasting.md)
  * [AS-REP roasting](windows-active-directory/exploitation-techniques/as-rep-roasting.md)
* [Credentials harvesting](windows-active-directory/credentials-harvesting/README.md)
  * [PowerShell history](windows-active-directory/credentials-harvesting/powershell-history.md)
  * [Registry Hives](windows-active-directory/credentials-harvesting/registry-hives.md)
  * [Volume Shadow Copy Service](windows-active-directory/credentials-harvesting/volume-shadow-copy-service.md)
  * [Local Security Authority Subsystem Service (LSASS)](windows-active-directory/credentials-harvesting/local-security-authority-subsystem-service-lsass.md)
* [General](windows-active-directory/general/README.md)
  * [Golden Ticket](windows-active-directory/general/golden-ticket/README.md)
    * [Inter-Realm TGT](windows-active-directory/general/golden-ticket/inter-realm-tgt.md)
* [Tools](windows-active-directory/tools/README.md)
  * [Responder](windows-active-directory/tools/responder.md)
  * [mimikatz](windows-active-directory/tools/mimikatz/README.md)
    * [sekurlsa::pth](windows-active-directory/tools/mimikatz/sekurlsa-pth.md)
  * [kekeo/rubeus](windows-active-directory/tools/kekeo-rubeus.md)
  * [TO explore](windows-active-directory/tools/to-explore/README.md)
    * [enum4linux](windows-active-directory/tools/to-explore/enum4linux.md)
    * [crackmapexec](windows-active-directory/tools/to-explore/crackmapexec.md)
    * [impacket](windows-active-directory/tools/to-explore/impacket/README.md)
      * [smbexec](windows-active-directory/tools/to-explore/impacket/smbexec.md)
    * [ldapsearch](windows-active-directory/tools/to-explore/ldapsearch.md)
    * [rpcclient](windows-active-directory/tools/to-explore/rpcclient.md)
* [Experimentations](windows-active-directory/experimentations/README.md)
  * [Reverse shell](windows-active-directory/experimentations/reverse-shell.md)
