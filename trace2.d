syscall::open*:entry
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
	printf("%s %s",execname,copyinstr(arg0));
}
syscall:::entry
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
	@num[execname] = count();
}
syscall:::exit
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
	@num[probefunc] = count();
}
syscall:::entry
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
	@num[pid,execname] = count();
}

proc:::start
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
        self->start = timestamp;
}

proc:::exit
/
	(gid == $1 || gid == $2 || gid == $3 || uid = $4) && self->start
/
{
        @[execname] = quantize(timestamp - self->start);
        self->start = 0;
}
