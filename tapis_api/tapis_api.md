# Tapis HPC APIs:

  If your project or role in the group will depend on Agave (it probably will), review the following materials:
  https://tacc-cloud.readthedocs.io/projects/agave/en/latest/index.html
  https://agavepy.readthedocs.io/en/latest/
  https://github.com/TACC-Cloud
  https://sd2e.github.io/api-user-guide/

## Learning objectives:

  Create a private version of of a “storage system” and “execution system” using Stampede2
  Register an app on your private system (how about the image classifier from the Containers section)
  Run a successful job within that app


## Introduction:

  a) A system in Tapis represents a server or collection of servers.

  b) Systems are identified and referenced in Tapis by a unique ID unrelated to their ip address or hostname - hence, a single physical system may be registered multiple times.

  c) Flexibility : Allows different users to configure and use a system in whatever way they need to for their specific needs.

  d) Systems come in two flavors: storage and execution. - Storage systems are only used for storing and interacting with data. - Execution systems are used for running apps (aka jobs or batch jobs) as well as storing and interacting with data.

### Requirements:

* Install the new Tapis client from: https://github.com/TACC-Cloud/tapis-cli-ng

* With Tapis client installed, authenticate first:

```
  auth init

  systems list

  apps list
```

### Creating a storage system on Stampede2

* Create a JSON configuration file describing the type, name, host of the  
  storage system to be created. Follow the sample given here: https://tacc-cloud.readthedocs.io/projects/agave/en/latest/agave/guides/systems/systems- storage.html

* Use the Tapis CLI client to add/register the system

* In old CLI: systems-addupdate -v -F stampede2-storage-sgopal.json

* In new CLI: systems create -F stampede2-storage-sgopal.json

Please find the sample json files in the github repository.

Output:

     <img src="inst/register_storagesystem2.jpg" width="500">

     <img src="inst/register_storagesystem.png" width="500">


### Creating an execution system on Stampede2

  * Create a JSON configuration file describing the type, name, host of the storage system to be created. Follow the sample given here: https://tacc-cloud.readthedocs.io/projects/agave/en/latest/agave/guides/systems/systems- execution.html

  * There are many extra values that should be added: like define the queue for the system in use.

  * Use the Tapis CLI client to add/register the system

  * In old CLI: systems-addupdate -v -F stampede2-execution-sgopal.json

  * In new CLI: systems create -F stampede2-execution-sgopal.json

  Output:

     <img src="inst/system_list.png" width="500">


### Creating an APP and running a job on the registered system

  * To install an app like samtools, create a template file. These should be present on a Stampede system. Follow: https://tacc-cloud.readthedocs.io/projects/agave/en/latest/agave/guides/apps/app-wrapper-templates.html

  * Create a app json file:

  * From local system: start tapis or agave cli

  ```

  apps-addupdate -F app.json
  app-list jobs-template appid > job.json
  jobs-submit -F job.json
  job-status -v jobid

  ```
