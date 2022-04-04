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
