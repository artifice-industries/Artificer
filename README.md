<p align="center">
    <img src="artificer-icon.svg" width="256" align="middle" alt=“Artificer”/>
</p>

# Artificer
Communicate with [Stamp](https://stamp.xyz) from the command line.

## Introduction
Artificer is the command-line application for Stamp. It provides a number of helpful commands that can assist you while you take notes for your production. To view a list of all available Artificer commands, you may use the `list` command:

`artificer list`

Every command also includes a "help" screen which displays and describes the command's available arguments and options. To view a help screen, precede the name of the command with `help`:

`artificer stamp help`

## Installation

You can place the artificer executable anywhere you wish. If you put it in a directory that is part of your `PATH`, you can access it globally.

After downloading artificer and changing your path to the parent of the downloaded executable you can run this from terminal to move artificer to a directory that is in your path:

`mv artificer /usr/local/bin/artificer`

If you would like to install it only for yourself and no other user, avoiding root permissions, you can use `~/.local/bin` instead.

```
Note: If the above fails due to permissions, you may need to run it again with sudo.

Note: On some versions of macOS the /usr directory does not exist by default. 
If you receive the error "/usr/local/bin/artificer: No such file or directory" 
then you must create the directory manually before proceeding: mkdir -p /usr/local/bin.
```
now run `artificer` to begin interacting with a Stamp server.

## Workflow
Artificer allows you to interact with a stamp server on the command line.

1. Open terminal: Command (⌘) + Space -> "Terminal" -> Return (↵).
2. `artificer stamp` Return (↵).

   This will provide you with a list of stamp servers artificer can see on the network. If you already know the IP address of the stamp server you can skip this step. Otherwise, make a note of the IP address of the stamp server you wish to connect to.

3. `artificer craft <ip address>` Return (↵).
4. Notes will be sent to the connected stamp server after each Return (↵).

