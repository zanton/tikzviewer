# TiKZ Viewer

A small tool to visualize TikZ changes in WISIWYG manner and make working with it nicer.
Similar to kTikZ, but much lighter and does not force the choice of editor.

Editing TikZ diagrams with update-save-compile-re-open cycle can be extremely tedious.
TiKzviewer aims to simplify this by launching `inotifywait` loop on the selected file,
which launched the latex compiler on change.

# Installation

Run `make install` from the `tikzviewer` directory.
TiKzviewer assumes that `~/local/bin` directory is executable, and copies itself there.
Furthermore, three templates containing the include commands for the `tikz` package 
are copied to the `~/.config/tikzviewer` folder. The three templates are switched by
an environment variable "TARGET", they compile to different target documents:

 * TARGET=article: \documentclass{article}
 * TARGET=beamer: \documentclass{beamer}
 * TARGET=handout: \documentclass[handout]{beamer}
 
"TARGET=article" is the default settings when nothing is specified.

## Prerequisites

 * inotify-tools
 * TikZ
 * PDF viewer, smart enough to reload the file on change (Evince and Okular are both suitable)
 * Your Favorite Editor
 * beamer package for beamer and handout targets

# Usage

Write your favorite diagram in the `mydiagram.tex` file.
There is no need for the preamble; the file can just start with the `begin{tikzpicture}` statement.

While keeping the editor open, run `TARGET=article tikzviewer.sh mydiagram.tex` command.
You should see a message indicating a successful compilation and a blocking prompt.
That is it! TikZviewer was launched.

On each write to the `mydiagram.tex` file, the PDF `mydiagram.pdf` would be recompiled.
Open the file PDF in your favourite PDF viewer and observe the changes.

## Customization

To change a template, manually modify `~/.config/tikzviewer/preview_template.tex`.
