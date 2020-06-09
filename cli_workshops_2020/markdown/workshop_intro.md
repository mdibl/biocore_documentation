# Workshop 1: Introduction to the terminal, navigating the Linux file system

## Workshop objectives

* Gain basic understanding of the command-line interface (terminal).
* Become familiar with file system navigation using the terminal.
* Become familiar with creating, deleting, moving and copying data using the terminal.

## Supplemental Resources
This workshop series will explore a variety of Linux terminal commands. We will start with some of the most basic commands and progress up from there. The [resources](#resources) section at the end of this document contains a list of supplemental resources that you can reference at any time during this workshop series and after.

## What is the command-line interface and why is it important?

The command-line interface (CLI), is a light-weight, text-based, command-driven
tool for interacting with a computer's operating system (OS). The CLI is often
referred to as a terminal or a console.

During a terminal session, a user types commands into the terminal. The
operating system executes the command and the results are printed back to the
terminal

## Launching a terminal in Mac OSX
From Spotlight Search, type terminal. The terminal application should be the top result.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-2.png?raw=true">

You can also launch the terminal from the application launcher or menu.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-3.png?raw=true">

Once the terminal app launches you should see a window similar to the one below.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-4.png?raw=true">

## Launching PowerShell in Windows

From the Start Menu, search PowerShell

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/start_menu.png?raw=true">

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/search_powershell.png?raw=true">

Once you launch the PowerShell app, you should see a window similar to the one below.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/powershell.png?raw=true">

## The Linux File System
A file system is a layer underneath your computer's operating system. 

The file system is responsible for the positioning and storage of data. 

A file system will consist of one or more *partitions*. In Windows, the most familiar partition is `C:\`. 

The Linux file system structure will also have one or more partitions. The most familiar is `\`, the *root* partition.

In Linux, data is organized in directories underneath the root directory. 

Directories are synonymous with folders in a graphical user interface (GUI). 

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/comparison.png?raw=true">


A typical Linux distribution will include the following directories.

    /bin (where core executable commands live)
    /boot (where files for booting the system live)
    /dev (where physical drives like CD and DVD drives are mounted)
    /etc (where configuration for installed programs live)
    /home (where your files and data will live)
    /lib (where libraries for installed packages will live)
    /mnt (where you mount things like storage devices)
    /opt (where optional packages will live)
    /proc (where information about running processes will live)
    /root (the home folder for the root user)
    /tmp (where temprary files live)
    /usr (where shared resources for users will live)
    /var (where logs and variable data will live)

During a terminal session, a user is free to operate in their `/home` directory because the own that directory. However, operating in other directories such as `/etc` or `/root` is typically restricted if not prohibited because those directories are owned by the `root` user.

## Navigating the File System `ls`

In a graphical environment, a user navigates the file system by clicking on folder links to display the contents of that folder. 

In the terminal, the user must issue commands to move to a directory and subsequently, display the contents of that directory.

A terminal session will typically start in the user’s home directory (e.g., `/home/your_username`).

The `ls` command can be used to list the contents of a directory. For example:

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-7.png?raw=true">

The `ls` command will also accept an argument such as the name of a directory.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-8.png?raw=true">

## Navigating the File System `cd` and `pwd`

To change directories use the `cd` command and pass the name of the directory as an argument. Subsequently, you can use the command `pwd` to verify where you are in the file system. `pwd` will print the path to your current location.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-9.png?raw=true">

You can then inspect the contents of your new location with the `ls` command.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-10.png?raw=true">

## Managing Files and Directories: `mkdir`

In a terminal session, we will often want to manage files and directories. 

This includes creating new directories, deleting, moving or copying existing directories and files. 

You can create new directories with command `mkdir`. This command accepts the name of the new directory as an argument.

*Example: create directory my_new_directory*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-11.png?raw=true">

## Managing files and directories: `rm`

Files and directories can be deleted (removed) with rm .

Files can be removed by simply calling rm passing the filename as an argument.

  *Example: removing the file file3.txt*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-12.png?raw=true">

Directories are deleted by supplying the additional `–r` option to `rm` along with the directory name as an argument.

The `–r` option tells `rm` to recursively delete all files and directories contained in the specified directory.

*Example: remove the directory my_new_directory*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-13.png?raw=true">

## **!!DANGER!!**

The terminal is not very forgiving when it comes to `rm`.

Files that are removed with `rm` are typically not recoverable. So be careful!

## Managing files and directories: `mv`

Moving (or renaming) data via the terminal is accomplished with command `mv`.

The `mv` command accepts two argument, namely the source and the destination.

*Example: renaming directory my_project to my_other_other_project*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-14.png?raw=true">

*Example: moving file1.txt into directory my_other_project*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-15.png?raw=true">

## Managing files and directories: `cp`

Data can also be "copied" via the terminal. 

Like `mv`, `cp` accepts two argument, namely the source and the destination.

*Example: copying file2.txt my_other_project*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-16.png?raw=true">

When copying a directory, you must specify the `–r` option which tells the command to copy all content in that directory. 

*Example: copying my_project into my_project_2*

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-17.png?raw=true">

## Resources 
There is a plethora of online resources for the comand-line. Below is a list of resources that you can easily reference as you build your command-line skills.

* [The ultimate A-Z list of terminal commands.](https://fossbytes.com/a-z-list-linux-command-line-reference/). This reference contains a comprehensive list of Linux terminal commands. This might be too extensive when just starting out with the terminal but it will come in handy as your skills improve.

* [An A-Z index of Linux terminal commands.](https://ss64.com/bash/) This tool provides a searchable, text-based list of commands. Again, this is a comprehensive list similar to the previous reference.

* [Powershell equivalents of Linux commands.](https://mathieubuisson.github.io/powershell-linux-bash/) If you are working from Windows PowerShell, this resource provides a fairly detailed list of Linux commands and the PowerShell equivalent.
