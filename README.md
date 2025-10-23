# The install method below for homebrew, neovim, etc is deprecated!

**42Porto no longers accepts files in `sgoinfre/` that are not related to a project's VM or 42-Advanced!**

This means that you have to manually install neovim and it's dependencies. I recommend going to **Neovim**, **fd-find** and **ripgrep** repos and downloading and extracting the `.tar` files, then placing its contents where they should be in your home dir. This isn't hard but I plan on writing a script that will automate this process in the future. It will be part of this repo.

The **Neovim** config I have here remains unaffected and working and I plan on improving it when I feel the need to.

## After installing this config for the first time, please:

- ### run `:checkhealth` to know the status of your set-up

This will help debug any errors you might be having, like missing dependencies.
Feel free to PM me (or open an issue) if have any errors you are not able to solve.

- ### press `<space><s><k>`

This will open a pop-up window with all the keybinds you have at your disposal. 

I believe it is crucial for your **nvim** experience to know what these are, what they do and how to use them. 
This is what makes neovim great and fun to use **imo**, and if you don't know how to use them or that they even exist you'll be missing out!

# kickoff42.nvim

## Introduction

This is a Neovim template I created based on the work I did to my own Neovim configuration, with the intent of being used in the 42School environment.

You can of course use it outside of the 42 school environment (or even if you are not a 42 student), just ignore the 42 part of the installation and configuration.

This is supposed to be a Neovim template that is:

- minimal
- modular and easy to edit
- begginer friendly

## The inspo - kickstart.nvim

This is very much inspired by [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) which was the starting point for my configurarion.

**This is in no way associated with kickstart.nvim or it's creators.**
I just used their work as a foundation for my own configuration and as inspiration for this project.

I added inside `kickstart_docs/` 2 files from kickstart.nvim (the original README and init.lua) because everything is REALLY well documented there and it might help you debug your config just like it helped me many times. When in doubt, try searching there.

# GUIDE - Installation and Set-up

**DISCLAIMER**: 
During this guide I will always use Homebrew as a package manager (explanation below). If you're not using it then replace every time I use `brew` with whatever package manager you want.

## Installation @ 42 

> [!NOTE]
> This installation was done for the 42Porto campus environment. You might have a different set of rules and regulations if you're in a different campus so take this into account.

