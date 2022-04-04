syscall::openat:entry
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	printf("%s %s",execname,copyinstr(arg0));
}

syscall:::entry
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	@num[execname] = count();
}

syscall:::return
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	@num[probefunc] = count();
}

syscall:::entry
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	@num[(pid,execname)] = count();
}

proc:::exit
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
        @[execname] = quantize(timestamp);
}
