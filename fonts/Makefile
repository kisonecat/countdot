all: sffamily-modern.png computer-modern.png

%.pdf: %.tex glyphs.tex
	xelatex $<
	pdfcrop --margins "0 -0.05 0 -0.05" $@ cropped.pdf
	mv -f cropped.pdf $@

%.png: %.pdf
	mutool draw -r 2160  -c rgb -o $@ $<

sffamily-modern.png: sffamily-modern-glyphs.png sffamily-modern-cutoffs.png
	convert $(word 1,$^) -colorspace Gray +clone -alpha off -compose Copy_Opacity -composite -negate glyphs.png
	convert -colorspace Gray $(word 2,$^) -black-threshold 99% -white-threshold 99% -fuzz 0% -fill transparent -opaque white -fuzz 0% -fill red -opaque black cutoffs.png
	convert -composite glyphs.png cutoffs.png -gravity center $@

computer-modern.png: computer-modern-glyphs.png computer-modern-cutoffs.png
	convert $(word 1,$^) -colorspace Gray +clone -alpha off -compose Copy_Opacity -composite -negate glyphs.png
	convert -colorspace Gray $(word 2,$^) -black-threshold 99% -white-threshold 99% -fuzz 0% -fill transparent -opaque white -fuzz 0% -fill red -opaque black cutoffs.png
	convert -composite glyphs.png cutoffs.png -gravity center $@

clean:
	rm -f *.png *.pdf
	rm -f *.aux *.log
