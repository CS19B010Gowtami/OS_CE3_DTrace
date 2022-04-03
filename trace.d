#!/usr/sbin/dtrace -s

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
