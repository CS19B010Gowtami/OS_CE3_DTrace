syscall::open*:entry
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
	printf("execname : %s, filename: %s",execname,copyinstr(arg0));
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

proc:::exec-success 
/
	gid == $1 || gid == $2 || gid == $3 || uid = $4
/
{
	trace(curpsinfo->pr_psargs); 
}

proc:::exit
/
	(gid == $1 || gid == $2 || gid == $3 || uid = $4) && self->start
/
{
        @[execname] = timestamp;
}
