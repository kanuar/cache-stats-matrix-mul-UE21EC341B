all:dependencies block matrix run_time run_cache

dependencies:
	apt-get install linux-tools-common linux-tools-generic

block:
	echo [+] Making block
	gcc -w ca_proj\ block\ ijk.c -o ../test/block\ ijk
	gcc -w ca_proj\ block\ ikj.c -o ../test/block\ ikj
	echo [+] Making block Complete

matrix:
	echo [+] Making matrix
	cc -w ca_proj\ matrix\ ijk.c -o ../test/matrix\ ijk
	gcc -w ca_proj\ matrix\ ikj.c -o ../test/matrix\ ikj
	echo [+] Making matrix Complete

run_time:
	echo Timing segment 
	echo Timing matrix ijk
	for counter in {1..20}; do time ./test/matrix\ ijk; done
	echo Timing matrix ikj
	for counter in {1..20}; do time ./test/matrix\ ikj; done
	echo Timing block ijk	
	for counter in {1..20}; do time ./test/block\ ijk; done
	echo Timing block ikj
	for counter in {1..20}; do time ./test/block\ ikj; done
	echo [+] end of Timing segment

run_cache:
	echo Cache segment 
	echo Cache analysis for matrix ijk
	perf stat -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/matrix\ ijk
	echo Cache analysis for matrix ikj
	perf stat -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/matrix\ ikj
	echo Cache analysis for block ijk
	perf stat -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/block\ ijk
	echo Cache analysis for block ikj
	perf stat -e branches,branch-misses,cache-misses,cache-references,cycles,instructions,cs,faults,user_time,L1-dcache-loads,L1-dcache-load-misses,L1-icache-loads,L1-icache-load-misses,dTLB-loads,dTLB-load-misses,iTLB-loads,iTLB-load-misses,branch-loads,branch-load-misses ./test/block\ ikj
	echo [+] end of Cache segment

clean:
	echo [+] Cleaning Directory
	rm -r -f test/*
	echo [+] Clean Complete