### Homebrew
[Homebrew](https://brew.sh/) is the package manager we will use to install Neovim and it's dependencies. Because we are not allowed to use `sudo` inside the 42 school environment, **Homebrew** is a good work-around to install and manage packages.

Homebrew will take quite a big chunk of the available space in our user's home directory, so we will install it on `~/sgoinfre/`. Mine is using ~2.8GB atm so not a lot for `sgoinfre`, but more than half of the available space in my user's home dir.

### Moving Homebrew installation - skip if you don't have it installed

Run:
```
brew bundle dump
``` 
This will create a `Brewfile`, which is a log of the packages you installed through Hombrew. Save the path to this file, we will use it to recover these packages later.

Uninstall Homebrew:
- use Homebrew's [unninstall script](https://github.com/homebrew/install#uninstall-homebrew) (safer)
OR
- delete it manually:
```
which brew
/path/to/Homebrew/bin/brew
rm -rf /path/to/Homebrew/
```

Now we'll move the installation to `sgoinfre/`

### Installing Homebrew

Go to the `sgoinfre/` directory:
```
cd ~/sgoinfre
``` 
Then we'll create a folder for Homebrew and install it like so:
```
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/main | tar xz --strip-components 1 -C homebrew
```
We also have to create a `Cache` and `Temp` directories inside the homebrew folder:
```
cd ~/sgoinfre/homebrew
mkdir Cache && mkdir Temp
```
Then, add these lines in your `.zshrc` or `.bashrc`:
```
HPREFIX="${HOME}/sgoinfre/homebrew"
export HOMEBREW_PREFIX="$HPREFIX"
export HOMEBREW_CELLAR="$HPREFIX/Cellar"
export HOMEBREW_CACHE="$HPREFIX/Cache"
export HOMEBREW_TEMP="$HPREFIX/Temp"
# export HOMEBREW_LOGS="$HOMEBREW_CACHE/Logs"
export HOMEBREW_REPOSITORY="$HPREFIX/Homebrew"
export HOMEBREW_CASK_OPTS="${HOME}/Applications"
export PATH="$HPREFIX/bin:$HPREFIX/sbin:/home/${HOME}/.local/bin${PATH+:$PATH}"
export MANPATH="$HPREFIX/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="$HPREFIX/share/info:${INFOPATH:-}"
# export HOMEBREW_NO_ANALYTICS=1
# export HOMEBREW_NO_ENV_HINTS=1
```

For `fish`, create or edit the `/home/[YOUR USER]/.config/fish/functions/brew.fish` to be:
```
function brew --wraps=/home/${HOME}/sgoinfre/homebrew/bin/brew --description 'alias brew=/home/${HOME}/sgoinfre/homebrew/bin/brew'
  /home/${HOME}/sgoinfre/homebrew/bin/brew $argv;
end
```

**If you created the dump file** (replace `[path]/[to]/`):
```
brew bundle --file=[path]/[to]/Brewfile
```
to install packages from previous installation of Homebrew.

## Installing Neovim

> [!NOTE]
> installing Neovim might take a while if you are using a custom install path for Hombrew, like my guide above
>
> It will take ~10 minutes, don't be discouraged

To install Neovim just run (skip if you installed neovim through the `brew bundle` command above):
```
brew install neovim
```

## External Dependencies

These are additional dependencies that Neovim will need:
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) | `brew install ripgrep`
- [fd-find](https://github.com/sharkdp/fd#installation) | `brew install fd`
- a Nerd Font: optional, provides various icons
    - choose one from the [website](https://www.nerdfonts.com/)
    - install it with `brew [nerd-font]`
    - set `vim.g.have_nerd_font` in `init.lua` to **true**;
- if you lack additional dependencies refer to the `kickstart_files/kickstart_README.md` file

## Installing Kickoff42.nvim 

This next part will be pretty much the same as the one on kickstart.

> [!NOTE]
> [Backup](https://github.com/nvim-lua/kickstart.nvim/blob/master/README.md#FAQ) your previous configuration, if you have one

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickoff42.nvim.git`
> replace `Disvster` with `<your_github_username>` in the commands below

```sh
git clone https://github.com/Disvster/kickoff42.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## Post Installation

Run Neovim
```
nvim
```
and that's it! Hopefully everything went fine and you now have Lazy installing all the plugins.
You can run `:Lazy` to view your current plugin status. Hit `q` or `:q` to close it's window.

## Please Read the Documentation!

`init.lua` has a small summary of what every plugin is doing and `lua/vim-options.lua` has most of the keybinds you'll wanna use regularly, so please take your time reading it! Some plugins have additional keybinds inside that you'll wanna know, like `42-norminette`.

Make sure to change the 42 Header to your `user` and `mail` as well!

You can read `kickstart_files/kickstart_init.lua` if you want more in-depth information.

## Finishing notes

This project wouldn't exist if it wasn't for my friends still using vim and my frustration seeing them not have the same tools I have at my disposal, aka being 3.54s slower than me writing code (it's a lot I swear).

But in all seriousness I feel like the **syntax highlighting**, seamless **navigation** through code/codebases, **on-screen** **compiler** and **norminette warnings**, and even CoPilot chat, helped me a LOT in optimizing my workflow without compromising simplicity. 

This doesn't aim to be a hand-holding config at all. I believe most AI and LSP tools do not help a beginner programmer, It's like learning how to ride a bike but never removing the training wheels off.

Let me know if you have any doubts/issues and feel free to PM me on slack, my user is **manmaria**.
