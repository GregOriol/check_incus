# check_incus
Nagios check script for running incus container

## Requires
A sudoers rule:
```
nagios  ALL=(root) NOPASSWD: /home/nagios/check_incus/check_incus.sh
```

## Setup
Nothing

## Usage
Nagios configuration:
```
define command {
        command_name    check_incus
        command_line    check_by_ssh "sudo /home/nagios/check_incus/check_incus.sh $ARG1$"
}

define service {
        use                             generic-service
        host_name                       myhost
        service_description             my-service
        check_command                   check_incus!mycontainer
}
```
