---
title: Command Line Orientation: Building CLI Proficiency
author: Nathaniel Maki
created: 09-07-2021
---

# Command Line Task Orientation: Building CLI Proficiency

## Introduction

Hi! Welcome to our Command Line Orientation! This document is meant to act as a guide to the command line, with links to useful resources, videos, and additional documentation for you to access and review. We've also included a link to a short worksheet, meant to test your CLI skills. For parity of experience, we've spun up personal Amazon compute instances for each user. This lets every student follow along, regardless of their local operating system.

Included under each module will be links to relevant material, provided by both in-house and external authors.

## Available Materials and References

* For our in-house Command Line markdown documentation, select this [link](biocore_stuff).
* Click this [link](https://www.youtube.com/watch?v=Irl8VXxqs8o) to access useful Command Line videos by the Hubbard Center for Genome Studies. These will be helpful for all Modules.
* This [link](https://ngs-docs.github.io/2021-august-remote-computing/introduction-to-the-unix-command-line.html) also contains a useful guide to the command line, and from which the exercises somewhat follow.
* Lastly, this [link](https://medium.com/hackernoon/a-gentle-introduction-to-tmux-8d784c404340) provides a fantastic introduction to the ```tmux``` program (which we'll cover in class).

## Module 0: SSH and Accessing Your Remote Machine

This module will cover the basics of locating your Terminal in macOS or Linux, and in the Windows OS, PowerShell. These tools act as a first step towards becoming acquainted with the Command Line Interface. For the purpose of this workshop, all instruction will be based upon and conducted on your Amazon Web Services machine. This way, all students will be able to have a uniform experience, regardless of local hardware. Before continuing, you need to be able to:

## Locating Your Terminal

Before this workshop can begin in earnest, we must first locate our terminal and connect to our remote AWS machine.

For ease of use, we've broken Module 0 up into OS specific portions
## Module 0: macOS

### Launching a terminal

From Spotlight Search, type **terminal**. The terminal application should be the top result.

You can also launch the terminal from the application launcher or menu.

Once terminal opens, you should see a window similar to the one below.

## Module 0: Windows

### Launching PowerShell in Windows

Open the Start Menu, and search for PowerShell.

Once you launch the PowerShell app, you should see a window similar to the one below.

## SSH and Connecting to your AWS Machine

Launching an ssh session is accomplished with the `ssh` command. `ssh` accepts the destination of the remote machine as an argument.

You'll have been provided an address to a remote machine, as well as a .pem file.

The .pem file will allow you to securely access your specific AWS instance.

If your .pem file is located in your Downloads folder, ensure your terminal/PowerShell windows is open, and mimic the following command.

```
ssh -i ~/Downloads/test_key.pem ec2-user@ec2-3-138-120-84.us-east-2.compute.amazonaws.com
```

Your terminal/PowerShell windows should look like the following.

Once logged in, you can begin with the next Module in this workshop

## Module 1: Navigation on the Command Line

The next module introduces basic commands and operations able to be carried out on the CLI. It includes listing directory contents, moving around on the command line, and accessing the Manual of a given program. Before being able to proceed with this module, Module 0 must be completed.

### Required Skills:

* Find your current working directory
* List all files/folders, use arguments to show hidden files/file details
* Move throughout the filesystem
* Work with both relative and absolute paths

## Module 2: File and Folder Manipulation

This module covers creating files and folders, moving, copying, renaming, and removing files and folders.

### Required Skills:

* Create a file
* Create a folder
* Move a file from one directory to another
* Move a directory from one directory to another
* Copy files and folders
* Rename files and folders
* Remove files and folders

## Module 3: Content Visualization

This module covers file visualization, using basic and interactive programs.

### Required Skills:

* Print the contents of a file to terminal
* Program cancellation
* Open file in a CLI application

## Module 4: File Permissions and Editing

This module encompasses using a text editor program to modify files, using wildcards, viewing permissions, and piping.

### Required Skills:

* View permissions
* Edit files and folders, using wildcard character
* Command redirection
* Piping

## Module 5: Introduction to tmux

The last module covers working with tmux and actions such as attaching and detaching sessions, splitting, and moving between open sessions.

### Required Skills:

* tmux session management