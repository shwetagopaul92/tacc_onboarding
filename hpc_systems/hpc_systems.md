# HPC Systems

* Know about the different systems at TACC, how they differ, and what kind of jobs they are good for
deliverable: bullet points on the big “take aways"

* Know about the filesystems, pros and cons of each, and make a plan to stay organized with your work on the systems you are going to be part of 3+ projects using multiple HPC systems; plan accordingly
eliverable: bullet points

My filesystem at TACC is:
  - $cdw:
    * Has all the different system's directories like hikari/, stampede2/
    * Has apps/ - with the different apps I have installed
    * Has jobs/ - with examples for launcher, pylauncher, idev, mpi jobs
    * Has projects/ - to navigate through different projects
    * Has singularity - with .simg files
  - Since I would be part of more than 3 projects, I would like to keep my files at $cdw, this   
    would allow me to navigate to the projects from any system I am logged on to. If the files are
    specific to a particular system, I would create a directory within $cdw/systemname.

* With one job, compare performance between Stampede SKX nodes and KNL nodes.
eventually know how to build software on the systems (in user space)
https://tacc.github.io/ctls2017/docs/hpc_software_environment/hpc_software_environment_01.html
deliverable: script that loads and runs a custom module that you installed for yourself


## Big "take aways" on HPC Systems/ File Systems at TACC

1. Lonestar 5

## Key points:

* OS & Software Environment: Cray Linux Environment 6
* File System: NFS ($HOME) and Lustre parallel distributed system($WORK, $SCRATCH)
* Number of compute nodes: 1252 CPU heavy,

Login nodes
* Dual Socket
* Xeon CPU E5-2650 v3 (Haswell): 10 cores per socket (20 cores/node), 2.30GHz
  128 GB DDR4-2133
* Hyperthreading Disabled
* Don’t run jobs on login nodes

* The login nodes are meant to be used exclusively for file management, editing and compiling. DO  
  NOT run programs on the login nodes.
* The login nodes are shared among all users currently logged into LS5.
* Interactive programs such as R and MATLAB must be run on the compute nodes, NOT the login nodes,
  requiring an interactive session.

Compute Nodes
* Dual Socket
* Xeon E5-2690 v3 (Haswell) : 12 cores per socket (24 cores/node), 2.6 GHz
  64 GB DDR4-2133 (8 x 8GB dual rank x8 DIMMS)
* No local disk
* Hyperthreading Enabled - 48 threads (logical CPUs) per node

Note: Compute nodes lack a local disk, but users have access to a 32 GB /tmp RAM disk to accelerate IO operations. Space taken in /tmp will decrease the total amount of memory available on the node.

* Accessing Lonestar 5: ssh taccuserid@ls5.tacc.utexas.edu
Note: Avoid running jobs in the $HOME directory. Run jobs in $WORK or $SCRATCH such that all job output, both stdout and stderr, is directed to those filesystems.
Note: Avoid too many simultaneous file transfers. Three concurrent scp sessions is probably fine. One hundred concurrent file sessions is not.
Computer Environment : Bash
Place customizations to .bashrc files if needed
Modules: Lmod for module management
Module commands: module avail, module load modulename, module list, module key - check
File transfers can be done with scp, sftp, rsync
File Systems & Quotas: Lonestar 5 mounts the three file systems that are shared across all nodes: home, work, and scratch. The system also defines for you corresponding account-level environment variables $HOME, $SCRATCH, and $WORK.
Several aliases are provided for users to move easily between file systems:
Use the "cdh" or "cd" commands to change to $HOME
Use "cdw" to change to $WORK
Use the "cds" command to change to $SCRATCH

2. Maverick2

## Key Points:

Login Nodes
* More GPUs, used for machine learning applications …
* Maverick2 hosts a single login node:
* Dual Socket
* Intel Xeon CPU E5-2660 v3 (Haswell) @ 2.60GHz: 10 cores/socket (20 cores/node)
  128 GB DDR4-2133 (8 x 16GB dual rank x4 DIMMS)
* Hyperthreading Disabled

Compute Nodes:
* Hyperthreading Disabled
* File System: Maverick2 mounts two shared Lustre file systems on which each user has  
  corresponding account-specific directories $HOME and $WORK.
  Each file system is available from all Maverick2 nodes; the Stockyard-hosted work file system is available on other TACC systems as well.
* Managing Files:
  Maverick2's home file system is mounted only on Maverick2, but the work file system mounted on Maverick2 is the Global Shared File System hosted on Stockyard. This is the same work file system that is currently available on Stampede2, Wrangler, Lonestar5, and several other TACC resources.
  The $STOCKYARD environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the $STOCKYARD environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System. This directory is an excellent place to store files you want to access regularly from multiple TACC resources.
* Accessing the System: ssh username@maverick2.tacc.utexas.edu
* File transfer using scp, rsync


