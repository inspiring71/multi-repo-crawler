# Multi Repository Github Parallel Crawler
The main objective of this script is to crawl multiple Github repositories using [etcr crawler](https://github.com/inspiring71/etcr-infrastructure) in a parallel fashion and save the output in a postgresql database.

# requirements
1. Docker on your machine and you should be good!
2.

# How to run
1. Clone this repository into your machine.
2. Copy `.env.sample` and rename it to `.env`. You can update the setting according to your favorable output.
3. Copy `repo_list.env.sample` and rename it to `repo_list.env`. Make sure to put repositories and and multiple tokens (if you have) inside this file. Each token will be used for one project and the assignment is random.
4. Make sure `run_for_repos.sh` can be executed. If not, make it executable:
`sudo chmod +x run_for_repos.sh`
5. Run `./run_for_repos.sh` inside the cloned folder.


> **_NOTE:_**  Only modifying the repo_list.env is necessary before running the code. The .env file settings, can be used off-the-shelf.

# .env file setting
db_host: Name of the container postgresql database or the host address of a remote database
db_port: Database port that you want to connect to
db_user: Database username
db_pass: Database password
repositories: A list of repositories that you want to crawl. The format is "owner1/repo1,owner2/repo2,owner3,repo3"
token: You github token pool. You can create one (here)[https://github.com/settings/tokens?type=beta].
db_folder: Where you want your database information get stored in your machine.
data_dump_folder: In case you want to export/import databases, this will be the folder you mount from your machine.

# repo_list.env setting
repositories: A list of repositories that you want to crawl. The format is "owner1/repo1,owner2/repo2,owner3,repo3"
token: You github token pool. You can create one (here)[https://github.com/settings/tokens?type=beta].

# Questions/Issues?
Feel free to create an issue if you faced any issues.


