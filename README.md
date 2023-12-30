### Introduction
These are some scripts I "wrote". I keep them in ~/Scripts (which I add to my path).
Some of these are just wrappers to other commands I found counter-intuitive, or for
fairly intuitive commands that have crazy long `man` pages.

For example `hydra_ssh_brute.sh` just calls `hydra -l $2 -P $3 $1 -t 4 ssh -s $4`
and `ytmp3` just calls `youtube-dl -x --embed-thumbnail --audio-format mp3 $1`

There's a lot of great command-line tools out there, but I can't be asked to memorize
a new set of flags and patterns for each one. Especially for tools that do a wide range
of things.

### Installation
I use ParrotOS as my main daily-use operating system, and so these scripts are designed
to work on a more-or-less clean install of ParrotOS. That being said, most of these tools
are pretty common to anyone interested in cybersecurity or systems-administration work, and
I'm sure you'll have no difficulty installing them yourself if need be.


So assuming the tools these scripts wrap are already installed, you just have to run:
```
git clone https://github.com/jarlold/scripts_folder
mkdir ~/Scripts
mv scripts_folder/* ~/Scripts
echo "PATH=$PATH:~/Scripts" >> ~/.bashrc
```
And then restart your terminal emulator.


### Original scripts
Some of these scripts do actually have unique functions, but I simply found too small
to justify giving them their own repo, so they live in here.



| Script              | Description                                         |
| ------------------- | --------------------------------------------------- |
| `proxy_scraper`     | Scrapes, test, and formats proxies for proxychains. |
| `smtp_mta.sh`       | Pretends to be an SMTP MTA server delivering mail.  |
| `csv_parse.py`      | Pulls a column out of a .csv file.                  |
| `override_c_func.sh`| Use `LD_PRELOAD` to mess with C programs.           |
| `fix_stylus.sh`     | Tweaks some settings for styluses on old Fujitsu laptops. |
| `portrait_mode.sh`  | Extends the above to support portrait mode.         |



### Scripts that just adapt other scripts
Many of these scripts just take existing tools, and adapt them to work better syntactically.
For example, some tools only use old fashioned `-f` with no support for `--foo` or `--foo=bar`.
I find this annoying, since it means I have to check the `man` page to see what letter 
represents what- and sometimes those man pages are massive, unclear, or just not installed.

Another common occurrence is tools that don't support the Unix `|` by default.
So I've made some scripts to simply run `cat` at the start, store it in a variable, and then
pretend it was put on the CLI.

| Script                        | Description                                         |
| ----------------------------- | --------------------------------------------------- |
| `hydra_ssh_brute`             | Calls hydra's ssh brute in a less annoying way.     |

### Scripts that need some ancient ritual done before you use them
Some tools require that you do some ancient ritual of changing system files and settings before
you can use them. Normally after use, you want everything to be set back to normal.

So for example, `arpspoof` requires you to set ipv4 port forwarding, and I often forget to do this
or forget to un-do this. So the script `mitm_stuff.sh` makes sure it gets done without me.

While I'm there, I often add in extra layers of security, like changing and reverting the MAC address.

| Script          | Description                                                   |
| --------------- | ------------------------------------------------------------- |
| `mitm_stuff.sh` | Changes MAC addr, enable IP forwarding, then ARP-spoofs.      |

### Scripts that could really be aliases
A lot of these scripts could just be aliases in `~/.bashrc`. There's nothing technically wrong
with doing that, but I dislike it for a few reasons:
1. If you run `dist-upgrade` it will ask you if you'd like to overwrite `bashrc` with the package
   maintainers version. I've hit `yes` on accident before and got to practice my disk forensic skills.

2. It's another file/directory to worry about moving and setting up on new computers or installations.

3. Some distro's have cool `.bashrc`s built in, which means when I copy over my `.bashrc` I miss out!


| Script                        | Description                                         |
| ----------------------------- | --------------------------------------------------- |
| `ytmp3`                       | Calls youtube-dl to make mp3 w/ thumbnails.         |
| `find_suid_bits.sh`           | Finds files with insecure SUID bits.                |
| `python_terminal_upgrade.sh`  | Upgrade from `sh` to `bash` via python.             |
| `email_rep.sh`                | Get info from emailrep.io through curl.             |
