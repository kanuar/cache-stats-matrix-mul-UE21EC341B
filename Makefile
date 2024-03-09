all:dependencies block matrix run_time run_valgrind

dependencies:
	sudo apt-get update
	sudo apt-get install linux-tools-common linux-tools-generic
	sudo apt-get install valgrind
	sudo sysctl kernel.perf_event_paranoid=-1
	mkdir bin

block:
	echo [+] Making block
	gcc -w src/ca_proj\ block\ ijk.c -o test/block\ ijk
	gcc -w src/ca_proj\ block\ ikj.c -o test/block\ ikj
	echo [+] Making block Complete

matrix:
	echo [+] Making matrix
	cc -w src/ca_proj\ matrix\ ijk.c -o test/matrix\ ijk
	gcc -w src/ca_proj\ matrix\ ikj.c -o test/matrix\ ikj
	gcc -w -fopenmp src/parallel\ matrix.c -o test/parallel
	echo [+] Making matrix Complete

run_time:
	echo Timing segment 
	echo Timing matrix ijk
	times 20 ./test/matrix\ ijk
	echo Timing matrix ikj
	times 20 ./test/matrix\ ikj
	echo Timing block ijk	
	times 20 ./test/block\ ijk
	echo Timing block ikj
	times 20 ./test/block\ ikj
	echo Parallel timing 
	times 20 ./test/parallel
	echo [+] end of Timing segment

# run cache is to check for cache analysis works well on local machines 
# run_cache:
# 	echo Cache segment 
# 	echo Cache analysis for matrix ijk
# 	perf stat -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/matrix\ ijk
# 	echo Cache analysis for matrix ikj
# 	perf stat -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/matrix\ ikj
# 	echo Cache analysis for block ijk
# 	perf stat -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/block\ ijk
# 	echo Cache analysis for block ikj
# 	perf stat -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/block\ ikj
# 	echo Cache analysis for parallel
# 	perf stat -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/parallel
# 	echo [+] end of Cache segment

# check diff caches for example 131072,65536,32768
run_valgrind:
	echo [+] Testing valgrind
	echo [+] Testing parallel
	valgrind ./test/parallel
	valgrind --tool=cachegrind --cachegrind-out-file=bin/parallel.txt --cache-sim=yes --branch-sim=yes --I1=131072,4,512 --D1=131072,4,512 ./test/parallel
	valgrind --tool=cachegrind --cachegrind-out-file=bin/parallel.txt --cache-sim=yes --branch-sim=yes --I1=65536,4,512 --D1=65536,4,512 ./test/parallel
	valgrind --tool=cachegrind --cachegrind-out-file=bin/parallel.txt --cache-sim=yes --branch-sim=yes --I1=32768,4,512 --D1=32768,4,512 ./test/parallel
	echo [+] Testing parallel Complete
	echo [+] Testing matrix ijk
	valgrind ./test/matrix\ ijk
	valgrind --tool=cachegrind --cachegrind-out-file=bin/matrix_ijk.txt --cache-sim=yes --branch-sim=yes --I1=131072,4,512 --D1=131072,4,512 ./test/matrix\ ijk
	valgrind --tool=cachegrind --cachegrind-out-file=bin/matrix_ijk.txt --cache-sim=yes --branch-sim=yes --I1=65536,4,512 --D1=65536,4,512 ./test/matrix\ ijk
	valgrind --tool=cachegrind --cachegrind-out-file=bin/matrix_ijk.txt --cache-sim=yes --branch-sim=yes --I1=32768,4,512 --D1=32768,4,512 ./test/matrix\ ijk
	echo [+] Testing matrix ijk Complete
	echo [+] Testing matrix ikj
	valgrind ./test/matrix\ ikj
	valgrind --tool=cachegrind --cachegrind-out-file=bin/matrix_ikj.txt --cache-sim=yes --branch-sim=yes --I1=131072,4,512 --D1=131072,4,512 ./test/matrix\ ikj
	valgrind --tool=cachegrind --cachegrind-out-file=bin/matrix_ikj.txt --cache-sim=yes --branch-sim=yes --I1=65536,4,512 --D1=65536,4,512 ./test/matrix\ ikj
	valgrind --tool=cachegrind --cachegrind-out-file=bin/matrix_ikj.txt --cache-sim=yes --branch-sim=yes --I1=32768,4,512 --D1=32768,4,512 ./test/matrix\ ikj
	echo [+] Testing matrix ikj Complete
	echo [+] Testing block ijk
	valgrind ./test/block\ ijk
	valgrind --tool=cachegrind --cachegrind-out-file=bin/block_ijk.txt --cache-sim=yes --branch-sim=yes --I1=131072,4,512 --D1=131072,4,512 ./test/block\ ijk
	valgrind --tool=cachegrind --cachegrind-out-file=bin/block_ijk.txt --cache-sim=yes --branch-sim=yes --I1=65536,4,512 --D1=65536,4,512 ./test/block\ ijk
	valgrind --tool=cachegrind --cachegrind-out-file=bin/block_ijk.txt --cache-sim=yes --branch-sim=yes --I1=32768,4,512 --D1=32768,4,512 ./test/block\ ijk
	echo [+] Testing block ijk Complete
	echo [+] Testing block ikj
	valgrind ./test/block\ ikj
	valgrind --tool=cachegrind --cachegrind-out-file=bin/block_ikj.txt --cache-sim=yes --branch-sim=yes --I1=131072,4,512 --D1=131072,4,512 ./test/block\ ikj
	valgrind --tool=cachegrind --cachegrind-out-file=bin/block_ikj.txt --cache-sim=yes --branch-sim=yes --I1=65536,4,512 --D1=65536,4,512 ./test/block\ ikj
	valgrind --tool=cachegrind --cachegrind-out-file=bin/block_ikj.txt --cache-sim=yes --branch-sim=yes --I1=32768,4,512 --D1=32768,4,512 ./test/block\ ikj
	echo [+] Testing block ikj Complete
	echo [+] end of valgrind

clean:
	echo [+] Cleaning Directory
	rm -r -f test/*
	rm -r -f bin
	echo [+] Clean Complete