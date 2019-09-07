APPNAME=my-app
SOURCEDIR=.
LDFLAGS=
LDLIBS=
SOURCES=$(shell find $(SOURCEDIR) -name "*.c" | sed "s|^\./||")
CFLAGS+=-MMD
OUT=$(addprefix $(OUTDIR)/,$(APPNAME))
OBJECTS=$(addprefix $(OBJDIR)/,$(SOURCES:%=%.o))

ifndef config
	config=debug
endif

ifeq ($(config),debug)
	CFLAGS+=-g
	OBJDIR=debug
	OUTDIR=debug/bin
else
	CFLAGS+=-O3 -DNDEBUG
	OBJDIR=release
	OUTDIR=release/bin
endif

all: $(OUT)

$(OUT): $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $^ -o $(OUT) $(LDFLAGS) $(LDLIBS)

$(OBJDIR)/%.c.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJECTS) $(APPNAME)

<<<<<<< HEAD
run: $(OUT)
	@./$(OUT)

.PHONY: all clean run
=======
.PHONY: all clean 
>>>>>>> ad085b5e7f0908465a2e76a4ff399b794eb31fc9

-include $(OBJECTS:%.o=%.d)
