rm output/ -rf

for src in src/*.glyphs
do
  fontmake -g $src -o ttf -i --output-dir output/
done

for font in output/*.ttf
do
  gftools fix-nonhinting $font $font
  gftools fix-dsig $font --autofix
done

# Cleanup gftools mess:
rm output/*-backup-fonttools-prep-gasp.ttf

cp DESCRIPTION.*.html METADATA.pb OFL.txt output

export OPTIONS="--no-progress"
export OPTIONS="$OPTIONS --exclude-checkid /check/ftxvalidator" # We lack this on Travis.
export OPTIONS="$OPTIONS --exclude-checkid /check/varfont" # Comment this out when making a variable font.
export OPTIONS="$OPTIONS --loglevel INFO --ghmarkdown Tomorrow-fontbakery.md"
fontbakery check-googlefonts $OPTIONS output/*.ttf
