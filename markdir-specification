# markdir specification v0.1

## User content

Pick a directory. It is your root directory. You may wish to name it with the .mdir extension. Future versions of this spec may ignore directories without a .mdir extension.

In the root directory and every subdirectory, the following rules apply:

### .mdir files use the markdown format (despite the nonstandard extension)

### .mdir files do not contain h1 or h2 headers. 

### .mdir files do not contain the file name as a header

Right:

```
<contents of Words.mdir>
Here's some content
It's part of a .mdir file

- and a single bullet point
```

Wrong:

```
<contents of Words.mdir>
### Words

Here's some content
It's part of a .mdir file

- and a single bullet point
```

### Recommended: .mdir files are descriptively named

Recommended:

```
<contents of Colors.mdir>
- blue
- red
- orange
```

Not Recommended:

```
<contents of Shapes.mdir>
- blue
- red
- orange
```

## Generated content

### .mdir file names become h2 headers when processed into .md files

This:

```
<contents of Colors.mdir>
- blue
- red
- orange
```

Will become this:

```
## Colors

- blue
- red
- orange
```

Rules for when .mdir files are processed, below.

### There is a README.md file in every directory 

**It begins with an h1 header** listing the name of the **directory in which it is located,** omitting a .mdir extension, if it exists. The header is followed by two newlines.

```
<in Folder.mdir>
# Folder¶
¶
_<-- next line to be inserted will go here_
```

**.mdir files are processed and appended to README.md

### There is a corresponding .md file for each .mdir file

Each .mdir file is processed and appended to a file in the same directory, with the same basename but the .md extension instead of .mdir.

```
<contents of Colors.mdir>
- blue
- red
- orange
```

```
<contents of Colors.md>
## Colors

- blue
- red
- orange
```

Every .md file in a subdirectory is then appended to the .md file with the same name in the parent directory.

```
<contents of Greyscale/Colors.md>
- black
- white
- grey
```

```
<contents of Colors.md>
- blue
- red
- orange
```

**This section is incomplete.**
