syscall:::entry
{
	trace(execname);
}
proc:::exec-success 
/
	uid == 0
/
{
	trace(curpsinfo->pr_psargs); 
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
	@num[execname] = count();
}
syscall:::entry
{
	@num[probefunc] = count();
}
syscall:::exit
{
	@num[probefunc] = count();
}
syscall:::entry
{
	@num[pid,execname] = count();
}
syscall:::exit
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
