# How to get into IoT hacking?

## How I got started in IoT/hardware hacking

I started off with the curiosity of how vulnerabilties are exploited on IoT/hardware devices. Personally, I was particularly interested in binary exploitation (eg. stack buffer-overflow), and thought that working on a physical device would provide me with the best learning experience.

From there, I actively researched on existing vulnerabilities/CVEs on IoT devices, particularly those that involves "buffer overflow" type ones. I found a router model (_Linksys E1200 v2_) that had a bunch of existing CVEs with no publicly available/working exploit script. I went on to purchase a secondhand one from my local marketplace, along with a few tools: USB-UART adapter, digital multimeter and a stack of jumper wires.&#x20;

> Do not worry if you are unable to get your hands on a physical device, as I will provide methods to emulate a hardware environment later on!

I read a bunch of research articles, watched a bunch of YouTube videos, and experimented on the physical router to eventually craft a working proof-of-concept script for a few of the CVEs: stack buffer-overflow CVE ([CVE-2025-60690](https://nvd.nist.gov/vuln/detail/CVE-2025-60690)), and command injection ([CVE-2025-60689](https://nvd.nist.gov/vuln/detail/cve-2025-60689), [CVE-2025-34037](https://nvd.nist.gov/vuln/detail/cve-2025-34037)). You may read more about it [here](https://github.com/Jarrettgohxz/CVE-research/tree/main/Linksys/E1200-V2).

> Common Vulnerabilities Exposure (CVE) is a standardized, publicly available list or dictionary of known cybersecurity flaws and software or hardware vulnerabilities

## How to get started?

I have curated a beginner step-by-step guide on IoT hacking. After you have build your fundamentals, you may proceed to research and experiemnt on different classes of vulnerabilities  on devices you own. **Remember to always practice your hacking skills/research on a device you own, ethically!**

### Useful prerequisites

A foundation in computer networking, basic Python scripting, Linux command-line and the willpower to press on when things get tough!









