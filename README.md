# company new application

## Requirement

* Docker v1.13.0
* GitLab Community Edition v10.4.7
* Access to external network


## Setup

### Step 1
Initialize an empty remote git repository, replace value of `__GIT_REPO__` with `${your_git_repo_url}` in `bin/pipeline_init.sh`, 
and execute `bin/pipeline_init.sh` for initialize GOCD's pipeline in project's root directory.
Then push current directory to remote git repository.

### Step 2
Type below command to build image and start.

```bash
docker build . -t company-news-app-container:latest && \
docker run -it --rm --name company-news-app-container \
  -p "8153:8153" -p "18080:18080" -p "18081:18081" \
  company-news-app-container:latest
```

Then type `install.sh` in container, wait for installation complete.

### Step 3
Open your favorite browser, type `http://localhost:8153/` to access GOCD server.
Click `ADMIN => Config Repositories`, complete that table with your initialized git repository.
Wait a moment, until GOCD build and deploy your code. access `http://localhost:18080` to ensure deployment successfully. 

After deployment successfully, modify your code a little bit, commit and push to your remote git repository. 
Wait a moment, access `http://localhost:18080` to view your change.


## Dev environment
Checkout a new branch `dev`, replace values of `__GIT_BRANCH__, __PORT__` with `dev, 18081` in `bin/pipeline_init.sh`, 
execute `bin/pipeline_init.sh` for initialize GOCD's pipeline in project's root directory.   

Then push current directory to remote git repository with branch `dev`.   
**Repeat step 3**.


## Issues
* `yum install -y go-server-19.7.0-9567 go-agent-19.7.0-9567` require package of `sysvinit-tools` on docker image of `centos:7` 
