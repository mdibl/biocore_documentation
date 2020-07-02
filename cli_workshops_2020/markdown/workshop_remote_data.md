# Workshop 3: Working with remote data.

## Workshop objectives

* Gain an understanding of moving data between computers 
* Gain an understanding of different methods of data transfer

## Supporting Video Tutorials
This document is supported by a series of videos that cover roughly the same content. The video references are listed below:

## Working with remote data

As mentioned in the second workshop series, SSH allows us to access and work with remote computers without the need to leave our local laptop or desktop computer. For a review of SSH please reference the following document.

[Secure Shell (SSH) with Username and Password](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_ssh_password.md)

When working with remote resources such as a virtual machine or a super computer, you will often need to transfer data between your local computer and those resources.

## Secure Copy (SCP)
Secure Copy or SCP, is a command for transferring data between a local and remote resource. The `scp` command is very similar to the `cp` command in that it accepts a source and a destination as an arguments. It also requires the `-r` option for copying folders. The main difference is that either the source or the destination will be a "remote location", depending on whether you are copying data to or from a particular resource.

### Copying a file **_to_** a remote resource (i.e. Pushing). 
When copying data to a remote resource, the `scp` command will have the following format.

```
scp source destination
```

If for example, we wanted to copy the file `test.txt` to an acme.com server, the command would look like 

```
scp test.txt cwilson@acme.com:~/
```

In the following screenshot, we demonstrate how `scp` can be used to copy the file `test.txt` to an AWS cloud computer.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_1.png">

In each of these examples, the source is the file `test.txt`. However, the destination argument in each consists of two components:

1. the ssh credentials for the remote resource of the form `username@some_url.com` if the computer has a url associated with it or `username@123.456.7.89` if the machine only has an IPAddress,
2. the location on the remote resource where the data should be placed.

The components of the destination are separated by a colon delimiter. 

In the previous example, we are telling `scp` to copy `test.txt` to the user's home directory. We are using the shortcut notation `~/` for `/home/cwilson`. 

If we `scp` to copy the file to a different location, the command might look like

```
scp test.txt cwilson@acme.com:~/test-files
```

In this case, we are telling the `scp` command to copy `test.txt` to the folder `test_files` which is under the user's home directory. 

Please note, the destination `~/test-files` will expand to `/home/cwilson/test-files`.

The following screenshot demonstrates how `scp` can be used to copy the file `test.txt` to a location other than the user's home directory.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_2.png">


### Copying a file **_from_** a remote resource (i.e., Pulling). 
When copying data from a remote resource, the `scp` command will have the following format.

```
scp source destination
```

In this case however, the source is now the location of the data on the remote resource and the destination is a location on the user's local machine.

For example, if we want to copy the file `test.txt` from the user's home directory on the server acme.com to the user's home directory on the local machine, the command would look like

```
scp cwilson@acme.com:~/test.txt ~/
```

The following screenshot demonstrates how we would copy a file from an AWS cloud machine to a local computer.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_3.png">

In each of these examples, we are telling `scp` to copy the file `test.txt` in cwilson's home directory on the remote resource to the user's home directory on the user's local machine.

If we want to copy the file to a location to a location other than the user's home directory, we need to include the location in the destination argument. For example, if we want to put `test.txt` in the folder `test-files` under the user's home directory, the command would look like

```
scp cwilson@acme.com:~/test.txt ~/test-files
```

The following screenshot demonstrates how we would copy a file from an AWS cloud machine to the directory `test-files` on the user's local computer.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_4.png">

### Copying a directory **_to_** a remote resource. 
`scp` can also copy the contents of a directory to a remote resource. This is achieved by providing the `-r` option to `scp`. The general format is as follows.

```
scp -r source destination
```

If for example, we want to copy the directory `test-files` to the acme.com server, the command would look like the following.

```
scp -r test-files cwilson@acme.com:~/
```

In this example, the source is the directory `test-files` and we are telling `scp` to copy this directory to the user's home directory on the remote resource.

The following screenshot demonstrates how we would copy a local directory to an AWS cloud machine.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_5.png">


### Copying a directory **_from_** a remote resource. 
`scp` can also copy a directory from a remote resource to a user's local machine. This is similar to copying a file from a remote resource in that the source is the directory on the remote resource and the destination is a path on your local machine.

