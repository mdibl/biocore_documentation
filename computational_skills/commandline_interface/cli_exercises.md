---
title: Command Line Worksheet: Testing CLI Proficiency
author: Nathaniel Maki
created: 09-29-2021
---


# Command Line Worksheet

## Introduction:

The Bioinformatics Core at MDIBL has put together a short document to help you brush up on your Unix skills. We'll start with first getting you set up on your remote computer and gradually move through useful commands, with links in our Orientation page to relevant third-party and in-house documentation should you need a refresher.

These module will be loosely based upon the following [documentation](https://ngs-docs.github.io/2021-august-remote-computing/introduction-to-the-unix-command-line.html)

If you get stuck on an exercise or are unsure about how to proceed, don't hesitate to check the above link or post in the Discussion board on LabCentral

We will also be hosting office hours at set times throughout the week, where you can drop in and ask any questions you may have

## Module 0: SSh and Accessing Your Remote Machine

* Launch your terminal (macOS) / PowerShell (Windows)
* Log into your provisioned AWS machine using provided key / login credentials

## Module 1: Navigation on the Command Line

### Exercise 1.0

* Find your current working directory

### Exercise 1.1 

* List contents of current directory
* List *all* contents of current directory
* Learn more about the list command
* Clear the terminal

### Exercise 1.2

* Move into the hidden *ghost* directory
* Get current working directory
* List all contents of *ghost* directory
* Move back to a directory above
* Move into *example_dir* directory
* List all contents of *example_dir*
* Move back to your home directory, using shorthand
* Access ```man``` pages of a chosen CLI program

## Module 2: File and Folder Manipulation

### Exercise 2.1

* Move back into *ghost* directory
* Create a folder called test_dir
* Create a file called test1.txt inside of the *ghost* directory
* Move test1.txt into test_dir
* Move into test_dir, copy test1.txt to test2.txt
* Now migrate out of test_dir, up one directory
* Move test_dir and its contents into your home directory

### Exercise 2.2

* Recursively copy test_dir to test_dir2
* Move into test_dir2
* Remove both test*.txt files
* Move out of test_dir2
* Remove the test_dir2 directory

## Module 3: Content Visualization

### Exercise 3.1

* From your home directory, print the first 10 lines from the README file
* Print all contents of the README file to the CLI
* Run the same command without an input, and cancel the program invocation
* View all contents of the README file in an interactive program

## Module 4: File Permissions and Editing

### Exercise 4.1

* Check permissions of the contents of your root dir
* Move into test_dir1
* Open the test1.txt file in nano and add some text, saving changes, and exit
* Using the wildcard character, remove both text files
* Navigate up a directory and remove test_dir
* Using redirection, store the contents of your directory into a text file
* Pipe ls -l into less
* Print out the `history` of your command line entries to the terminal

## Module 5: Introduction to tmux

### Exercise 5.1

* Start a tmux session
* Quit your tmux session
* Re-enter tmux, and detach from current session
* View active sessions
* Re-attach to your session, and split the pane
* Move into new pane
* Kill current pane
* Kill all tmux sessions