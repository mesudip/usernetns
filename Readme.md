# usernetns
Helpers for Setting private network namespace per-user basis. It provides cli helper and example systemd-service file.

## Install
```
    sudo ./install.sh
```

## Quick Start
1) Run a command inside network namespace ( create if not present )
```
    sudo usenetnsexe "$(whoami)" ifconfig
```

2) Run [test-systemd-service](./lib/systemd/system/usernetnstest%40.service)
```
    sudo systemctl start "usernetnstest@$(whoami)".service
    journalctl -a --no-pager  -u "usernetnstest@$(whoami)".service
```


## Commands provided
 - `makebridge name ipAddress ` : Helper for creating bridge interface and setting it up
 - `makeusernetns userName` : Setup namespace for a user
 - `usernetnsexe userName command` : Setup namespace if not set up and run a command on  namespace of that user. The command is run as root.

## Services

1) `usernetns-bridge.service` : Sets up bridge for working with user network namespaces

2)  `usernetns@.service` : Sets  up  network namespace for per-user
    Usage: let's say that your username is `username`, to setup network namespace for `username`

    `systemctl start usernetns@myusername.service`

3) `usernetnstest@.service` : An example service that can be started per-user basis, on that user's network namespace.