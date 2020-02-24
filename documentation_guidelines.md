## Introduction
These are the meta-principles by which all following Biocore projects/documentation should abide by.
In an effort to reduce redundancy, clutter, and general confusion, we have decided to transition to Github as a centralized source for documentation, project management, issue tracking, and task modularization.  This document serves as a how-to in helping describe what things go where, what is expected of the author(s), and general best practices.  To begin, lets lay out the components of a Github repository that we (currently) use.

## Code
This section is the meat-and-potatoes of our repo(s), and holds all physical code related to said repo.  This covers any functional programs, CWL wrapper scripts, configuration files, and pre-processing code. The following are to be included in any repository:
* #### License
We have not yet decided on the specific License to adhere to, probably GPL2, but one should exist nontheless.
* #### Readme.txt
While repository specific details should exist in the Wiki, there should also be a ReadMe file that contains instructions on how to use the code, any dependencies that may be required, and a short blurb as to what it is.
* #### Docker File
This won't be required for everything, but any program or cwl script we write / work with *should* have a Docker File associated with it.  This will greatly increase it's portability, help users avoid dependency hell, and improve stability.
* #### Tests Directory + Files
When applicable, there should be a separate directory that holds test files.  This will allow for quick trial runs of the code, as well as provide a good bed for test-cases to be developed.  We (and users) should not have to hunt down example data to run through our program, it should already exist in our repo (albeit in a very cut-down format).
## Issues
Next up is the Issues tab.  This is a section that has been previously unused, but will be leveraged to track changes within our repositories and the Biocore structure as a whole.  For example, if there is a directory that breaks our established naming conventions, an Issue will be opened to reflect that fact.  This ensures that 1) the problem will be persistently visible until resolved, and 2) that steps taken to fix will be documented.  The latter will of course depend upon the diligence of the maintainers, but it is a critical component that cannot be ignored.
* ### Contents
When opening an Issue, the initial comment should be adequately detailed, with information on how to replicate the problem, if necessary.  Below are ways to interact with an Issue, and can be found to the right of the comment stream.
* #### Assignees
Participants who are working on the Issue.  You have the capability to add yourself, or others (if you are the author iirc).  As an Assignee, it is expected that you will thoroughly document progress made, questions had, and other such things through the comment stream.  This allows for quick collaboration, reproducibility, and saves time.
* #### Labels
Labels allow for further classification of the Issue raised.  They range from *bug*, to *question*, to marking for *help wanted*.  Very useful, and should be included with every Issue to further clarify and keep tasks organized.
* #### Projects
The project that the Issue has been raised under.  Every Issue should have a specific project associated with it.

 
