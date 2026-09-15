# Quick start

## 1. Installation&#x20;

* Clone the Github repository
* Give execute permissions and execute the `init.sh` script

```shellscript
$ git clone https://github.com/Jarrettgohxz/iotsec.tools
$ cd iotsec.tools

$ sudo chmod +x init.sh
$ ./init.sh
```

This script will perform the following:

1. Install Docker
2. Enble Docker service
3. Create symlink from `/usr/local/bin/iotsec.tools` to the `run.sh` script

## 2. Running iotsec.tools&#x20;

Follow the steps above to install required dependencies before coming to this step.&#x20;

The `iotsec.tools` command will build and start the Docker environment, and directly drop into the CLI interface where you can access a range of IoT/binary security tools in a new workspace (default to current working directory).

> Note that this script depends on the output from the previous `init.sh` step

```shellscript
$ iotsec.tools
```

### Options

#### help

```shellscript
$ iotsec.tools --help
Usage: iotsec.tools [OPTIONS]

IoT Security Research Framework

Options:
    -d, --dir <PATH>
    --dir=<PATH>        Specify local workspace directory to mount into /workspace inside the Docker container
                        Defaults to current working directory (${PWD})

    -r, --rebuild       Force rebuild of the Docker image, ignoring existing cached images
    -h, --help          Display this help message and exit

Examples:
1) Launch using the current directory
    iotsec.tools

2) Mount a specific local directory
    iotsec.tools -d/--dir /path/to/localdir
    iotsec.tools --dir=/path/to/localdir

3) Force rebuild and launch
    iotsec.tools -r/--rebuild

4) Rebuild image and mount custom directory
    iotsec.tools -r/--rebuild --dir=/path/to/localdir

```

#### Workspace directory (`-d/--dir`)

To specify a custom local working directory (default to current working directory)

```shellscript
$ iotsec.tools -d/--dir /path/to/localdir
$ iotsec.tools --dir=/path/to/localdir
```

#### Force rebuild (`-r/--rebuild`)

To rebuild the Docker image. You will likely not require this option most of the time

<pre class="language-shellscript"><code class="lang-shellscript"><strong>$ iotsec.tools -r
</strong><strong>$ iotsec.tools --rebuild
</strong></code></pre>

