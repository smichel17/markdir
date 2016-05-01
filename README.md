# README

## About

Markdir is an easy to use, flexible, and comprehensive standard for documentation.

All content appears in files _and folders_ with the .mdir extension. Mdir files are written in the markdown flavor of your choice (the Markdir author recommands pandoc).

Mdir files aren't intended for viewing. Instead, they are processed into .md files which are **views** of the information present. Similarly, these views are not the source of information: the first step in processing is to delete all existing .md files.

These views are generated from the contents of mdir files **and** _the names and structure of mdir files and folders._

The Markdir specification requires one view. markdir.sh implements the "bubble" view.

Cool thing: If you're documenting software or other digital materials (except markdown!), you can put your documentation in the same .mdir folders as the thing you're documenting. Except if you're documenting something written in markdown. In that case, make sure you exclude folders containing markdown by not giving them the .mdir extension.

This documentation is itself written in Markdir.

## FAQ

### Why does Markdir exist?

The author was part of an [organization](https://snowdrift.coop) running with [Holacracy](https://holacracy.org). Markdir allows them to easily maintain their governance structure documentation without using HolacracyONE(R)'s proprietary SaSS management tool.

### Why markdown?

Markdown is the [plain text](https://github.com/ginatrapani/todo.txt-cli/wiki/The-Todo.txt-Format#why-plain-text) of the web.

### Goals:

- Be easily readable
  - Each directory's README.md contains all the information in that directory. Most git hosting platforms' web interfaces display README.md in the directory you're viewing, for easy access.
- Be easily searchable
  - Markdown is plain text, enabling simple file contents searches.
  - Manual search is also a priority. The Bubble view ensures that each directory contains all the information in all of its subdirectories, organized by subject.
- One update per change
  - You shouldn't need to update your documentation in three different places each time you want to make a change. One .mdir file, one update, multiple views.

## Reference Implementation

### markdir.sh

markdir.sh implements both the Markdir and Bubble views. It also implements a -f option which will process folders without the .mdir extension, so you can use pretty-looking folders. This does break the standard, but is acceptable if your documentation lives together and does not share a directory with other files.

## Specification

- Folders must end with the .mdir extension
- .mdir files are written in markdown format, despite the nonstandard extension
- .mdir files may not contain h1 or h2 level headers (# and ##)
- Each folder contains a `README.md` file
- The first line of `README.md` must be an h1 header with the name of the directory where `README.md` is stored (sans .mdir extension). It is followed by an empty line (two newlines). Example: 

```
<in Squares.mdir>
# Squares

<---- next line to be inserted will go here>
```

- Following the empty line is the concatenated contents of all .mdir files in the directory, each preceded by h2 headers with the respective file names. Each h2 header is followed by a single empty line, and each content section is followed by another empty line. Example:

```
<contents of Chroma.mdir/Colors.mdir>
- blue
- red
- orange
```

Will become this:

```
<contents of Chroma.mdir/README.md>
## Colors

- blue
- red
- orange

```

### Bubble View

- For every .mdir file, there is a .md file with the same name. Its first line is an h2 header with the _directory_ name, followed by a single empty line.

```
<contents of Chroma.mdir/Colors.mdir>
- blue
- red
- orange
```

```
<contents of Chroma.mdir/Colors.md>
## Chroma

- blue
- red
- orange

```

- All .md files in child directories (subdirectories, but only going down one level) are appended to a .md file with the same name in the parent directory
  - Including README.md

```
<contents of Squares.mdir/Chroma.mdir/Colors.md>
## Chroma

- blue
- red
- orange

```

```
<contents of Squares.mdir/Greyscale.mdir/Colors.md>
## Greyscale

- black
- white
- grey

```

```
<contents of Squares.mdir/Colors.md>
# Squares

## Chroma

- blue
- red
- orange

## Greyscale

- black
- white
- grey

```
