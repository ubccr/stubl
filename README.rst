=============================================================================
STUBL - SLURM Tools and UBiLities
=============================================================================

STUBL is a collection of supplemental tools and utilitiy scripts for `SLURM
<http://slurm.schedmd.com/>`_. 

-------------
REQUIREMENTS
-------------

A few commands included in STUBL require `clush <http://cea-hpc.github.io/clustershell/>`_. 
For rhel based systems clush is in `EPEL <https://fedoraproject.org/wiki/EPEL>`_. Debian 
based systems can run *apt-get install clush*. 

-------------
INSTALL
-------------

- To install STUBL download the `latest release <https://github.com/ubccr/stubl/releases>`_::

  $ tar xvf stubl-0.x.x.tar.gz
  $ cd stubl-0.x.x

- Copy the sample config file and edit to taste::

  $ cp conf/stubl.sample conf/stubl
  $ vim conf/stulb

- Create empty NodeInfo.log file::

  $ cp log/NodeInfo.log.sample log/NodeInfo.log

- (Optional) Build the slurmbf source::

  $ cd src/slurmbf
  $ make

- (Optional) Populate slurmbf NodeInfo.log  with clusters node information
  (RAM, disk size, scratch space, etc.). This will create a file log/NodeInfo.log
  and can be done by running the following command (can take a while)::

   $ ./bin/GetNodeInfo.sh

- Ensure stubl is in your path::

  $ export STUBL_HOME=/path/to/install/dir/stub-0.x.x
  $ export PATH=$STUBL_HOME/bin:$PATH

----------------------------------
Summary of STUBL SLURM Commands
----------------------------------

- *fisbatch*

  Friendly Interactive SBATCH. A customized version of sbatch that provides a
  user-friendly interface to an interactive job with X11 forwarding enabled. It
  is analogous to the PBS "qsub -I -X" command. This code was adopted from
  `srun.x11 <https://github.com/jbornschein/srun.x11>`_. (requires clush)

- *pbs2sbatch*

  Converts PBS directives to equivalent SLURM SBATCH directives. Accommodates
  old UB CCR-specific PBS tags like IB1, IB2, etc.

- *pbs2slurm*

  A script that attempts to convert PBS scripts into corresponding SBATCH
  scripts.  It will convert PBS directives as well as PBS environment variables
  and will insert bash code to create a SLURM_NODEFILE that is consistent with
  the PBS_NODEFILE.

- *sgetscr*

  Retrieves the SLURM/SBATCH script and environment files for a job that is
  queued or running.

- *sjeff*

  Determines the efficiency of one or more running jobs. Inefficient jobs are
  high- lighted in red text (requires clush).

- *slist*

  Retrieves SLURM accounting and node information for a running or completed
  job (requires clush).

- *slogs*

  Retrieves resource usage and accounting information for a user or list of
  users.  For each job that was run after the given start date, the following
  information is gathered from the SLURM accounting logs:

  - Number of CPUS
  - Start Time
  - Elapsed Time
  - Amount of RAM Requested
  - Average RAM Used
  - Max RAM Used

- *slurmbf*

  Analogous to the PBS \"showbf -S\" command.


- *snacct*

  Retrieves SLURM accounting information for  a given node and for a given
  period of time.

- *snodes*

  A customized version of sinfo. Displays node information in an
  easy-to-interpet format. Filters can be applied to view (1) specific nodes,
  (2) nodes in a specific partition, or (3) nodes in a specifc state.

- *spinfo*

  Show partition information for a cluster(s).

- *sqelp*

  A customized version of squeue that only prints a double-quote if the
  information in a column is the same from row to row. Some users find this
  type of formatting easier to visually digest.

- *sqstat*

  A customized version of squeue that produces output analogous to the PBS
  qstat and xqstat commands (requires clush).

- *sranks*

  A command that lists the overall priorities and associated priority
  components of queued jobs in ascending order. Top-ranked jobs will be given
  priority by the scheduler but lower ranked jobs may get slotted in first if
  they fit into the scheduler's backfill window.

- *stimes*

  Retrieves estimated starting times for queued jobs. All user-provided
  arguments are passed along to the squeue command.

- *suacct*

  Retrieves SLURM accounting information for a given user's jobs for a given
  period of time.

- *sueff*

  Determines the overall efficiency of the running jobs of one or more users.
  Users that are inefficient are highlighted in red text (requires clush).

- *yasqr*

  Yet Another Squeue Replacement. Fixes squeue bugs in earlier versions of
  SLURM.

----------
License
----------

STUBL is released under the GNU General Public License ("GPL") Version 3.0.
See the LICENSE file.
