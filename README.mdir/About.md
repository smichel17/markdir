# Notice: This documentation is out of date. It will be updated soon.

Markdir is an easy to use, flexible, and comprehensive standard for documentation.

All content appears in files _and folders_ with the .mdir extension. Mdir files are written in the markdown flavor of your choice (the Markdir author recommands pandoc).

Mdir files aren't intended for viewing. Instead, they are processed into .md files which are **views** of the information present. Similarly, these views are not the source of information: the first step in processing is to delete all existing .md files.

These views are generated from the contents of mdir files **and** _the names and structure of mdir files and folders._

The Markdir specification requires one view. markdir.sh implements the "bubble" view.

Cool thing: If you're documenting software or other digital materials (except markdown!), you can put your documentation in the same .mdir folders as the thing you're documenting. Except if you're documenting something written in markdown. In that case, make sure you exclude folders containing markdown by not giving them the .mdir extension.

This documentation is itself written in Markdir.
