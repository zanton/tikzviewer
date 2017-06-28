#!/usr/bin/env bash

if [[ "$TARGET" == "article" ]]; then
    PREVIEW_TEMPLATE=${HOME}/.config/tikzviewer/preview_template.tex
elif [[ "$TARGET" == "handout" ]]; then
    PREVIEW_TEMPLATE=${HOME}/.config/tikzviewer/preview_template_beamer_handout.tex
elif [[ "$TARGET" == "beamer" ]]; then
    PREVIEW_TEMPLATE=${HOME}/.config/tikzviewer/preview_template_beamer.tex
else
    PREVIEW_TEMPLATE=${HOME}/.config/tikzviewer/preview_template.tex
fi

TEMP_DIR=/tmp/tikzviewer
TEMP_TEX=$TEMP_DIR/tikzviewer_render.tex
TEMP_PDF=$TEMP_DIR/tikzviewer_render.pdf
TARGET_PDF=${1%.*}.pdf

while inotifywait -e close_write $1; do
    echo "event triggered"
    mkdir -p $TEMP_DIR
    sed s,_FILENAME_,$1, $PREVIEW_TEMPLATE > $TEMP_TEX
    pdflatex -halt-on-error -interaction=nonstopmode -output-directory=${TEMP_DIR} $TEMP_TEX 
    mv -v $TEMP_PDF $TARGET_PDF
    echo $?
done
