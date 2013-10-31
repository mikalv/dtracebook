<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en" dir="ltr">
<head>
<title>Disk IO:satacmds.d - DTraceBook</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="generator" content="MediaWiki 1.16.2" />
<link rel="shortcut icon" href="/favicon.ico" />
<link rel="search" type="application/opensearchdescription+xml" href="/opensearch_desc.php" title="DTraceBook (en)" />
<link rel="alternate" type="application/atom+xml" title="DTraceBook Atom feed" href="/index.php?title=Special:RecentChanges&amp;feed=atom" />
<link rel="stylesheet" href="/skins/common/shared.css?270" media="screen" />
<link rel="stylesheet" href="/skins/common/commonPrint.css?270" media="print" />
<link rel="stylesheet" href="/skins/monobook/main.css?270" media="screen" />
<!--[if lt IE 5.5000]><link rel="stylesheet" href="/skins/monobook/IE50Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 5.5000]><link rel="stylesheet" href="/skins/monobook/IE55Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 6]><link rel="stylesheet" href="/skins/monobook/IE60Fixes.css?270" media="screen" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" href="/skins/monobook/IE70Fixes.css?270" media="screen" /><![endif]-->
<link rel="stylesheet" href="/index.php?title=MediaWiki:Common.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" />
<link rel="stylesheet" href="/index.php?title=MediaWiki:Print.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" media="print" />
<link rel="stylesheet" href="/index.php?title=MediaWiki:Monobook.css&amp;usemsgcache=yes&amp;ctype=text%2Fcss&amp;smaxage=18000&amp;action=raw&amp;maxage=18000" />
<link rel="stylesheet" href="/index.php?title=-&amp;action=raw&amp;maxage=18000&amp;gen=css" />
<script>
var skin="monobook",
stylepath="/skins",
wgUrlProtocols="http\\:\\/\\/|https\\:\\/\\/|ftp\\:\\/\\/|irc\\:\\/\\/|gopher\\:\\/\\/|telnet\\:\\/\\/|nntp\\:\\/\\/|worldwind\\:\\/\\/|mailto\\:|news\\:|svn\\:\\/\\/",
wgArticlePath="/index.php/$1",
wgScriptPath="",
wgScriptExtension=".php",
wgScript="/index.php",
wgVariantArticlePath=false,
wgActionPaths={},
wgServer="http://www.dtracebook.com",
wgCanonicalNamespace="",
wgCanonicalSpecialPageName=false,
wgNamespaceNumber=0,
wgPageName="Disk_IO:satacmds.d",
wgTitle="Disk IO:satacmds.d",
wgAction="view",
wgArticleId=80,
wgIsArticle=true,
wgUserName=null,
wgUserGroups=null,
wgUserLanguage="en",
wgContentLanguage="en",
wgBreakFrames=false,
wgCurRevisionId=457,
wgVersion="1.16.2",
wgEnableAPI=true,
wgEnableWriteAPI=true,
wgSeparatorTransformTable=["", ""],
wgDigitTransformTable=["", ""],
wgMainPageTitle="Main Page",
wgFormattedNamespaces={"-2": "Media", "-1": "Special", "0": "", "1": "Talk", "2": "User", "3": "User talk", "4": "DTraceBook", "5": "DTraceBook talk", "6": "File", "7": "File talk", "8": "MediaWiki", "9": "MediaWiki talk", "10": "Template", "11": "Template talk", "12": "Help", "13": "Help talk", "14": "Category", "15": "Category talk"},
wgNamespaceIds={"media": -2, "special": -1, "": 0, "talk": 1, "user": 2, "user_talk": 3, "dtracebook": 4, "dtracebook_talk": 5, "file": 6, "file_talk": 7, "mediawiki": 8, "mediawiki_talk": 9, "template": 10, "template_talk": 11, "help": 12, "help_talk": 13, "category": 14, "category_talk": 15, "image": 6, "image_talk": 7},
wgSiteName="DTraceBook",
wgCategories=[],
wgRestrictionEdit=[],
wgRestrictionMove=[];
</script><script src="/skins/common/wikibits.js?270"></script>
<script src="/skins/common/ajax.js?270"></script>
<script src="/index.php?title=-&amp;action=raw&amp;gen=js&amp;useskin=monobook&amp;270"></script>

