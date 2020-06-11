# Workshop 2: Secure Shell (SSH) SSL Key Generation

## Workshop objectives

* Gain a basic understanding of SSH keys and how to generate them.

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

```
Your identification has been saved in /Users/YOURUSERNAME/.ssh/id_rsa.
Your public key has been saved in /Users/YOURUSERNAME/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:xcI06cdLOcNNCED+LhnzqJyyKAsHQJLF/hvytkniA4U YOURUSERNAME@yourmachinename
The key's randomart image is:
+---[RSA 3072]----+
|.=.  .o.+o .     |
|+ .  . o.o. .    |
|.o    ..ooo+     |
|E o    ..oO .    |
|.. .  o So +     |
|... o  B  .      |
|..oo.o+ o        |
|o+o+++ .         |
|+.o=*.           |
+----[SHA256]-----+
```

At this point, you should now have two files namely, _id_rsa_ and _id_rsa.pub_ in `/Users/YOURUSERNAME/.ssh/`.

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
