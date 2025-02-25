# restart_service

Script to automatically restart services on Linux systems via cron. The input parameters are the name of the service to be restarted and a tag to record the task in the system logs - syslog.

## Parameters

Description of input parameters:

`restart_service.sh param1 param2`

**param1** - The name of the service to restart

**param2** - Tag to add when saving information in system logs - syslog

## Permissions

The script requires setting permissions for the owner to read, write and execute:

`sudo chmod 700 restart_service.sh`

## Call

An example call in cron is:

`0  18   * * *   root    /home/user/restart_service.sh haproxy restart_service_v_1_0_0`
