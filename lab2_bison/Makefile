СС = gcc
CFLAGS = -g -std=gnu11

LEX_FILE = src/scan
LEX_FILE_YY = src/util/scan

BISON_PARSER = src/parser
BISON_PARSER_TAB = src/util/parser.tab

TMP_DIR = tmp
UTIL_DIR = src/util

BIN_DIR  = bin
BIN_NAME = a

TEST = test.sh

all: BIN_DIR := $(BIN_DIR)/release
all: build

debug: BIN_DIR := $(BIN_DIR)/debug
debug: build

test : BIN_DIR  := $(BIN_DIR)/debug
test: build
	./$(TEST) $(BIN_DIR)/$(BIN_NAME).out

build:  
	mkdir -p $(BIN_DIR)
	mkdir -p $(UTIL_DIR)
	flex -o $(LEX_FILE_YY).c $(LEX_FILE).l
	bison -d $(BISON_PARSER).y -o $(BISON_PARSER_TAB).c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$(BIN_NAME).out $(BISON_PARSER_TAB).c $(LEX_FILE_YY).c src/main.c

clean:
	rm -rfv $(BIN_DIR) $(TMP_DIR) $(UTIL_DIR)
