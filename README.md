# Autorestart
This mod automatically restarts a server after a given amount of uptime is reached with an optional delay/grace period if players are online.

Long running Minetest servers accumulate large memory usage over time and may exhibit various performance issues. This is most noticeable on servers running on low-end hardware (or even VPSes). This mod aims to alleviate these issues by regularly restarting the server to keep it running fresh, while giving players a heads-up that the server will be restarting.

**NOTE**: This mod will simply request a server shutdown, your server setup will need to be able to start the server back up again e.g. in the form of a looping Bash script. See [Setting up a server](https://wiki.minetest.net/Setting_up_a_server#Running_the_Server) on the Minetest Wiki for an example of how to do so.

By default the mod will restart after 24 hours of uptime, with a grace period of 10 minutes if players are online. These values are configurable with `autorestart_interval` and `autorestart_delay`.

If `autorestart_delay` is 0 then it will immediately restart once the uptime is reached, otherwise it will give a certain grace period to players still online. If the server has no players at the time a restart is triggered, or if all players leave before the grace period is over it will immediately restart.
