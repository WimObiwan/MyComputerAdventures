---
title: "Copying symbolic links as regular files"
tags: [linux]
image: /assets/2015-07-12-copying-symbolic-links-1.png
---

By default, symbolic links (symlinks) are copyied as they are: *pointers*.  If you want to
copy files from a symlink based repository (like GIT Annex), you need to *follow* the
pointer.

<!--more-->

If you want to copy the destination file of the symlink (*follow* the symlink), you need to add the argument `-L`.

For example:

```bash
cp -L /mnt/data/archive/Documents /mnt/backup
```

This is necessary when copying files from a git-annex repository, which uses symlinks to 
an internal filestore.

A good explanation between hard and soft links on linux can be found [here](http://linuxg.net/the-linux-and-unix-links-the-symbolic-link-vs-the-hard-link/):
![Copy symbolic links](/assets/2015-07-12-copying-symbolic-links.png)
