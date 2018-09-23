---
title: "GIT External Diff / Merge tools"
tags: [git]
image: git.png
---

An overview of the different external git diff and merge tools, and how to configure them.

<!--more-->

Occording to [the GIT book](http://git-scm.com/documentation), GIT supports these external Diff / Merge tools:

| GIT tool name | Name (and link to website) | License |
|----------|----------------------------------------------|------------|
| [araxis] | [Araxis Merge](http://www.araxis.com/merge/) | Commercial |
| [bc3] | [Beyond Compare 3](http://www.scootersoftware.com/moreinfo.php) | Commercial |
| [diffuse] | [Diffuse](http://diffuse.sourceforge.net/) | Open source |
| [ecmerge] | [ECMerge](http://www.elliecomputing.com/products/merge_overview.asp) | Commercial |
| [emerge] | [Emerge (Emacs)](http://www.nongnu.org/emacsdoc-fr/manuel/emerge.html) | Open source |
| [gvimdiff] | gvimdiff | Open source |
| [kdiff3] | [KDiff3](http://kdiff3.sourceforge.net/) | Open source |
| [meld] | [Meld merge](http://meldmerge.org/) | Open source |
| [opendiff] | [opendiff](https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man1/opendiff.1.html) | (OS X Developer Tools) |
| [p4merge] | [P4Merge](http://www.perforce.com/product/components/perforce_visual_merge_and_diff_tools) | Commercial |
| [tkdiff] | [TkDiff](http://tkdiff.sourceforge.net/) | Open source |
| [tortoisemerge] | [TortoiseMerge](http://tortoisesvn.tigris.org/TortoiseMerge.html) | Open source |
| [vimdiff] | vimdiff | Open source |
| [xxdiff] | [xxdiff](http://furius.ca/xxdiff/) | Open source |
| [kompare] | [Kompare](http://www.caffeinated.me.uk/kompare/) | Open source |

Remarks:

* TortoiseMerge: only merge tool
* Kompare: only diff tool

You can choose your prefered diff / merge tool by executing this command (Windows or Linux), in this case for my favorite kdiff3.

```bash
git config --global diff.tool kdiff3
git config --global merge.tool kdiff3
```

The external diff is started using this command:

```bash
git difftool
```

You will probably get the error `The diff tool kdiff3 is not available as 'kdiff3'. External diff died, stopping at <filename>.`, 
because GIT doesn't find your tool.  This can be resolved by adding your tool to the environment PATH variable, or by telling 
GIT where to find your tool(s):

```bash
git config --global difftool.kdiff3.path "C:/Program Files (x86)/KDiff3/kdiff3.exe"
git config --global mergetool.kdiff3.path "C:/Program Files (x86)/KDiff3/kdiff3.exe"
```

Any configuration can be undone by executing:

```bash
git config --global <config item> --unset
```

e.g.

```bash
git config --global mergetool.kdiff3.path --unset
```
