for src in src/*.glyphs
do
  fontmake -g $src -o ttf --output-dir output/
done

for font in output/*.ttf
do
  gftools fix-nonhinting $font $font
done

# Cleanup gftools mess:
rm output/*-backup-fonttools-prep-gasp.ttf

export OPTIONS="--no-progress"
export OPTIONS="$OPTIONS --exclude-checkid /check/ftxvalidator" # We lack this on Travis.
export OPTIONS="$OPTIONS --exclude-checkid /check/metadata" # Delete this after creating a METADATA.pb file
export OPTIONS="$OPTIONS --exclude-checkid /check/description" # & this after a DESCRIPTION.en_us.html file,
export OPTIONS="$OPTIONS --exclude-checkid /check/varfont" # & this when making a variable font.
export OPTIONS="$OPTIONS --loglevel INFO"
fontbakery check-googlefonts $OPTIONS output/*.ttf