LS5, Stampede2, Frontera - heavy computation - like running simulation
Maverick2(single precision), Longhorn, Frontera (single precision) part -  for heavy GPU use - good for double precision, machine learning tasks

LS5 - Memory, Frontera,
I/O : Frontera (NSF , maybe couple 100 users)
LS5 - has 10000 or so users
GPU: Mavericl2, Longhorn, frontera gpu, LS5

3. Hikari

## Introduction:

Hikari is a large-scale compute resource deployed as a result of a collaboration between TACC, the New Energy and Industrial Technology Development Organization (NEDO), a Japanese government agency, and NTT FACILITIES INC.
It is designed to support secure/compliant computing needs (HIPAA/FISMA compliant data), as well as an increasing demand for fast turnaround on the jobs submitted through web APIs from Science Gateways.
Hikari features a secure data management workflow for protected data.

## OS & Software Environment: CentOS 7

* Batch Services with Slurm 17.02
* File System:
NFS system ($HOME) and a Luster parallel distributed file system ($WORK).
* Hikari does not have a scratch file system mounted.
* Hikari mounts two filesystems that are shared across all nodes: /home and work. The system also  
  defines for you corresponding account-level environment variables $HOME and $WORK. $HOME has a strict quota of 5GB.
* Large data should be placed on $WORK
* Don't run jobs in $HOME. The $HOME file system is for routine file management, not parallel jobs.
* Run I/O intensive jobs in $SCRATCH rather than $WORK
* Avoid too many simultaneous file transfers.
* Avoid recursive file transfers.
* Hikari's home file system is mounted only on Hikari, but the work file system mounted on Hikari  
  is the Global Shared File System hosted on Stockyard.
* Before transferring large files to Hikari, or creating new large files, be sure to set an  
  appropriate default stripe count on the receiving directory.
  lfs setstripe -c 30 $PWD

* Number of compute nodes:  432 24-core general compute nodes
* System Storage:   27TB of memory and 13TB of disk storage
* Accessing the System:
  ssh myusername@hikari.tacc.utexas.edu
Note:Do not run ssh-keygen on Hikari

* Transferring Files: You can transfer files between Hikari and Linux-based systems using either scp or rsync

Login Nodes
* Hikari hosts 2 login nodes:
* Dual Socket
* Intel Xeon CPU E5-2660 v3 (Haswell) @ 2.60GHz: 10 cores/socket (20 cores/node)
  128 GB DDR4-2133 (8 x 16GB dual rank x4 DIMMS)
* Hyperthreading Disable
A login node is a good place to edit and manage files, initiate file transfers, compile code, submit new jobs, and track existing jobs.
* Avoid computationally intensive activity on login nodes

4. Stampede2

* Introduction: flagship supercomputer at the Texas Advanced Computing Center. The first phase of the Stampede2 rollout featured the second generation of processors based on Intel's Many Integrated Core (MIC) architecture.

## Key Points:

* OS & Software Environment: Red Hat Enterprise Linux 7
* Login Shell: The default login shell for your user account is Bash.
* File Systems:
  Stampede2 mounts three shared Lustre file systems on which each user has corresponding account-specific directories $HOME, $WORK, and $SCRATCH.
* Each file system is available from all Stampede2 nodes; the Stockyard-hosted work file system is
  available on several other TACC systems as well.
* File Transfer: You can transfer files between Stampede2 and Linux-based systems using either scp
  or rsync.  Globus is another way for XSEDE users to transfer data between XSEDE

* Accessing the System: ssh myusername@stampede2.tacc.utexas.edu
* XSEDE users can also access Stampede2 via the XSEDE Single Sign-On Hub.
Note : TACC's sanitytool module loads an account-level diagnostic package that detects common account-level issues and often walks you through the fixes. (module load sanitytool).
* Using Modules to Manage your Environment: Lmod, a module system developed and maintained at TACC, makes it easy to manage your environment so you have access to the software packages and versions that you need to conduct your research.

5. Jetstream

## Introduction:  
NSF-funded (NSF-1445604), user-friendly cloud environment designed to give researchers access to interactive computing and data analysis resources on demand, whenever and wherever they want to analyze their data.
It provides a library of virtual machines designed to do discipline-specific scientific analysis. Software creators and researchers will also be able to create their own customized virtual machines (VM) or their own private computing system within Jetstream.
Has a web-based user interface.
* Jetstream is meant primarily for interactive research, small scale processing on demand, or as the backend to science gateways to send research jobs to other HPC or HTC resources.
* Jetstream is different in that you can work with GUIs that you couldn't otherwise use on most HPC systems.


6. Ranch

## Introduction:
The Ranch system fills the need for high capacity storage, by providing a massive, high-performance file system for archival purposes. Ranch (ranch.tacc.utexas.edu), is now a Quantum Stornext filesystem based system, with a DDN provided front-end disk system (30PB raw), and a Quantum Scalar i6000 tape library. Ranch is an archival system.
* The Ranch system is not backed up or replicated -> Ranch contains a single copy of user data.

