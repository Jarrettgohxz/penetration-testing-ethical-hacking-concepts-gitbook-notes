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

#### 1. Install Docker Desktop&#x20;

{% embed url="https://docs.docker.com/desktop/setup/install/linux/#general-system-requirements" %}

a. KVM virtualization support

Ensure that KVM support is enabled. For VirtualBox, this means enabling the _**Enable Nested VT-x/AMD-V**_ settting via _**System**_ -> _**Processor**_ -> **Enable&#x20;**_**Nested VT-x/AMD-V**_

```sh
$ modprobe kvm # load kvm module manually

# load kvm module for the processor (either one)
$ modprobe kvm_intel
$ modprobe kvm_amd

$ sudo usermod -aG kvm <username> # add user to the kvm group
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

c. Install package

First, we have to download the `.deb` file from the source

> Note: the type of package file to download should be based on your Linux flavor. Refer to the main documentation link at the top to find the download link for your particular flavor.

Next, install it:

```sh
$ sudo apt-get install ./docker-desktop-amd64.deb
```

d. Launch Docker desktop

```sh
$ systemctl --user start docker-desktop
```

#### 2. Install Bloodhound CE

{% embed url="https://github.com/SpecterOps/bloodhound-cli/releases/latest" %}

```sh
# remember to replace the filename based on your architecture (relese page link above)
$ wget https://github.com/SpecterOps/bloodhound-cli/releases/latest/download/bloodhound-cli-linux-amd64.tar.gz

$ tar -xvzf bloodhound-cli-linux-amd64.tar.gz # replace apprioprately too

$ ./bloodhound-cli install
```
