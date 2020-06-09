# Workshop 1: Introduction to the terminal, navigating the Linux file system - Supplemental Information

## Workshop objectives

* Gain basic understanding of the different options that can be passed to the commands introduced in Workshop 1.

## What are command line options?

Nearly all terminal commands accept options. Options tell the command to do something "extra". 

Consider the command `ls`. We know from this workshop that `ls` lists the contents of a directory. 

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-1.png?raw=true">

Suppose we want to see additional information about the items in a directory. We can see additional information by specifiying the `-l` option. This tells `ls` to list the items in "long" format.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/sup-image-1.png?raw=true">

We see that `ls -l` reveals much more information about items such as the date and time they were created, the permissions and the size of each object.

We can also tell `ls` to display the size attribute in human-readable form by passing the `-h` option.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/sup-image-2.png?raw=true">

## Learning more about commands: `man`

Nearly all commands have a manual associated with them. The manual pages (often referred to as "man pages") can be invoked with the command `man`. 

`man` accepts the name of the command as an argument. For example,

```
    man ls
```

would produce the following.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/sup-image-3.png?raw=true">

## Navigating man pages

In general, the man pages for a command will be long. You can scroll the docs with up/down arrows or scroll by page with the spacebar. To exit from the man page, type `q` (for quit).

## Interpreting man pages

It is recommended that you get familiar with the Linux man pages and how to interpret the information they supply. This will be particularly useful as you spend more time in the terminal and the programs you use become more complex.

### Option format - vs --

Most command options have two formats, namely a short format (e.g., `-a`) and a long format (e.g., `--all`). While both accomplish the same objective. The short format is easier to remember.

In some cases, there is no short format for an option so the option will only have a long format (e.g., `ls --author`).

