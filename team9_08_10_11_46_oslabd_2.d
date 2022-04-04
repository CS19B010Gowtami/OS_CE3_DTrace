
syscall:::entry
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	trace(execName);
	trace(arg0);
	@num[execname] = count();
	@num[(pid,execname)] = count();
}

syscall::open*:entry
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	/*printf("%s %s",execname,copyinstr(arg0));*/
	trace("execName is : ");
	trace(execName);
	trace("Arg0 is : ");
	trace(arg0);
}


syscall:::return
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
	trace("Returning From Syscall");
	trace(execname);
	trace(arg0);
	@num[probefunc] = count();
}


proc:::exit
/
	gid == $1 || gid == $2 || gid == $3 || uid == $4
/
{
        @[execname] = quantize(timestamp);
}