</head>
<body class="mediawiki ltr ns-0 ns-subject page-Disk_IO_satacmds_d skin-monobook">
<div id="globalWrapper">
<div id="column-content"><div id="content" >
	<a id="top"></a>
	
	<h1 id="firstHeading" class="firstHeading">Disk IO:satacmds.d</h1>
	<div id="bodyContent">
		<h3 id="siteSub">From DTraceBook</h3>
		<div id="contentSub"></div>
		<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>
		<!-- start content -->
<h1> <span class="mw-headline" id="satacmds.d.2C_page_238">satacmds.d, page 238</span></h1>
<pre>
#!/usr/sbin/dtrace -Zs

#pragma D option quiet

string sata_cmd[uchar_t];

dtrace:::BEGIN
{
	/*
	 * These are from the SATA_DIR_* and SATA_OPMODE_* definitions in
	 * /usr/include/sys/sata/sata_hba.h:
	 */
	sata_dir[1] = &quot;no-data&quot;;
	sata_dir[2] = &quot;read&quot;;
	sata_dir[4] = &quot;write&quot;;
	sata_opmode[0] = &quot;ints+async&quot;;	/* interrupts and asynchronous */
	sata_opmode[1] = &quot;poll&quot;;	/* polling */
	sata_opmode[4] = &quot;synch&quot;;	/* synchronous */
	sata_opmode[5] = &quot;synch+poll&quot;;	/* (valid?) */

	/*
	 * These SATA command descriptions were generated from the SATAC_*
	 * definitions in /usr/include/sys/sata/sata_defs.h:
	 */
	sata_cmd[0x90] = &quot;diagnose command&quot;;
	sata_cmd[0x10] = &quot;restore cmd, 4 bits step rate&quot;;
	sata_cmd[0x50] = &quot;format track command&quot;;
	sata_cmd[0xef] = &quot;set features&quot;;
	sata_cmd[0xe1] = &quot;idle immediate&quot;;
	sata_cmd[0xe0] = &quot;standby immediate&quot;;
	sata_cmd[0xde] = &quot;door lock&quot;;
	sata_cmd[0xdf] = &quot;door unlock&quot;;
	sata_cmd[0xe3] = &quot;idle&quot;;
	sata_cmd[0xe2] = &quot;standby&quot;;
	sata_cmd[0x08] = &quot;ATAPI device reset&quot;;
	sata_cmd[0x92] = &quot;Download microcode&quot;;
	sata_cmd[0xed] = &quot;media eject&quot;;
	sata_cmd[0xe7] = &quot;flush write-cache&quot;;
	sata_cmd[0xec] = &quot;IDENTIFY DEVICE&quot;;
	sata_cmd[0xa1] = &quot;ATAPI identify packet device&quot;;
	sata_cmd[0x91] = &quot;initialize device parameters&quot;;
	sata_cmd[0xa0] = &quot;ATAPI packet&quot;;
	sata_cmd[0xc4] = &quot;read multiple w/DMA&quot;;
	sata_cmd[0x20] = &quot;read sector&quot;;
	sata_cmd[0x40] = &quot;read verify&quot;;
	sata_cmd[0xc8] = &quot;read DMA&quot;;
	sata_cmd[0x70] = &quot;seek&quot;;
	sata_cmd[0xa2] = &quot;queued/overlap service&quot;;
	sata_cmd[0xc6] = &quot;set multiple mode&quot;;
	sata_cmd[0xca] = &quot;write (multiple) w/DMA&quot;;
	sata_cmd[0xc5] = &quot;write multiple&quot;;
	sata_cmd[0x30] = &quot;write sector&quot;;
	sata_cmd[0x24] = &quot;read sector extended (LBA48)&quot;;
	sata_cmd[0x25] = &quot;read DMA extended (LBA48)&quot;;
	sata_cmd[0x29] = &quot;read multiple extended (LBA48)&quot;;
	sata_cmd[0x34] = &quot;write sector extended (LBA48)&quot;;
	sata_cmd[0x35] = &quot;write DMA extended (LBA48)&quot;;
	sata_cmd[0x39] = &quot;write multiple extended (LBA48)&quot;;
	sata_cmd[0xc7] = &quot;read DMA / may be queued&quot;;
	sata_cmd[0x26] = &quot;read DMA ext / may be queued&quot;;
	sata_cmd[0xcc] = &quot;write DMA / may be queued&quot;;
	sata_cmd[0x36] = &quot;write DMA ext / may be queued&quot;;
	sata_cmd[0xe4] = &quot;read port mult reg&quot;;
	sata_cmd[0xe8] = &quot;write port mult reg&quot;;
	sata_cmd[0x60] = &quot;First-Party-DMA read queued&quot;;
	sata_cmd[0x61] = &quot;First-Party-DMA write queued&quot;;
	sata_cmd[0x2f] = &quot;read log&quot;;
	sata_cmd[0xb0] = &quot;SMART&quot;;
	sata_cmd[0xe5] = &quot;check power mode&quot;;

	printf(&quot;Tracing... Hit Ctrl-C to end.\n&quot;);
}

