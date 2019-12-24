# up42
UP42 initial API-automation assignment by, Itamar Jovani

---------

Introduction:

This project executes the 3 required action in the assignment:

1. Retreive Access Token
2. Create and run a job
3. Get Job State
- All done via API given in the assignment PDF

Project tested in UP42: Projectest
All information such as project ID, API key, etc are specified in the run.sh file

---------

Prerequisites:

#Install jq

 - Ubuntu: sudo apt-get install jq
 - Windows: chocolatey install jq
 - OSX: brew install jq

For more information and other platforms, go to: https://stedolan.github.io/jq/download/

---------

Get Access Token Demo:
As the Access Token is valid for only 5 minutes, I wrote a short script that will retreive a new one every time it runs.
I've incorporated it to the full project (run.sh) to complete the entire test.

Run the accessToken file:

  1. Download the accessToken.sh file
  2. Open terminal \ cmd
  3. grant exec permissions (i.e: chmod +x accessToken.sh)
  4. Run the file (i.e: ./accessToken.sh)

Run the full project:

  1. Download the run.sh file
  2. Open terminal \ cmd
  3. grant exec permissions (i.e: chmod +x run.sh)
  4. Run the file (i.e: ./run.sh)
  
NOTE: Between each job there is a cool-down period. Wait at least 1m before running the script again. (otherwise the job status will returen "null")
  
