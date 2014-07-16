all:
	-@ echo "Building slurmbf_helper"
	gcc -c -DSTUBL_TMP_DIR='"/tmp"' *.c
	gcc -o slurmbf_helper *.o
	mv slurmbf_helper ../../bin

clean:
	rm -f *.o

