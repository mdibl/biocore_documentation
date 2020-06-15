# Workshop 2: Secure Shell (SSH) SSL Key Generation

## Workshop objectives

* Gain a basic understanding of SSH keys and how to generate them.

## Supporting Video Tutorials
This document is supported by a series of videos that cover roughly the same content. The video references are described below:

1. [Introduction to SSH keys](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EbSAY2MxMKxFnoy6eFpJC20Bgi6nFJOjweZ8lO923vtm6Q?e=MUhGyH) This video introduces SSH keys and how to generate them.
2. [SSH keys a real-time demo](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/Ec1zURkcxipHhb7hogmQX_EBJu08YZ08T1-xuLGoWqBtkw?e=pBILey) This video clip includes a real-time demo of authentication using ssh keys.


## What are SSH keys?

SSH is a communication protocol for connecting to a remote computer. Before a connection can be established, the protocol must verifiy the user with a combination of either:

1. A valid username and password combination.
2. A valide username and ssh keypair combination.

SSH keys provide a more secure mechanism for authentication. Unlike passwords which can eventually be cracked using "brute force" methods, ssh keys are almost impossible to decipher using brute force alone. But that is a topic for another time :-).

## Generating SSH keys on a Windows machine

If you are using a Windows computer (with Windows 10), please follow this comprehensive tutorial. 

[How to generate an SSH keypair in Windows 10](https://www.onmsft.com/how-to/how-to-generate-an-ssh-key-in-windows-10)

After following the steps in the tutorial, you should have an ssh keypair consisting of two files namely, _id_rsa_ and _id_rsa.pub_.

## Generating SSH keys on a Mac

1. Open the terminal application.
2. Once you are in the terminal, type `ssh-keygen`. You should see a prompt similar to the following.
```
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/YOURUSERNAM/.ssh/id_rsa):
```

The path `/Users/YOURUSERNAME/.ssh/id_rsa` is the default file for storing the key pair. It is recommended you use this file.

3. Hit `enter` after the prompt.
4. ssh-keygen will now prompt you for a passphrase. Hit `enter` for an empty passphrase, then hit `enter` again to confirm the empty passphrase. You should then see output similar to the following.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_2/ssh_keys_1.png">

At this point, you should now have two files namely, _id_rsa_ and _id_rsa.pub_ in `/Users/YOURUSERNAME/.ssh/`.

<img src="https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/images/images_workshop_2/ssh_keys_2.png">

## Next steps

SSH keys are powerful tools for authentication. Please keep id_rsa protected as it is your "private" key. Do not share it with anybody! id_rsa.pub is your public key. It can be used with remote resources such as remote computers and online services such as GitHub.

## Contact
If you have questions about the information in this workshop document, please contact:

```
Chris Wilson
Bioinformatics Software Engineer
MDI Biological Laboratory
cwilson[at]mdibl.org
```
