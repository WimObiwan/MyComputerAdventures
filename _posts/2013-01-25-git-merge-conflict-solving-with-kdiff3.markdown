---
title: "GIT Merge conflict solving with kdiff3"
tags: [powershell, git]
image: /assets/2013-01-25-kdiff3.png
---

A simple example on how to solve Merge conflicts in GIT, using kdiff3.

<!--more-->

First we will create a test repository and a test file on which we will create a merge conflict later on.
(in this example, the commands are executed with PowerShell in Windows, but the GIT commands are exactly the same on any other shell or OS)

* Creation of a test repository

    {: .language-bash}
      cd \temp
      mkdir mergetest
      cd mergetest
      git init

* Creation of a test file

    {: .language-bash}
      'Original line' | Out-File file.txt
      
* Commit into repository

    {: .language-bash}
      git add file.txt
      git commit -m "Original checkin"
      
* Current repository state:
   (using the tool [GIT Extensions](http://code.google.com/p/gitextensions/))
   
   ![Screenshot](/assets/2013-01-25-git-merge-conflict-solving-with-kdiff3-1.png)
   
Now we will create a new branch A, and update the file.

* Create new branch

    {: .language-bash}
      git branch branch-A
      git checkout branch-A
      
* Update file

    {: .language-bash}
      'Branch A line' | Out-File file.txt
      
* Commit into repository

    {: .language-bash}
      git add file.txt
      git commit -m "Branch A change"
      
* Current repository state:

   ![Screenshot](/assets/2013-01-25-git-merge-conflict-solving-with-kdiff3-2.png)

Now we will create a new branch B, and update the file with a conflicting change.

* Create new branch, starting from the original master branch

    {: .language-bash}
      git checkout master
      git branch branch-B
      git checkout branch-B
      
* Update file

    {: .language-bash}
      'Branch B line' | Out-File file.txt
      
* Commit into repository

    {: .language-bash}
      git add file.txt
      git commit -m "Branch B change"
      
* Current repository state:

   ![Screenshot](/assets/2013-01-25-git-merge-conflict-solving-with-kdiff3-3.png)

All this was a preparation for what we will do now: merge the conflicting change of branch-B into branch-A.

* Select the target branch (in this case branch A)

    {: .language-bash}
      git checkout branch-A
      
* Merge the source branch (in this case branch B)

    {: .language-bash}
      git merge branch-B
      
* This results in a merge conflict:

      Auto-merging file.txt
      CONFLICT (content): Merge conflict in file.txt
      Automatic merge failed; fix conflicts and then commit the result.
      
* This conflict can be resolved by starting your mergetool

    {: .language-bash}
      git mergetool
      
* It gives you a message before it launches your mergetool (in my case [kdiff3](http://kdiff3.sourceforge.net/)):

    {: .language-bash}
      Merging:
      file.txt
      
      Normal merge conflict for 'file.txt':
        {local}: modified file
        {remote}: modified file
      Hit return to start merge resolution tool (kdiff3):
      
* You get a window containing 4 versions of the same file:
   * Top left: "***Base***".  This is the original version of the file, the last shared version between what became later branch-A and branch-B.
   * Top Middle: "***Local***". This is the target branch version of the file. It is called "Local", because this is the currently selected branch (using the last git checkout command).
   * Top Right: "***Remote***". This is the source branch version of the file. It is called "Remote", as apposed to "Local".
   * Bottom: "***Output***". This is the merged version of the file. After successful completion of the merge, this will become the new version of the target branch.
      In this pane, you can edit the text, or you can right click on any merged part and select what version(s) of the original file you want to include in the output.
      In this case, I decide to include the changes done in both branch-A and branch-B.
      
      ![Screenshot](/assets/2013-01-25-git-merge-conflict-solving-with-kdiff3-4.png)

      ![Screenshot](/assets/2013-01-25-git-merge-conflict-solving-with-kdiff3-5.png)
   * Close the kdiff3 application (saving the file), and commit the merge:
   
        {: .language-bash}
          git commit
    
      (accept the default commit message)
   * This brings us to the following repository state:
      ![Screenshot](/assets/2013-01-25-git-merge-conflict-solving-with-kdiff3-6.png)
   * We can check if the content of the test-file is what we need:
   
        {: .language-bash}
          Get-Content file.txt
          Branch A line
          Branch B line
          
