all:dependencies block matrix run_time run_cache test_valgrind

dependencies:
	sudo apt-get update
	sudo apt-get install linux-tools-common linux-tools-generic
	sudo apt-get install valgrind
	sudo sysctl kernel.perf_event_paranoid=-1

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

run_cache:
	echo Cache segment 
	echo Cache analysis for matrix ijk
	perf stat -t -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/matrix\ ijk
	echo Cache analysis for matrix ikj
	perf stat -t -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/matrix\ ikj
	echo Cache analysis for block ijk
	perf stat -t -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/block\ ijk
	echo Cache analysis for block ikj
	perf stat -t -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/block\ ikj
	echo Cache analysis for parallel
	perf stat -t -v -r 10 -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/parallel
	echo [+] end of Cache segment

test_valgrind:
	echo [+] Testing valgrind
	valgrind -v --time-stamp=yes ./test/parallel
	valgrind --tool=cachegrind --cache-sim=yes --branch-sim=yes --show-percs --I1=131072,4,512 --D1=131072,4,512 ./test/parallel
	echo [+] end of valgrind

clean:
	echo [+] Cleaning Directory
	rm -r -f test/*
	echo [+] Clean Complete