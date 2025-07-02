# RocketChat Virtual Presence automation

Script to automatically sign on and off in the RocketChat virtual presence channel.


## Signing on and off when you turn your laptop on or off

This is automated through a systemd user service.
Install the `rc_virtual_presence.service` file in `~/.config/systemd/user`.
(Make sure the script path in the service file is updated to match your system.)
Then reload your systemd daemon and enable the service.

Note that when you start (or stop) the service, it will check in (or out) immediately.
You can also just not start it manually - it will then start working from your next login.

## Signing on after your system wakes up from suspend

This is automated through a systemd *system* service.
(User services are not powerful enough.)
Since the network is also shut down during suspend, the script has to wait a bit before actually sending the API request.
Note the sleep command in the script for the "return from break" case.

Install the `rc_signin_on_wake.service` in `/etc/systemd/system`.
(Make sure the script path in the service file is updated to match your system.)
Then reload your daemon and enable the service (no need to start it).

This will run the script as root, so be careful.

## Signing off before you suspend your system

I have not found a reliable way to automate this with systemd - it's a race to get the script to run before network services are disabled.

Instead, I have updated my suspend keyboard shortcut to first run the script, then suspend the system.

I suggest you find a way to similarly integrate this script into your way of suspending the system.

If you like to use a sleep button on your laptop or similar, ... good luck!
Maybe you can catch and handle the acpi event manually?

