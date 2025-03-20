#filename: create-github-page.sh
#prerequisite: github.com account
#prerequisite: wsl2
#prerequisite: bash
#prerequisite: git
#prerequisite: git (authenticated to github.com using ssh): https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#prerequisite: gh # which gh --> /usr/bin/gh
#outcome: create a github pages <user> site from scratch

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

# save variables to file
    # env > all_variables.txt # source exported_variables.txt
    #echo "create_file=\"$VAR1\"" >> variables.txt
    mkdir -p .temp # && touch .temp/variables.txt
    echo "github_pages_url=\"$github_pages_url\"" >> .temp/variables.txt
    source variables.txt # or # . variables.txt # restore saved variables to current bash session


# create directory and initialize git repository
mkdir $git_dir$repo_name
cd $repo_dir
git init # initialize git repository in current/present working directory (.)
git branch -m master main # rename initial/default branch
# git config --global init.defaultBranch main # consider executing this to set custom default branch name

# add first few files and commit
echo $'.temp/\ntemp/\n.venv/\n.secrets/\n.conda/\n*~$*\n*.cpython-312.pyc' >> ".gitignore"
echo $'# Hello World!# \nThe purpose of this repository is to store data to be accessed through the webpage '$github_pages_url > README.md # https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site#:~:text=Create%20the%20entry%20file%20for%20your%20site.%20GitHub%20Pages%20will%20look%20for%20an%20index.html%2C%20index.md%2C%20or%20README.md%20file%20as%20the%20entry%20file%20for%20your%20site.
echo $'\n# Conventions #\nSince this is an evolving project intended to accelerate learning (which for now requires copious comments) and does not presently have multiple branches I have chosen to create and implement a few conventions and standards to make comment-heavy code more readable.\n* line comments are often used to identify the functionality or rationale for a few lines of code\n* end-of-line comments are used to \n    * make eternal source and documentation references that give credit and provide additional instructions\n    * explain the preceeding code\n* comments generally begin with a `#` sign followed by a space*\n* use of certain substrings is reseved in order to enable quick generation of various lists\n    * `#tod0` is reserved for to-do list items so that future work can be planned in line comments even in the absence of an external project management/planning tools\n    * `#?` is used to begin commented code or plain text comments for code whose usage is questionable and subject to future review and verification\n* commented code generally appears at the beginning of lines' >> README.md
cat README.md
echo "#todo" > license
echo "Hello World" > index.html
# touch ".nojekyll" #? https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#:~:text=Alternatively%2C%20if%20GitHub%20Actions%20is%20unavailable%20or%20disabled%2C%20adding%20a%20.nojekyll%20file%20to%20the%20root%20of%20your%20source%20branch%20will%20bypass%20the%20Jekyll%20build%20process%20and%20deploy%20the%20content%20directly.
cp  $create_file $repo_dir"/genesis.sh"
git add *
git commit -am "first commit, hello world"

# create repository in github, add the remote to your local repository, perform initial push
gh repo create $repo_name --public 
gh repo edit --homepage $github_pages_url
#error: 2025/03/15 21:22:19.312888 cmd_run.go:1285: WARNING: cannot start document portal: dial unix /run/user/1000/bus: connect: no such file or directory


# add the remote origin on github
git config --unset core.sshcommand
git remote add origin $ssh_url 
git remote -v # verify URL of remote
# git remote set-url origin $ssh_url 
git push -u origin main # set upstream origin to main

echo "check out "$github_pages_url
