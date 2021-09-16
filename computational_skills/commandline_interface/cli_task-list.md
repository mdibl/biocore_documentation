---
title: Command Line Task List: Building CLI Proficiency
author: Nathaniel Maki
created: 09-07-2021
---

# Command Line Task List: Building CLI Proficiency

## Module 0: SSH and Accessing Your Remote Machine

This module will cover the basics of locating your Terminal in macOS or Linux, and in the Windows OS, PowerShell. These tools act as a first step towards becoming acquainted with the Command Line Interface. For the purpose of this workshop, all instruction will be based upon and conducted on your remote Amazon Web Services machine. This way, all students will be able to have a uniform experience, regardless of local hardware. Before continuing, you need to be able to:

## Task List

* Access the Command Line Interface through terminal or PowerShell
* Use ssh capability to connect to a remote machine

## Required Commands

* ```ssh```

## Module 1: Navigation on the Command Line

The next module introduces basic commands and operations able to be carried out on the CLI. Before being able to proceed with this module, Module 0 must be completed. By now you should know how to:

## Task List

* Find your current working directory
* List all files/folders, use arguments to show hidden files/file details
* Move throughout the filesystem
* Work with both relative and absolute paths

## Required Commands

* ```pwd```
* ```ls```, ```ls -al```
* ```cd```

## Module 2: File and Folder Creation, Content Visualization

This module covers creating files and folders, and viewing their contents. Your required skills:

## Task List

* Create a file
* Create a folder
* Redirect output of command
* Print/view contents on CLI

## Required Commands

* ```touch```
* ```ls >```
* ```mkdir```
* ```cat```
* ```echo```
* ```less```

## Module 3: File and Folder Manipulation

Module 3 encompasses moving, copying, renaming, and removing files and folders

## Task List

* Move a file from one directory to another
* Move a directory from one directory to another
* Copy files and folders
* Rename files and folders
* Remove files and folders

## Required Commands

* ```mv```
* ```cp```
* ```rm```
* ```rmdir```

## Module 4: Intermediate Command Line Operations

This module covers some more involved arguments and capabilities, such as wildcards, recursive actions, and piping

## Task List

* Use the ```wildcard``` character for bulk operation
* Use Word Count command to check lines in file, pipe into List
* Recursively delete files and folders
* Manual pages
* Nano text editor

## Required Commands

* ```wc```
* ```* -r```
* ```man```
* ```nano```

## Module 0

## Locating Your Terminal

Before this workshop can begin in earnest, we must first locate our terminal and connect to our remote AWS machine.

## Launching a terminal in macOS

From Spotlight Search, type terminal. The terminal application should be the top result.

You can also launch the terminal from the application launcher or menu.

Once the terminal app launches you should see a window similar to the one below.

## Launching PowerShell in Windows

From the Start Menu, search PowerShell.

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

## Module 1

Now that you're all situated on your provisioned machine, it's time to run our first command!

Ensure that the terminal/PowerShell window is selected, and in all lowercase type

```
pwd
```

and hit the **enter** key

You should get an output that looks something like this

```
/home/ec2-user
```

## Locating Current Working Directory
