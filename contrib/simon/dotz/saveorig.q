/ save the original values in .z.p* so we can <revert> 
\d .dotz
if[not@[value;`SAVED.ORIG;0b]; / onetime save only
	SAVED.ORIG:1b;
	.usage.LEVEL:2; / 0 - nothing; 1 - errors only; 2 - all
	IPA:(enlist"I"$"127.0.0.1")!enlist`localhost;
	/ipa:{$[(`)~r:IPA x;IPA[x]:`$"."sv string"i"$0x0 vs x;r]}
	ipa:{$[`~r:IPA x;IPA[x]:$[`~r:.Q.host x;`$"."sv string"i"$0x0 vs x;r];r]}; 
	TXTW:50;
	.access.FILE:`:invalidaccess.log;
	.usage.FILE:`:usage.log;
	.clients.INTRUSIVE:0b;
	txt:{[zcmd;arg]$[TXTW>count arg:$[10=abs type arg;$[zcmd in`ph`pp;.h.uh arg;arg];-3!arg];arg;(15#arg),"..",(17-TXTW)#arg]};
	isdef:@[{not(::)~value x};;0b];
	pzlist:` sv'`.z,' `pw`po`pc`pg`ps`pi`ph`pp;
	.dotz.undef:pzlist where not isdef each pzlist;
	.dotz.pw.ORIG:.z.pw:@[.:;`.z.pw;{{[x;y]1b}}];
	.dotz.po.ORIG:.z.po:@[.:;`.z.po;{;}];
	.dotz.pc.ORIG:.z.pc:@[.:;`.z.pc;{;}];
	.dotz.pg.ORIG:.z.pg:@[.:;`.z.pg;{.:}];
	.dotz.ps.ORIG:.z.ps:@[.:;`.z.ps;{.:}];
	.dotz.pi.ORIG:.z.pi:@[.:;`.z.pi;{{.Q.s value x}}];
	.dotz.ph.ORIG:.z.ph; / .z.ph is defined in q.k
	.dotz.pp.ORIG:.z.pp:@[.:;`.z.pp;{;}]; / (poststring;postbody)
	revert:{.z.pw:.dotz.pw.ORIG;.z.po:.dotz.po.ORIG;.z.pc:.dotz.pc.ORIG;.z.pg:.dotz.pg.ORIG;.z.ps:.dotz.ps.ORIG;.z.pi:.dotz.pi.ORIG;.z.ph:.dotz.ph.ORIG;.z.pp:.dotz.pp.ORIG;.dotz.SAVED.ORIG:0b;
		if[.z.K>2.3;{system"x ",string x}each .dotz.undef];}
	]