/*
 * Trace SATA command start by probing the entry to the SATA HBA driver.  Four
 * different drivers are covered here; add yours here if it is missing.
 */
fbt::nv_sata_start:entry,
fbt::bcm_sata_start:entry,
fbt::ahci_tran_start:entry,
fbt::mv_start:entry
{
	this-&gt;dev = (struct dev_info *)arg0;
	this-&gt;sata_pkt = (sata_pkt_t *)arg1;

	this-&gt;modname = this-&gt;dev&nbsp;!= NULL&nbsp;?
	    stringof(this-&gt;dev-&gt;devi_node_name)&nbsp;: &quot;&lt;unknown&gt;&quot;;
	this-&gt;dir =
	    this-&gt;sata_pkt-&gt;satapkt_cmd.satacmd_flags.sata_data_direction;
	this-&gt;dir_text = sata_dir[this-&gt;dir]&nbsp;!= NULL&nbsp;?
	    sata_dir[this-&gt;dir]&nbsp;: &quot;&lt;none&gt;&quot;;
	this-&gt;cmd = this-&gt;sata_pkt-&gt;satapkt_cmd.satacmd_cmd_reg;
	this-&gt;cmd_text = sata_cmd[this-&gt;cmd]&nbsp;!= NULL&nbsp;?
	    sata_cmd[this-&gt;cmd]&nbsp;: lltostr(this-&gt;cmd);
	this-&gt;op_mode = this-&gt;sata_pkt-&gt;satapkt_op_mode;
	this-&gt;op_text = sata_opmode[this-&gt;op_mode]&nbsp;!= NULL&nbsp;?
	    sata_opmode[this-&gt;op_mode]&nbsp;: lltostr(this-&gt;op_mode);

	@[this-&gt;modname, this-&gt;dir_text, this-&gt;cmd_text, this-&gt;op_text] =
	    count();
}

dtrace:::END
{
	printf(&quot; &nbsp;%-14s&nbsp;%-9s&nbsp;%-30s&nbsp;%-10s  &nbsp;%s\n&quot;, &quot;DEVICE NODE&quot;, &quot;DIR&quot;,
	    &quot;COMMAND&quot;, &quot;OPMODE&quot;, &quot;COUNT&quot;);
	printa(&quot; &nbsp;%-14s&nbsp;%-9s&nbsp;%-30s&nbsp;%-10s  &nbsp;%@d\n&quot;, @);
}
</pre>

<!-- 
NewPP limit report
Preprocessor node count: 7/1000000
Post-expand include size: 0/2097152 bytes
Template argument size: 0/2097152 bytes
Expensive parser function count: 0/100
-->

<!-- Saved in parser cache with key wikidb:pcache:idhash:80-0!1!0!!en!2!edit=0 and timestamp 20131031143312 -->
<div class="printfooter">
Retrieved from "<a href="http://www.dtracebook.com/index.php/Disk_IO:satacmds.d">http://www.dtracebook.com/index.php/Disk_IO:satacmds.d</a>"</div>
		<div id='catlinks' class='catlinks catlinks-allhidden'></div>		<!-- end content -->
				<div class="visualClear"></div>
	</div>
