# Octofish
[![](https://img.shields.io/badge/Framework-Oh My Fish-blue.svg?style=flat)](https://github.com/oh-my-fish/oh-my-fish) ![](https://img.shields.io/cocoapods/l/AFNetworking.svg) [![Join the chat at https://gitter.im/oh-my-fish/oh-my-fish](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/oh-my-fish/oh-my-fish?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Add it to your `~/.config/fish/config.fish` file:

    Theme octofish

Open a new terminal session and run `omf install`.

You will probably need a [Powerline-patched font][patching] for this to work.
[I recommend picking one of these][fonts].

This theme is based on [BobTheFish](https://github.com/oh-my-fish/theme-bobthefish) and the right shell comes directly from [FishLine](https://github.com/0rax/fishline).

### Features

 * A helpful greeting, displaying the IP address and uptime in days.
 * Powerline-style visual hotness (fits perfectly with iTerm2 Solarized Dark).
 * Visual indication that you can't write to the current directory (either a lock or a different background on the path)
 * An abbreviated path.
 * A glyph indicating current privileges ($ for user, *#* for root)
 * A nice and powerful Git right-prompt.
 * Optionally shows last command duration on the right prompt.


### The Left Prompt

 * A visual indicator of your privilege level
 * User@Host
 * Current RVM or rbenv (Ruby) version
 * Current virtualenv (Python) version
 * Abbreviated parent directory
 * Either a lock, or a red background when PWD is locked for writing
 * Flags:
     * Previous command failed (✘)
     * Background jobs (⚙)

### The Right Prompt

 * A tick if you're clean
 * Vertical arrows if you have some commit ahead or behind upstream
 * A slope sign for untracked files
 * A bolt for unstaged modifications (dirty state)
 * Your workflow is considered clean if there's nothing to commit or stage and no untracked file.

### Configuration

You can override some default options in your `config.fish`:

    set -g theme_display_duration yes #Display the duration of last command
    set -g theme_display_virtualenv no #Virtual Env.
    set -g theme_display_ruby no #Ruby version
    set -g theme_display_padlock yes #Padlock (when PWD is locked for writing)

--------
###### Published in the hope that it will be useful

[patching]:   https://powerline.readthedocs.org/en/latest/fontpatching.html
[fonts]:      https://github.com/Lokaltog/powerline-fonts