## Key Points:
* System Configuration: Ranch's primary storage system is a DDN SFA14K DCR (Declustered RAID) based system which is managed by Quantum's Stornext filesystem. The raw capacity is around 30PB, with about 17PB usable space for user data. Metadata is stored on a Quantum SSD based appliance. * The backend tape library, which is where files migrate after they have been untouched on disk for a period of time (this will be tuned, but it is currently a few weeks), is a Quantum Scalar i6000
* Accessing the System: ssh taccusername@ranch.tacc.utexas.edu
* Environment Variables: The preferred way of accessing Ranch, especially from scripts, is by using the TACC-defined environment variables $ARCHIVER and $ARCHIVE.
* Monitor Ranch Disk Usage and File Counts: tail ~/HSM_usage
* Transferring Data:
* scp (recommended) and rsync (avoid if possible).
* Use the Unix tar command or another utility to bundle large numbers of small files together, before transferring to Ranch, for more efficient storage and retrieval on Ranch.
* Limit your scp processes to no more than four at a time.

# Slurm

Know about SLURM, be able to submit jobs, look at output, troubleshoot, use remora to profile successful “toy” jobs using launcher, pylauncher, MPI, and an interactive job.  
The deliverable is the filesystem paths from which you launched the jobs.

## Overview

Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters. Slurm requires no kernel modifications for its operation and is relatively self-contained. As a cluster workload manager, Slurm has three key functions. First, it allocates exclusive and/or non-exclusive access to resources (compute nodes) to users for some duration of time so they can perform work. Second, it provides a framework for starting, executing, and monitoring work (normally a parallel job) on the set of allocated nodes. Finally, it arbitrates contention for resources by managing a queue of pending work.


- Running a job Using launcher:
* Create a SLURM submission script: launcher.sh - /work/06935/sgopal/stampede2/launcher
* Description: Simple single node task to print task number with hostname.
* submit the job: sbatch --reservation

* To monitor the job :
```
 squeue -u sgopal

```
* Grab the job ID
```
 squeue -j jobid
 ssh into the node
 top
 launcher task

```
More help documentation: https://github.com/TACC/launcher

Check the environment variables mentioned here LAUNCHER_JID running
* The jobs can be found at : /work/06935/sgopal/jobs

- Running an interactive job:
Using idev: /work/06935/sgopal/stampede2/idev/blastp_test

```
 idev -m 120 -N 2 -n 4 -p unprotected

```

Note: 120 minutes, 2 nodes, 2 tasks per node (so n is 4)  
      Starts a knl compute node
			Will start a compute node looking like “c455-101”
* Running blastp
* Monitor the jobs with squeue commands and ssh into compute nodes

- Running a job using Pylauncher

The pylauncher is a python-based parametric job launcher, that is, a
utility for executing many small jobs in parallel.  On many
batch-based cluster computers this is a better strategy than
submitting many small individual small jobs.

```
  module load pylauncher

```
With a simple example:

commandlines file:

```
  ####
  #### This file was automatically generated by:
  #### python make_commandlines.py 256 1 40
  ####
  echo 0 >> /dev/null 2>&1  ; sleep 21
  echo 1 >> /dev/null 2>&1  ; sleep 30
  echo 2 >> /dev/null 2>&1  ; sleep 8
  echo 3 >> /dev/null 2>&1  ; sleep 34
  echo 4 >> /dev/null 2>&1  ; sleep 39
  echo 5 >> /dev/null 2>&1  ; sleep 9

```

pylauncher_test_file.py
```
  #!/usr/bin/env python

  import pylauncher3

  ##
  ## Emulate the classic launcher, using a one liner
  ##

  #pylauncher.ClassicLauncher("corecommandlines",debug="job+host+task")
  pylauncher3.ClassicLauncher("commandlines",debug="job")

```
Run on idev:

```
  module load pylauncher
  python pylauncher_test_file

```

Output:
<img src="inst/pylauncher_output.png" width="500">

idev -p development


- Launch a job with MPI

```

#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Stampede2 KNL nodes
#
#   *** MPI Job on Normal Queue ***
#
# Last revised: 20 Oct 2017
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch knl.mpi.slurm" on Stampede2 login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do not use mpirun or mpiexec.
#
#   -- Max recommended MPI tasks per KNL node: 64-68
#      (start small, increase gradually).
#
#   -- If you're running out of memory, try running
#      fewer tasks per node to give each task more memory.
#
#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 4               # Total # of nodes
#SBATCH -n 32              # Total # of mpi tasks
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=myname@myschool.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A myproject       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module list
pwd
date

# Launch MPI code...

ibrun ./mycode.exe         # Use ibrun instead of mpirun or mpiexec

# ---------------------------------------------------
```
