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
