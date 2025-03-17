#filename: create-github-page.sh
#prerequisite: github.com account
#prerequisite: wsl2
#prerequisite: bash
#prerequisite: git
#prerequisite: git (authenticated to github.com using ssh): https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#prerequisite: gh # which gh --> /usr/bin/gh

# declare variables
create_file=/mnt/c/Users/charl/Downloads/project00.txt
git_dir="/mnt/c/Users/charl/git/" # this is where I store local git repostiories
github_username=cbradfield4096

# perform computations
repo_name=$github_username".github.io"
repo_dir=$git_dir$repo_name # construct dir path for new repo
echo $repo_dir
repo_url="https://github.com/"$github_username"/"$repo_name
ssh_url=$'git'"@github.com:"$github_username"/"$repo_name".git"
github_pages_url="https://"$repo_name; echo $github_pages_url


# create directory and initialize git repository
mkdir $git_dir$repo_name
cd $repo_dir
git init # initialize git repository in current/present working directory (.)
git branch -m master main # rename initial/default branch
# git config --global init.defaultBranch main # consider executing this to set custom default branch name

# add first few files and commit
echo $'Hello World!\n# The purpose of this repository is to store data to be accessed through the webpage '$github_pages_url > README
cat README
echo "#todo" > license
echo "Hello World" > index.html
cp  $create_file $repo_dir"/genesis.sh"
git add *
git commit -am "first commit, hello world"

# create repository in github, add the remote to your local repository, perform initial push
gh repo create $repo_name --public 
#error: 2025/03/15 21:22:19.312888 cmd_run.go:1285: WARNING: cannot start document portal: dial unix /run/user/1000/bus: connect: no such file or directory


# add the remote origin on github
git config --unset core.sshcommand
git remote add origin $ssh_url 
git remote -v # verify URL of remote
# git remote set-url origin $ssh_url 
git push -u origin main # set upstream origin to main

echo "check out "$github_pages_url