For example, if we want to copy the directory `test-files` from a remote resource to the user's home directory on a local machine, the command would look like

```
scp -r cwilson@acme.com:~/test-files ~/
```

The following screenshot demonstrates how we would copy a directory on an AWS cloud machine to the user's home directory on a local machine.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_6.png">

## Limitations of `scp`

`scp` is a convenient tool for copying data too and from remote resources. The tool is however, subject to various limitations.

1. If your terminal session ends for any reason, `scp` exits. Only data that was completely copied up to that point will have been copied. Any data that was in the process of being copied will be lost.
2. If the terminal session ends and `scp` fails to copy all data completely, the process **must be started over**. You cannot pick up where you left off. This can be inconvenient especially when copying *many* files or *large* files.

So how do we get around *some* of these limitations? `rsync` to the rescue!

## Copying data with `rsync`

Similar to `scp`, `rsync` is a command-line tool for copying data between a remote resource and a local machine. Unlike `scp` however, `rsync` has the ability to pick up where it left off if copying ends prematurely. This makes it an ideal tool for copying data under most conditions.

In this tutorial, we will focus on what we believe are the most important options. For a complete list of options and examples of additional use cases,
please visit the following resources.

Invoking `rsync` is similar to that of `scp`. The general format for the command is as follows.

```
rsync source destination
```

With `rsync` the source and destination follow the same format as they do with `scp`.

For example, if we want to copy a file to the acme.com server using `rsync`, the command would look like

```
rsync test.txt cwilson@acme.com:~/
```

The following screenshot demonstrates how we would use `rsync` to copy a file to an AWS cloud machine.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_7.png">

### The archive option

`rsync` provides users with the **archive** option. The archive option combines the following options:

1. `-r` Recurse into directories
2. `-l` Copy symbolic links as symbolic links
3. `-p` Preserve permissions
4. `-t` Preserve modification times
5. `-g` Preserve the group
6. `-o` Preserve the owner
7. `-D` Preserve device specific and special files

Calling `rsync` with the archive option would look like 

```
rsync -a source destination
```

For example, if we want to copy a file to our acme server using the archive options, the command would look like

```
rsync -a test.txt cwilson@acme.com:~/
```

The following screenshot demonstrates how we would copy a file to an AWS cloud machine using `rsync` with the archive option.

G<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_7.png">

### Verbose and progress options
By default, `rsync` is fairly quiet. By that we mean it doesn't print a lot of output to the screen. In some cases, a user might want to see what files are being copied. You can tell `rsync` to print the files being copied by passing the `-v` or `--verbose` option.

For example, if we want to see the files being copied when we copy the directory `test-files` to our acme server, the command would look like

```
rsync -av test-files cwilson@acme.com:~/

or 

rsync -a --verbose test-files cwilson@acme.com:~/
```

The following screenshot shows sample output from the `rsync` command with the verbose option.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_8.png">

In addition to printing the files being copied, a user might want to see the progress of each file being copied. `rsync` will display the progress of all files being copied by supplying it with the `--progress` option.

For example, if we want to see the progress of each file being copied when we copy data to our acme.com server, the command would look like 

```
rsync -av --progress test-files cwilson@acme.com:~/
```

The following screenshot shows sample output from the `rsync` command with the progress option.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_9.png">

### Excluding files from copy

Sometimes we want to copy the contents of a directory but we want to exclude certain files. We can tell `rsync` to exclude these files with the `--exclude` option.

For example, if a directory contains a subdirectory named `dont_copy`, the
command to exclude this subdirectory from the copy would look like the
following

```
rsync -av --progress --exclude 'test-files/dont_copy' test-files cwilson@acme.com:~/
```

The following screenshot demonstrates how we would copy a file to an AWS cloud machine using `rsync` with the `--exclude` option.

If we want to exclude a specific file from an `rsync` copy, the command would look like the following

```
rsync -av --progress --exclude 'test-files/dont_copy_this_file.txt' test-files cwilson@acme.com:~/
```

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_3/workshop_image_10.png">

```
## Contact
If you have questions about the information in this workshop document, please contact:
```

Chris Wilson
Bioinformatics Software Engineer
MDI Biological Laboratory
cwilson[at]mdibl.org
```