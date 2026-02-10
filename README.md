# kickoff42.nvim

## Introduction

This is a Neovim template I created based on the work I did to my own Neovim configuration, with the intent of being used in the 42School environment.

You can of course also use it outside of the 42 school environment (or even if you are not a 42 student).

This is supposed to be a Neovim template that is:

- minimal
- modular and easy to edit
- begginer friendly

## The inspo - kickstart.nvim

This is very much inspired by [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) which was the starting point for my configurarion.

**This is in no way associated with kickstart.nvim or it's creators.**
I just used their work as a foundation for my own configuration and as inspiration for this project.

Inside `kickstart_docs/` I added 2 files from kickstart.nvim (the original README.md and init.lua) because everything is REALLY well documented there and it might help you debug your config just like it helped me many times. When in doubt, try searching there.

# GUIDE - Installation and Set-up

## Installation @ 42 

> [!NOTE]
> This installation was done for the 42Porto campus environment, where we can't use `sudo` or a package manager. Instead we will install neovim and it's dependencies by downloading their binary files and placing them where they should be.

run the script. will elaborate later


## External Dependencies

These are the required dependencies Neovim will need:
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [fd-find](https://github.com/sharkdp/fd#installation)
- a Nerd Font: **optional**, provides various icons
    - choose one from the [website](https://www.nerdfonts.com/)
    - install it and apply it (either to your terminal emulator or overall system)
    - set `vim.g.have_nerd_font` in `init.lua` to **true**;
- if you lack additional dependencies refer to [kickstart's dependencies section](https://github.com/nvim-lua/kickstart.nvim/tree/master?tab=readme-ov-file#install-external-dependencies)

## Installing Neovim

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

## After installing this config for the first time, please:

- ### run `:checkhealth` to know the status of your set-up

This will help debug any errors you might be having, like missing dependencies.
Feel free to PM me (or open an issue) if have any errors you are not able to solve.

- ### press `<space><s><k>`

This will open a pop-up window with all the keybinds you have at your disposal. 

I believe it is crucial for your **nvim** experience to know what these are, what they do and how to use them. 
This is what makes neovim great and fun to use **imo**, and if you don't know how to use them or that they even exist you'll be missing out!
