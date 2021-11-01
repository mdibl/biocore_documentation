# Command Line Intro Script

First things first, locate terminal/Powershell

* The CLI that is built into your macOS or Windows computer
* Incredibly powerful, provides you with text-based interaction of OS
  * lets you execute programs written specifically for CLI
  * manipulate files/directories
  * perform bulk actions
  * saves running history of commands/actions, reproducible

### ssh

From here, use the `ssh` program to connect to your remote AWS machine

* `ssh` user@ec2 etc....

Why use a remote computer and not just your local PC?

* Available compute/memory/resources
  * Access to these locally will vary, and in real world use will not be adequate
* Variations in OS, permissions, etc between attendees, provides a "standardized" learning env

Once all users are connected, we can proceed

### pwd

First command we'll cover, `pwd`

* prints out your current working dir to terminal
* if you're not sure where you are in the filesystem, this command will help you find your bearings
* right now you're inside your `home directory`

### ls

Next is `ls`, can anyone guess what this program does?

* lists all contents of your current working dir
* can be given an `argument` that modifies the behavior of the program
* `ls -l` lists contents of your dir, but with additional info, and in a list-format

Before we move on, lets look at what's been printed out on the terminal

* For each object row (file or dir), moving from left to right, we can see:
  * whether the object is a file or dir, denoted by `d` or `-`, first "flag"
  * available read/write/execute permissions, ordered by user/group/all
  * file size
  * date of last change to file
  * name

* `ls -al` lists *all* contents of our directory, including hidden files and folders
* `ls -lt` lists in order of creation

### man pages

As you can see, even a fairly straightforward program such as `ls` has a myriad of options

* To learn more about all that a specific program is capable of, you can view the manual using
* `man` *program name*
* Quit out of `man` with `q`

### clear

By now our terminal is starting to look a bit messy, lets clean it up by using the `clear` command

* clears your terminal of text

### cd 

To navigate throughout the filesystem, we use the `cd` command (standing for change directory), followed by where we want to go

* first, lets use `ls -al` again to view all contents of our homedir
* now use the `cd` command to move into the dir called `ghost_dir`
* executing the `pwd` command demonstrates that our current working directory has changed

lets list the contents of this dir with `ls`

* returns nothing, dir seems empty? Rerun with `ls -al`
* hidden file present, generally reserved for system files, etc

How can we get back to our home dir? A couple methods

* first is to simply use `cd` without any args
* another is to use a shorthand denoting "one dir above", this is `cd ..`

Now lets change into the `example_dir` directory

