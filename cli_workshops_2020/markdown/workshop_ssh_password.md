# Workshop 2: Secure Shell (SSH) with Username and Password

## Workshop objectives

* Gain an understanding of connecting to remote machines via the terminal with `ssh`.
* Gain an understanding of different methods of connection using `ssh`.
* Understand the basics of a remote session.

## What is Secure Shell (SSH)?

ssh is a protocol for connecting to a "remote" computer using the terminal. This allows you to access and interact with the remote machine without leaving your laptop or desktop computer. 

SSH is very powerful because the only information being transmitted across the internet is text. This makes the sessions very light weight and fast.

**_Please note_**, when you connect to a Linux computer via SSH, the primary interface for interacting with that computer is the terminal. Therefore, it is recommended that you familiarize yourself with navigating the Linux file system using the terminal before initiating an SSH session.

If you need to familiarize yourself with basic file system navigation using the terminal, please reference the following document.

**[Introduction to the terminal, navigating the Linux file system](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_intro.md)**

## Types of SSH authentication methods
When you log into a remote computer, the computer needs to verify that you are allowed to access it. To authenticate you will either need:

1. A valid username and password combination,
2. A valid username and ssh-key combination.

**_In the remainder of this tutorial, we will assume you have a valid username and password combination. To learn about ssh sessions with a username and authentication keys, please refer to following document._**

[SSH sessions with a valid username and authentication key combination](#)

## Launching an SSH Session

Launching an ssh session is accomplished with the `ssh` command. `ssh` accepts the destination of the remote machine 
as an argument.

The destination argument must include your username on the remote machine and the url or IPAddress of the machine.

For example, if your username is `demo-user` and you want to ssh into a remote machine with URL `someurl.com`, the ssh command would look like the following. 

```
ssh demo-user@someurl.com
```

If the machine does not have an associated url, then you will need to use the machine's IPAddress instead. In this case, the ssh command would look like the following.

```
ssh demo-user@123.456.7.890
```

where 123.456.7.890 would be replaced with the **actual IPAddress** of the machine you are trying to access.

If the ssh connection is successful, you will see a password prompt similar to the following.

```
demo-user@123.456.7.890's password:
```

*Example: Logging into a virtual machine on Amazon Web Services (AWS)*
<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_2/ssh_password_1.png">

Type your password and press `enter`. If authentication is successful, you should be presented with a prompt that resembles a typical Linux terminal session.

**_Please note_**, the terminal will not display your password as you type it so you will need to make sure you are typing it correctly.


*Example: A remote terminal session on an AWS machine*
<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_2/ssh_password_2.png">


Similar to a local terminal session, the command prompt in an ssh session shows the name of the user and the name of the machine.

From here, you can navigate to the appropriate directory, execute programs, etc. much as if you were working on your local machine.

## Lifespan of an SSH Session

ssh sessions are ephemeral and will typically last as long as the user is interacting with the remote session.

An ssh session will end under several circumstances:

1. The user types the `exit` command and hits `enter`.
2. The session becomes inactive (e.g., you switch to a new task and stop interacting with the terminal session).
3. The connection is lost (e.g., you lose internet connection, system crash, etc.).

Unfortunately, if you are running a program when your session ends, the program will terminate and in general, all work that is in process will be lost.

## Changing your password
When logging into a remote computer for the first time, it is a good idea to change your password. In many cases, your user will be assigned a default password that is not very secure. In general, computers with remote access enabled are prime targets for nefarious agents so having a string password is 
essential.

To change your password on a Linux computer type the command `passwd` into the terminal and hit `enter`. You will see a prompt similar to the following.

```
Changing password for YOURUSERNAME.
(current) UNIX password:
```

Type your new password and hit `enter`. You will see an immediate follow-up prompt which will ask you to verify your password. Retype your password and hit `enter`. 

If the passwords match, the command will finish executing and your password will be updated. If the passwords do not match, the command will abort with an error message and you will need to start the process over. In this case, your current password **_will not be changed_**.

### Use strong passwords

Weak passwords can have disasterous consequences, especially for users of remote computers. Nefarious actors are always trying to gain access to these types of resources. While you might think there is nothing "important" on a remote computer, an attacker might simply want to use it as a resource to carry out attacks on other computers or set up a relay or communication point for illicit activity.

Strong passwords (coupled with other measures) can prevent unauthorized access.
As a general rule, I recommend a password with the following form:

```
%$FenceTableStoveShirt56
```

The general form is two special characters followed by four arbitrary nouns with varying capitalization followed by two numbers.

Different password strength testers will give different results but in general, a password with this form will take a typical desktop computer well over 50 million years to crack using brute force methods. In other words, it's really strong!

## Contact
If you have questions about the information in this workshop document, please contact:

```
Chris Wilson
Bioinformatics Software Engineer
MDI Biological Laboratory
cwilson[at]mdibl.org
```