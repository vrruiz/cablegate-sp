function getStreamgraphSettings()
{
    var s = new Settings();
    s.show_settings = false;
    s.show_legend = false;

    s.colors.background = 200;
    s.colors.neutral = 100;
    s.colors.highlight = 0;

    s.colors.image = "../deps/layers";
    return s;
}
function getStreamgraphLabels() {
	return [
	'ASEC',
	'EAIR',
	'ECON',
	'EFIN',
	'ENRG',
	'ETRD',
	'ETTC',
	'KNNP',
	'KSCA',
	'MARR',
	'OTRA',
	'PARM',
	'PGOV',
	'PHUM',
	'PREL',
	'PTER',
	'SENV',
	'TBIO',
	'TRGY',
	'TSPA'
	];
}


function getStreamgraphData() {
	return [
	// Date: 2004-02 (0) 
	[1,3,10,5,3,7,2,1,5,1,16,3,7,2,15,5,2,8,3,1],
	// Date: 2004-03 (1) 
	[5,6,6,8,9,4,1,6,10,1,31,3,25,6,32,10,5,8,8,2],
	// Date: 2004-04 (2) 
	[2,0,5,0,2,2,0,1,4,0,15,1,4,0,8,4,1,9,2,0],
	// Date: 2004-05 (3) 
	[11,4,15,5,8,6,1,3,13,1,47,3,11,2,33,12,7,31,5,2],
	// Date: 2004-06 (4) 
	[13,1,12,8,10,2,2,2,9,4,28,3,16,0,34,19,2,6,11,1],
	// Date: 2004-07 (5) 
	[9,4,12,11,9,6,10,5,7,3,31,9,12,9,37,13,3,6,5,1],
	// Date: 2004-08 (6) 
	[6,1,7,3,5,1,1,2,5,0,18,5,6,3,25,8,2,9,4,3],
	// Date: 2004-09 (7) 
	[1,3,6,6,3,0,2,0,4,0,20,0,3,1,11,3,1,5,3,1],
	// Date: 2004-10 (8) 
	[3,2,2,0,5,4,1,1,5,3,25,2,9,3,21,6,4,10,2,2],
	// Date: 2004-11 (9) 
	[1,0,4,8,8,3,5,4,6,1,25,7,7,5,19,3,3,8,7,3],
	// Date: 2004-12 (10) 
	[2,1,8,5,5,4,4,4,1,2,7,3,7,4,18,2,2,3,3,0],
	// Date: 2005-01 (11) 
	[3,1,3,4,2,4,1,0,2,2,9,0,3,1,6,4,1,4,1,0],
	// Date: 2005-02 (12) 
	[1,1,9,7,4,7,1,1,2,0,23,1,13,1,18,10,4,12,4,4],
	// Date: 2005-03 (13) 
	[2,4,7,3,4,0,5,2,8,0,23,1,7,6,25,8,3,8,3,4],
	// Date: 2005-04 (14) 
	[0,1,8,2,9,2,0,0,12,0,36,0,11,3,22,11,8,15,7,5],
	// Date: 2005-05 (15) 
	[2,1,4,3,5,3,2,1,7,7,33,2,5,3,18,7,3,18,2,8],
	// Date: 2005-06 (16) 
	[7,7,10,7,22,4,4,1,32,4,84,3,16,7,26,8,7,23,19,11],
	// Date: 2005-07 (17) 
	[0,1,7,5,6,6,5,1,7,2,22,3,4,2,18,8,1,5,5,4],
	// Date: 2005-08 (18) 
	[4,6,6,1,8,3,4,2,10,3,35,4,3,1,10,2,4,10,6,7],
	// Date: 2005-09 (19) 
	[2,4,4,4,7,1,4,2,9,0,37,4,3,1,10,2,3,9,5,11],
	// Date: 2005-10 (20) 
	[0,2,5,8,3,3,5,2,16,0,33,4,14,8,29,5,3,10,2,5],
	// Date: 2005-11 (21) 
	[1,0,4,4,4,3,2,1,9,0,15,0,2,0,8,4,4,5,4,2],
	// Date: 2005-12 (22) 
	[0,0,0,0,0,0,1,0,0,0,0,1,1,0,4,0,0,0,0,0],
	// Date: 2006-01 (23) 
	[1,0,0,1,0,0,0,0,0,0,0,0,3,0,5,1,0,0,0,0],
	// Date: 2006-02 (24) 
	[0,0,0,0,0,0,0,0,0,0,0,0,5,1,6,2,0,0,0,0],
	// Date: 2006-03 (25) 
	[1,0,1,0,1,1,0,0,0,0,0,0,10,2,19,8,0,0,0,0],
	// Date: 2006-04 (26) 
	[0,0,0,0,0,1,1,0,0,1,2,0,7,5,9,3,0,0,0,0],
	// Date: 2006-05 (27) 
	[1,0,1,0,0,0,0,0,0,0,0,0,4,1,6,1,0,0,0,0],
	// Date: 2006-06 (28) 
	[0,0,0,0,0,1,1,0,0,2,0,1,3,1,10,0,0,0,0,0],
	// Date: 2006-07 (29) 
	[0,0,2,1,0,2,2,0,0,2,2,2,5,4,21,2,0,0,0,0],
	// Date: 2006-08 (30) 
	[0,0,0,0,6,0,0,4,11,4,23,1,5,3,11,1,2,7,4,5],
	// Date: 2006-09 (31) 
	[6,4,7,3,14,0,2,14,31,4,82,1,6,2,16,5,7,16,14,28],
	// Date: 2006-10 (32) 
	[1,4,4,6,13,0,2,14,8,2,46,4,11,6,31,4,0,8,12,14],
	// Date: 2006-11 (33) 
	[6,12,4,2,5,3,2,4,14,3,36,3,9,3,28,4,2,9,5,5],
	// Date: 2006-12 (34) 
	[2,1,5,2,0,4,1,0,7,1,12,1,12,5,18,7,2,4,0,4],
	// Date: 2007-01 (35) 
	[7,5,6,3,1,3,4,1,7,8,25,6,10,1,22,7,4,6,0,5],
	// Date: 2007-02 (36) 
	[7,5,1,2,4,2,4,3,12,5,36,2,7,6,26,1,0,13,1,4],
	// Date: 2007-03 (37) 
	[3,5,5,3,3,1,1,4,24,5,46,5,15,6,34,4,2,23,0,9],
	// Date: 2007-04 (38) 
	[0,5,3,5,11,4,0,6,20,3,57,1,9,9,22,2,4,19,0,0],
	// Date: 2007-05 (39) 
	[0,9,6,3,12,5,4,3,18,7,68,8,8,5,42,10,10,19,1,21],
	// Date: 2007-06 (40) 
	[0,9,6,6,4,13,4,0,18,2,70,3,6,4,20,5,3,19,0,33],
	// Date: 2007-07 (41) 
	[1,13,10,6,3,11,1,1,15,3,67,2,9,2,20,9,4,13,2,35],
	// Date: 2007-08 (42) 
	[4,8,7,8,15,8,1,0,7,2,57,2,6,2,21,5,1,0,13,23],
	// Date: 2007-09 (43) 
	[4,10,9,6,13,21,0,0,11,0,55,0,4,6,15,6,1,0,8,11],
	// Date: 2007-10 (44) 
	[4,6,8,10,9,11,2,4,5,0,32,9,13,3,27,10,1,2,6,9],
	// Date: 2007-11 (45) 
	[3,0,7,7,6,4,2,1,0,1,7,1,12,6,24,7,2,3,3,0],
	// Date: 2007-11 (46) 
	[1,0,0,0,1,0,0,0,0,0,2,0,0,0,0,0,0,0,1,0],
	// Date: 2007-12 (47) 
	[2,1,8,3,6,3,3,1,0,4,3,2,15,3,23,5,3,2,3,0],
	// Date: 2008-01 (48) 
	[0,4,9,10,3,5,4,0,0,1,0,0,11,8,21,10,1,2,0,0],
	// Date: 2008-02 (49) 
	[1,0,4,4,2,3,2,0,0,1,0,0,14,6,25,3,0,0,0,0],
	// Date: 2008-03 (50) 
	[0,0,12,8,4,5,2,1,0,4,0,0,10,7,28,12,3,0,0,0],
	// Date: 2008-04 (51) 
	[0,1,6,8,1,1,0,4,0,0,0,0,8,4,10,4,2,0,0,0],
	// Date: 2008-05 (52) 
	[1,1,9,10,1,6,2,4,0,3,0,4,8,9,32,9,3,1,3,0],
	// Date: 2008-06 (53) 
	[0,0,6,5,5,1,4,3,0,5,1,2,8,5,22,7,1,0,1,0],
	// Date: 2008-07 (54) 
	[1,1,12,8,5,4,2,3,0,4,0,6,16,12,33,13,2,2,0,1],
	// Date: 2008-08 (55) 
	[0,1,5,5,4,1,2,2,0,2,0,4,9,3,15,1,1,0,0,0],
	// Date: 2008-09 (56) 
	[0,0,5,5,2,1,2,1,0,4,0,5,5,3,18,2,1,0,0,1],
	// Date: 2008-10 (57) 
	[0,3,7,6,3,1,0,0,0,4,0,3,11,2,16,2,2,0,1,1],
	// Date: 2008-11 (58) 
	[0,0,7,5,5,7,3,2,0,1,0,4,8,3,15,6,1,1,3,1],
	// Date: 2008-12 (59) 
	[2,0,4,4,4,4,4,3,0,4,0,3,11,3,15,7,0,0,3,0],
	// Date: 2009-01 (60) 
	[0,3,8,8,6,1,9,3,0,1,0,8,7,3,19,5,0,0,1,4],
	// Date: 2009-02 (61) 
	[3,0,15,17,3,6,1,0,0,4,0,3,13,5,35,4,2,0,0,0],
	// Date: 2009-03 (62) 
	[2,2,10,10,1,5,2,0,0,1,0,4,9,3,16,4,1,0,0,3],
	// Date: 2009-04 (63) 
	[1,6,9,3,0,9,8,7,0,0,0,7,19,4,29,5,1,0,0,3],
	// Date: 2009-05 (64) 
	[1,8,6,4,3,9,8,2,0,0,0,0,14,0,16,5,0,1,0,1],
	// Date: 2009-06 (65) 
	[0,1,4,4,5,1,3,5,0,1,0,1,11,3,19,3,0,0,3,0],
	// Date: 2009-07 (66) 
	[0,2,9,7,2,4,3,2,0,1,1,0,9,2,13,4,0,1,0,1],
	// Date: 2009-08 (67) 
	[0,1,4,5,0,1,4,1,1,1,0,6,8,3,18,5,0,0,0,1],
	// Date: 2009-09 (68) 
	[0,2,7,1,7,2,6,0,0,2,0,2,6,4,14,1,2,1,1,0],
	// Date: 2009-10 (69) 
	[0,0,9,4,4,5,6,2,1,2,1,4,11,2,20,4,1,2,2,1],
	// Date: 2009-11 (70) 
	[0,1,4,5,2,3,3,2,0,2,0,3,9,1,24,5,1,0,1,1],
	// Date: 2009-12 (71) 
	[0,0,5,2,2,1,2,0,0,1,0,0,3,0,9,0,0,0,0,0],
	// Date: 2009-12 (72) 
	[2,1,1,1,2,0,2,0,0,2,0,1,7,1,5,2,1,0,0,1],
	// Date: 2010-01 (73) 
	[1,1,5,3,5,0,3,2,0,2,0,1,10,2,19,5,3,0,2,0],
];
}