* run an `ls -l` to view contents
* `cd` into the `fastqc` directory
* `ls -l` contents
* Output of the program `fastqc`, a preliminary QC tool that generates a read quality report
  * also present is the config file used to execute this program (we'll cover this later), and log
* `pwd` shows that we're a couple directories down from `home`, few ways to get out

### absolute and relative paths

When working on the command line, you can navigate to, reference, view, and interact with files and dirs in two primary ways

Through using its Absolute path, or relative one

#### absolute path

* points to a location in file system, independent of your current working directory
* also called a "full path"
* location of file or dir relative to root directory
  * root dir is the highest dir in a file structure hierarchy (draw on screen?)
* ex: `/home/minota/example_dir/fastqc`

#### relative path

* points to location in file system, uses current dir as reference
* location of a file or dir relative to current dir
* ex: `./example_dir/fastqc`
  * truncated, not the "complete path"

Using the absolute path as an argument to `cd`, lets move back to our home directory

* `cd /home/minota/` *mention tab-auto-complete*

### mkdir / touch

* `cd` into `.ghost_dir`
* using the `mkdir` command, create a folder called `test_dir`
* `cd` into `test_dir`
* now use the `touch` program to create a file called `test1.txt`

### cp

next we're going to copy the file we just created using the `cp` command

* `cp test1.txt` followed by the name of the "copied" file you want to create (`test2.txt`)
* running `ls` shows that we have 2 files in our dir now
* when working with directories, you can use the `-r` flag to copy all of the contents of a directory
  * `cp -r`

### mv

the `mv` command allows you to move files and folders around the filesystem, as well as renaming them

* move `test2.txt` up a directory using the shorthand `../`
* `mv test2.txt ../`

now lets change the name of our `test1.txt` file to `renamed_test1.txt` using 

* `mv test1.txt renamed_test1.txt`
* `ls -l` to show change

once the rename has taken place, lets move up a directory with `cd ../`

### rm

To remove a file, you can use the `rm` command, followed by the file you wish to delete

* keep in mind, this is a *permanent* action, so be very careful when executing
* `rm test2.txt`

next, we're going to use the `mv` command to move our `test_dir` into our homedir

* `mv test_dir` `~`

now move out of `.ghost_dir` with `cd`

### rmdir

lets try to delete the `.ghost_dir` directory with the `rmdir` command

* `rmdir .ghost_dir` command

it failed, why?

a directory must be empty before deleting, there appears to be a file still present

* from your home directory, remove the hidden file in `.ghost_dir`
* `rm ./ghost_dir/.hidden_file.txt`

now use the `rmdir` command with `.ghost_dir` as target

### wildcards

when working with multiple files, you can use a special `wildcard` character to perform bulk manipulation by pattern matching

* `cd` into `test_dir`
* `touch test2.txt`

to remove both files at once, execute

* `rm *test*`
* removes any file with "test" in its name

`cd` back to homedir

### head + cat

the `head` command prints out the first 10 lines of the file you give it

* `head README.txt`
* the `-n` flag lets you custom specify the number of lines
* `head -n 20 README.txt`

the `cat` command prints out all contents of a file to terminal

* actually stands for concatenate, lets you join files together
* `cat README.txt`

now lets run `cat` on the `.fastq` file and see what happens

* small sequence file, begins printing all contents to terminal
* larger files could take a minute
* to kill an active command, use `ctrl + c`
* to rerun a previous command, you can use the `up` arrow on the keyboard, or the `!!` shorthand
  * rerun `cat` and cancel with `ctrl + c`

### less

opens file in interactive program to view and scroll through

* open the `.fastq` file in `less`, quit

### nano - interactive editing

nano is an interactive text editor, allows you to create and modify files on the CLI

* open `README.txt` with `nano`
* scroll with arrow keys
* to edit, just type, to save changes use `shift + o`, and to quit `shift + x`

### redirection

You can also redirect the output of a program to a text file, as opposed to letting it print to the terminal

* lets print the contents of our homedir to a file using the `>` redirection character
* `ls -al > homedir.txt`
* `ls -al`
* `cat homedir.txt`

### piping

The CLI has the capacity to chain together multiple programs, using the `|` pipe special character

* `ls -l | less`
* instead of printing to a dir, or being redirected to a file, contents of our working dir are opened in the `less` program

### history

For a running record of everything we've done so far, we can use the `history` command

* if you'd like to save it to a file, try `history > history_day1.txt`

### tmux

tmux is a terminal multiplexer. Essentially, it allows you to organize your terminal sessions into panes, which you can interact with and manipulate

* eliminates need to have multiple terminal windows open
* one of the most useful features is the ability to detach from a session
  * session lives until you kill it (restart, etc), and you can reattach at any time
  * especially needed when running large Bioinformatics processes
  * trigger a pipeline, detach, and check back later
* Otherwise, a "standard" terminal session can time out or lose connection, prematurely killing your process

#### launch

to launch a `tmux` session, simply execute the `tmux` command on the CLI

* a green bar at the bottom of your terminal indicates that `tmux` is active

commands in `tmux` are initiated by the use of a *prefix key*, followed by *command key*. Default is `ctrl + b` + `command`

#### exit

to exit `tmux`:

* type `exit` on the terminal, or use `ctrl + d`

now, relaunch `tmux`

#### detach

* to `detach` from an active session, use `ctrl + b` + `d`

this drops you out of `tmux` and back into your standard shell

however, you've only detached, not killed, so you can reconnect to your still-running session

#### view

* to view current sessions, use `tmux ls`

#### attach

to reattach to your session, use `tmux attach-session -t "session #"`

#### pane-split

to split your pane in a horizontal fashion, use `ctrl + b` + `"`

for vertical, `ctrl + b` + `%`

#### pane-navigation

great, we now have a couple open panes. how do we navigate between them?

simply use `ctrl + b` + `arrow key`