</div></div>
<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
				 <li id="ca-nstab-main" class="selected"><a href="/index.php/Disk_IO:satacmds.d" title="View the content page [c]" accesskey="c">Page</a></li>
				 <li id="ca-talk" class="new"><a href="/index.php?title=Talk:Disk_IO:satacmds.d&amp;action=edit&amp;redlink=1" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
				 <li id="ca-viewsource"><a href="/index.php?title=Disk_IO:satacmds.d&amp;action=edit" title="This page is protected.&#10;You can view its source [e]" accesskey="e">View source</a></li>
				 <li id="ca-history"><a href="/index.php?title=Disk_IO:satacmds.d&amp;action=history" title="Past revisions of this page [h]" accesskey="h">History</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/index.php?title=Special:UserLogin&amp;returnto=Disk_IO:satacmds.d" title="You are encouraged to log in; however, it is not mandatory [o]" accesskey="o">Log in</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-logo">
		<a style="background-image: url(../images/41AKe8-hswL._SL160_.jpg);" href="/index.php/Main_Page" title="Visit the main page"></a>
	</div>
	<script type="text/javascript"> if (window.isMSIE55) fixalpha(); </script>
	<div class='generated-sidebar portlet' id='p-navigation'>
		<h5>Navigation</h5>
		<div class='pBody'>
			<ul>
				<li id="n-mainpage-description"><a href="/index.php/Main_Page" title="Visit the main page [z]" accesskey="z">Main page</a></li>
				<li id="n-recentchanges"><a href="/index.php/Special:RecentChanges" title="The list of recent changes in the wiki [r]" accesskey="r">Recent changes</a></li>
				<li id="n-randompage"><a href="/index.php/Special:Random" title="Load a random page [x]" accesskey="x">Random page</a></li>
				<li id="n-help"><a href="/index.php/Help:Contents" title="The place to find out">Help</a></li>
			</ul>
		</div>
	</div>
	<div class='generated-sidebar portlet' id='p-links'>
		<h5>links</h5>
		<div class='pBody'>
			<ul>
				<li id="n-dtrace.org"><a href="http://dtrace.org">dtrace.org</a></li>
				<li id="n-DTraceToolkit"><a href="http://www.brendangregg.com/dtrace.html#DTraceToolkit">DTraceToolkit</a></li>
				<li id="n-solarisinternals.com"><a href="http://www.solarisinternals.com">solarisinternals.com</a></li>
			</ul>
		</div>
	</div>
	<div id="p-search" class="portlet">
		<h5><label for="searchInput">Search</label></h5>
		<div id="searchBody" class="pBody">
			<form action="/index.php" id="searchform">
				<input type='hidden' name="title" value="Special:Search"/>
				<input id="searchInput" title="Search DTraceBook" accesskey="f" type="search" name="search" />
				<input type='submit' name="go" class="searchButton" id="searchGoButton"	value="Go" title="Go to a page with this exact name if exists" />&nbsp;
				<input type='submit' name="fulltext" class="searchButton" id="mw-searchButton" value="Search" title="Search the pages for this text" />
			</form>
		</div>
	</div>
	<div class="portlet" id="p-tb">
		<h5>Toolbox</h5>
		<div class="pBody">
			<ul>
				<li id="t-whatlinkshere"><a href="/index.php/Special:WhatLinksHere/Disk_IO:satacmds.d" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/index.php/Special:RecentChangesLinked/Disk_IO:satacmds.d" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-specialpages"><a href="/index.php/Special:SpecialPages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/index.php?title=Disk_IO:satacmds.d&amp;printable=yes" rel="alternate" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/index.php?title=Disk_IO:satacmds.d&amp;oldid=457" title="Permanent link to this revision of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
</div><!-- end of the left (by default at least) column -->
<div class="visualClear"></div>
<div id="footer">
	<div id="f-poweredbyico"><a href="http://www.mediawiki.org/"><img src="/skins/common/images/poweredby_mediawiki_88x31.png" height="31" width="88" alt="Powered by MediaWiki" /></a></div>
	<ul id="f-list">
		<li id="lastmod"> This page was last modified on 20 April 2011, at 19:35.</li>
		<li id="viewcount">This page has been accessed 1,714 times.</li>
		<li id="about"><a href="/index.php/DTraceBook:About" title="DTraceBook:About">About DTraceBook</a></li>
	</ul>
</div>
</div>

<script>if (window.runOnloadHook) runOnloadHook();</script>
<!-- Served in 0.298 secs. --></body></html>