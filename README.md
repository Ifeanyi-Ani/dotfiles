# How I manage dotfiles

_The technique consists in storing a Git bare repository in a "side" folder
(like ==$HOME/.dotfiles== or $HOME/.forlderName) using a specially crafted
==alias== so that commands are run against that repository and not the usual
.git local folder, which would interfere with any other Git repositories
around._

---

## Start from Scratch

_If you haven't been tracking your configurations in a Git repository before,
you can start using this technique easily with these lines:_

```bash
mkdir ~/.dotfiles
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc &&
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```

- The first line creates a folder ~/.dotfiles which is a Git bare repository
  that will track our files.
- Then we create an alias config which we will use instead of the regular git
  when we want to interact with our configuration repository.
- We set a flag - local to the repository - to hide files we are not explicitly
  tracking yet. This is so that when you type config status and other commands
  later, files you are not interested in tracking will not show up as untracked.
- Also you can add the alias definition by hand to your .bashrc/zshrc or use the
  the fourth/fifth line provided for convenience.

_After you've executed the setup any file within the $HOME folder can be
versioned with normal commands, replacing git with your newly created config
alias, like:_

```bash
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

---

## Usage

_If you already store your configuration/dotfiles in a Git repository, on a new
system you can migrate to this setup with the following steps:_

- Prior to the installation make sure you have committed the alias to your
  .bashrc or .zsh:
  ```bash
  alias config='/usr/bin/git
  --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  ```
- Now clone your dotfiles into a bare repository in a "dot" folder of your
  $HOME:

```bash
git clone --bare <git-repo-url> $HOME/.dotfiles
```

- Checkout the actual content from the bare repository to your $HOME:

```bash
config checkout
```

- The step above might fail with a message like:

```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

_This is because your $HOME folder might already have some stock configuration
files which would be overwritten by Git. The solution is simple: back up the
files if you care about them, remove them if you don't care. I provide you with
a possible rough shortcut to move all the offending files automatically to a
backup folder:_

```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

- re-run the checkout
- You're done, from now on you can now type config commands to add and update
  your dotfiles:

```bash
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Usage Summary

_For simply setup this is what I ended up_

```bash
git clone --bare https://github.com/Ifeanyi-Ani/dotfiles.git $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```
