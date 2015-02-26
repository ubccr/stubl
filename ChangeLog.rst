ChangeLog
===========

v0.0.9
----------------------

- fisbatch : fixed bug in SCREEN detection for users of csh 
- slogs : added support for "all" users
- Added slimits command. It shows users SLURM accounting limits (max jobs, etc.).

v0.0.8
----------------------

- fisbatch : removed --export option and check of screen test
- sjeff, sueff, slogs : extra cmd line args passed along to slurm command
- snodes : handle longer node names
- added new logo to github page

v0.0.7
----------------------

- Updated fisbatch command to delay a bit before connecting to screen.
- Updated slogs, snacct and suacct commands to accept date as first OR second arg.

v0.0.6
----------------------

- Added spinfo command.
- Updated fisbatch command. It makes a better attempt to identify the head node.
- Updated sjeff command. It can now report processor usage based on either ps or top.
- Updated slurmhelp command. It now includes spinfo and stimes.

v0.0.5
----------------------

- Added stimes command.

v0.0.4
----------------------

- Updated install docs to include clush dependency

v0.0.3
----------------------

- Updated install docs

v0.0.2
----------------------

- Add support for --help argument

v0.0.1
----------------------

- Initial release
