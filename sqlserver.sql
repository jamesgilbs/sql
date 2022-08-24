SELECT	
		spid,
		hostname,
		loginame,
		status,
		blocked,
		cmd,
		PROGRAM_NAME,
		cpu,
		memusage,
		login_time,
		net_library,
		net_address

FROM MASTER.SYS.SYSPROCESSES
WHERE status IN('RUNNABLE', 'SUSPENDED')
ORDER BY blocked DESC, status, spid