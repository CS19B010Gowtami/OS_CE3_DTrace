syscall:::entry
{
	trace(execname);
}
proc:::exec-success 
/
	uid == $uid
/
{
	trace(curpsinfo->pr_psargs); 
}
proc:::start
{
        self->start = timestamp;
}
proc:::exit
/self->start/
{
        @[execname] = quantize(timestamp - self->start);
        self->start = 0;
}

proc:::signal-send
{
        @[execname, stringof(args[1]->pr_fname), args[2]] = count();
}

syscall::open*:entry
{
	printf("%s %s",execname,copyinstr(arg0));
}
syscall:::entry
{
	@num[execname] = count();
}
syscall:::exit
{
	@num[probefunc] = count();
}
syscall:::entry
{
	@num[pid,execname] = count();
}
sysinfo:::readch
{
	@bytes[execname] = sum(arg0);
}
sysinfo:::writech
{
	@bytes[execname] = sum(arg0);
}
sysinfo:::readch
{
	@dist[execname] = quantize(arg0);
}
sysinfo:::writech
{
	@dist[execname] = quantize(arg0);
}
