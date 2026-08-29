TECTONIC ?= tectonic
OUTDIR ?= build

.PHONY: all clean

all:
	mkdir -p $(OUTDIR)
	$(TECTONIC) --keep-logs --keep-intermediates --outdir $(OUTDIR) main.tex > $(OUTDIR)/tectonic.log 2>&1

clean:
	rm -rf $(OUTDIR)
