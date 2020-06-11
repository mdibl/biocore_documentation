# Workshop 1: Introduction to the terminal, navigating the Linux file system - Supplemental Information

## Workshop objectives

* Gain basic understanding of the different options that can be passed to the commands introduced in Workshop 1.

## Supporting Video Tutorials
This document is supported by a series of videos that cover roughly the same content. The video references are described below:

1. [Command line options and man pages](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EUKqYiR4SppDvKmvltrJmm0BiyPK2tXBuSjK0JjAByT9zg?e=DPhP1w) This video clip provides a brief introduction to command line options.
2. [Command line real-time demo](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/ETURaUJtdVRIs-yh1GDJ4hsBcmeDytHmmu1wekbPK63AhA?e=LBSlUu) This video clip contains real-time demos for a few command line options.
3. [Man pages real-time demo](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EbvesSCBx-tNlAbYU4KmAUUBSksb_UhMsLsDFHdIAjcZLA?e=BH8cUO) This video clip provides a real-time demo of man page usage.

It is recommended that you references these videos in order then use this guide as an additional "follow along guide" or future reference.


## What are command line options?

Nearly all terminal commands accept options. Options tell the command to do something "extra". 

Consider the command `ls`. We know from this workshop that `ls` lists the contents of a directory. 

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_1/image-1.png?raw=true">

Suppose we want to see additional information about the items in a directory. We can see additional information by specifying the `-l` option. This tells `ls` to list the items in "long" format.

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


## Contact
If you have questions about the information in this workshop document, please contact:

Chris Wilson
Bioinformatics Software Engineer
MDI Biological Laboratory
cwilson[at]mdibl.org