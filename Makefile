CFLAGS+=-O2 -g -Wall -Werror -Ifec -fPIC -DSHARED
LDFLAGS=
LIBS=-lm
CC=gcc

#all: dump978 uat2json uat2text uat2esnt extract_nexrad
all: libdump978.so

%.o: %.c *.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

libdump978.so: dump978.o fec.o fec/decode_rs_char.o fec/init_rs_char.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS) -shared

dump978: dump978.o fec.o fec/decode_rs_char.o fec/init_rs_char.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS)

uat2json: uat2json.o uat_decode.o reader.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS)

uat2text: uat2text.o uat_decode.o reader.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS)

uat2esnt: uat2esnt.o uat_decode.o reader.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS)

extract_nexrad: extract_nexrad.o uat_decode.o reader.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS)

fec_tests: fec_tests.o fec.o fec/decode_rs_char.o fec/init_rs_char.o
	$(CC) -g -o $@ $^ $(LDFLAGS) $(LIBS)

test: fec_tests
	./fec_tests

install: libdump978.so
	cp -f libdump978.so /usr/local/lib/

clean:
	rm -f *~ *.o fec/*.o dump978 uat2json uat2text uat2esnt fec_tests libdump978.so extract_nexrad
