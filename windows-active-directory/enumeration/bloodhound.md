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

### Steps to install Bloodhound on Kali Linux

#### 1. Install Docker&#x20;

{% embed url="https://docs.docker.com/engine/install/" %}

a. Uninstall old versions (optional)

```sh
$ for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

b. Setup Docker `apt` repository

```sh
# Add Docker's official GPG key:
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl
$ sudo install -m 0755 -d /etc/apt/keyrings
$ sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
$ sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
$ version_codename="bullseye"
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  "$version_codename" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

$ sudo apt-get update
```

> The value for `version_codename` should be replaced with your particular Debian code name such as `Bookworm` , `Bullseye` , etc.

c. Install packages

```sh
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

d. Start the relevant Docker daemon/systemd unit

```sh
$ sudo systemctl start docker
$ sudo systemctl start docker.socket
```

#### 2. Install Bloodhound CE

{% embed url="https://github.com/SpecterOps/bloodhound-cli/releases/latest" %}

```sh
# remember to replace the filename based on your architecture (relese page link above)
$ wget https://github.com/SpecterOps/bloodhound-cli/releases/latest/download/bloodhound-cli-linux-amd64.tar.gz

$ tar -xvzf bloodhound-cli-linux-amd64.tar.gz # replace apprioprately too

$ ./bloodhound-cli install # use with sudo if fails
```

### How start BloodHound manually

To save system resources, we can disable the `docker` and `docker.socket` processes, to prevent it from running on system boot.

```sh
$ sudo systemctl disable docker
$ sudo systemctl disable docker.socket

# to stop the bloodhound instance
$ ./bloodhound-cli down
```

**Manually start BloodHound**

```sh
$ sudo systemctl start docker
$ sudo systemctl start docker.socket

# navigate to the directory where the bloodhound-cli binary is stored
$ ./bloodhound-cli up
```

After starting BloodHound, we can navigate to the default web interface: [http://127.0.0.1:8080/ui/explore](http://127.0.0.1:8080/ui/explore).
