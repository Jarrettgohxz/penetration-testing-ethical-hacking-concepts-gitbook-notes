# PortfolioS

### Resources

{% embed url="https://bksec.vn/blog/writeup-cscv-2025" %}

{% embed url="https://github.com/awslabs/aws-mysql-jdbc/security/advisories/GHSA-vj9v-mpjv-qf74" %}

{% embed url="https://stackoverflow.com/questions/3833578/linux-command-for-extracting-war-file" %}



### Extraction and analysis of source code

...

#### 1. Extract files from `.war`

```sh
$ sudo apt install default-jdk
$ jar xvf /path/to/portfolio.war
```

#### 2. Decompile selected .class files

*   There are a few files of interest:

    1\) `WEB-INF/classes/com/ctf/portfolio/controller/AuthController.class`

    2\) `/WEB-INF/classes/com/ctf/portfolio/controller/InternalController.class`

    3\) ...



* We can use the **CFR Java Decompiler**
  * Install the `cfr-xxx.jar` file from the [Github ](https://github.com/leibnitz27/cfr)repository release page (filename depends on the current version):

```sh
$ java -jar cfr-xxx.jar <to-decompile>.class
```

* Alternatively, we can use directly open any `.class` file in an editor such as Visual Studio Code, which will automatically decompile it.

...

