ChangeLog
===========

v0.0.10
----------------------
configuration variables (conf/stubl)
--- added: STUBL_JOBSCRIPT_ROOT_DIR 
--- added: STUBL_USER_EXCLUDE 
--- added: STUBL_PRESUM_FILE 

GetNodeInfo.sh
--- added ":sort -u" filter to down and draining nodes

fisbatch
--- qos args are now matched to partition per new UB CCR accounting policy
--- unset python environment before running nodeset and then restore it

pbs2sbatch
--- removed --export statement from conversion

pbs2slurm
--- added shell (#!/bin/bash) if needed

sgetscr
--- scripts now retrieved from location of job script logs (STUBL_JOBSCRIPT_ROOT_DIR)

sjeff
--- added estimate of memory usage

slimits
--- qos args are now matched to corresponding partition 

slist
--- now supports cluster argument and optional sacct arguments

slogs
--- added a "--plus" argument to select an enhanced output format that includes data on cpu and memory efficiency. 
--- added a SACCT_XFMT environment variable to request additional fields of output.

slurmhelp
--- added summary of stubl sacvenger commands
--- added seff, sausage and scounts commands

snacct
--- added optional --end argument
--- improved logic for determining which args are nodes

suacct
--- added Exit Code to list of fields

sueff
--- added estimate of memory usage

*NEW* sausage
--- A command for examining slurm account usage (number of cpu hours) over a period of time

*NEW* sausage_helpers
--- Helpers for the sausage command

*NEW* scabatch
--- A command for submitting scripts to scavenger partitions that are spread over multiple clusters.

*NEW* scavenger-checker
--- A command for querying scavenger partitions that are spread over multiple clusters.

*NEW* scavenger-profiler
--- A command for profiling scavenger partitions that are spread over multiple clusters.

*NEW* scounts
--- A command for examining number of jobs submitted by a user or group over a period of time

*NEW* slogs_helpers/
--- Helpers for the slogs command

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
