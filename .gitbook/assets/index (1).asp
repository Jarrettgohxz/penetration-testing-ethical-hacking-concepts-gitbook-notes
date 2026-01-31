
<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Basic Setup</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>

<link rel="stylesheet" href="dhtmlwindow<% ui_position("match", "_rtl"); %>.css" type="text/css" />
<script type="text/javascript" src="dhtmlwindow.js">
/***********************************************
* DHTML Window Widget- ? Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/
</script>

<link rel="stylesheet" href="modal.css" type="text/css" />
<script type="text/javascript" src="modal.js"></script>

<SCRIPT language=JavaScript>
document.title = topmenu.basicsetup;
var EN_DIS2 = '<% nvram_get("mtu_enable"); %>';	
var wan_proto = '<% nvram_get("wan_proto"); %>';
var DHCPRef = null;

function valid_url(I)
{
	var match = 0;

//	if(!(I.value.charAt(0)=='h') && !(I.value.charAt(1) == 't') && !(I.value.charAt(2)== 't') && !(I.value.charAt(3) == 'p') && !(I.value.charAt(4) == ':') && !(I.value.charAt(5)=='/') && !(I.value.charAt(6) == '/'))
//	{
//		alert("the url should begin with 'http://' ");
//		I.value = I.defaultValue;
//		return false;
//	}
	for(i=0 ; i<I.value.length; i++){
		ch = I.value.charAt(i);
		if(ch == '.'){
			match = 1;
			break;
		}
	}
	if(match == 0 || (match == 1 && i == 0) || (match == 1 && i == I.value.length-1)) {
		//alert("Illegal E-mail Format!");
		alert("Illegal HTTP Format!");
		I.value = I.defaultValue;	
	//	I.focus();
		return false;
	}
	else
		return true;

}
function valid_mtu(I)
{
	var min = '<% get_mtu("min"); %>';
	var max = '<% get_mtu("max"); %>';
	valid_range(I,min,max,"MTU");
	d = parseInt(I.value, 10);
	if(d > max) {
		I.value = max ;
	}
	if(d < min) {
		I.value = max ;
	}
}

function SelMTU(num,F)
{
	mtu_enable_disable(F,num);
}

function mtu_enable_disable(F,I)
{
	EN_DIS1 = I;
	if ( I == "0" )
		choose_disable(F.wan_mtu);
	else
		choose_enable(F.wan_mtu);
}

function SelWAN(num,F)
{
        F.submit_button.value = "index";
        F.change_action.value = "gozila_cgi";
        //F.wan_proto.value=F.wan_proto.options[num].value;
		
		if(num==6)
		{
				F.wan_proto.value=F.wan_proto.options[0].value;
				F.switch_mode.value = 1;
		}
		else
		{
				F.wan_proto.value=F.wan_proto.options[num].value;
				F.switch_mode.value = 0;
		}
				
        F.submit();
}
function SetControlStatus(F,status,startname,endname)
{
        var start = '';
        var end = '';
        var total = F.elements.length;
        for(i=0 ; i < total ; i++){
                if(F.elements[i].name == startname)       start = i;
                if(F.elements[i].name == endname)         end = i;
        }
        if(start == '' || end == '')    
                        return true;
        for(i = start; i<=end ;i++)
                {
                        if(status==0)
                        {
                choose_disable(F.elements[i]);
                        }
                        else
                        {
                                choose_enable(F.elements[i]);
                        }
                }
}
function SelBridgeDhcp(num,F)
{
     //F.submit_button.value = "index";
     //F.change_action.value = "gozila_cgi";
     //F.wan_proto.value=F.wan_proto.options[num].value;
		
		if(num==0)
		{
				//F.wan_proto.value=F.wan_proto.options[0].value;
				F.switch_mode_dhcp.value = 1;
				SetControlStatus(F,0,"switch_ipaddr_0","switch_gateway_3");
		}
		else
		{
				//F.wan_proto.value=F.wan_proto.options[num].value;
				F.switch_mode_dhcp.value = 0;
				SetControlStatus(F,1,"switch_ipaddr_0","switch_gateway_3");
		}
				
    //F.submit();
}
function SelPPP(num,F)
{
        F.submit_button.value = "index";
        F.change_action.value = "gozila_cgi";
        F.mpppoe_enable.value = F.mpppoe_enable.options[num].value;
        F.submit();
}

function reboot(F)
{
	if(!confirm(other.warning))
		return;

		F.wait_time.value="80";
        F.submit_button.value = "index";
        F.change_action.value = "gozila_cgi";
        F.submit_type.value="reboot";
        F.submit();
}
function to_submit(F)
{
	var wan_ipv6_dhcp = "<% nvram_get("wan_ipv6_dhcp"); %>";
	if(F.switch_mode.value==1 ||
    F.switch_mode.value != '<% nvram_get("switch_mode"); %>')
    {
        F.wait_time.value="80";
        F.need_reboot.value="1";
    }
	if(F.switch_mode.value==0)
	{	
		choose_disable(F.switch_ipaddr);
		choose_disable(F.switch_mode_dhcp);
	var lanip = F.lan_ipaddr_3.value ; 
	var mask = new Array();

	mask = F.lan_netmask.value.split(".");
	var mask_old='<% nvram_get("lan_netmask"); %>';
	var tmpmask = new Array();

	tmpmask = mask_old.split('.');

	/*Jemmy add for setting device name 2010.2.24*/
	F.hnap_devicename.value = F.machine_name.value;
	F.dhcp_start.value = F.dhcp_start_tmp.value;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
	if ( parseInt(lanip) == parseInt(F.dhcp_start_tmp.value) )
	{
		F.dhcp_start.value++;
		F.dhcp_start_conflict.value = 1;
	}
	else
		F.dhcp_start_conflict.value = 0;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
	DHCP_IP_RANGE(F,F.lan_netmask.value,F.lan_ipaddr_3.value);
	var sip = DHCP_START_IP[0];
	if ( sip == 100 ) sip = 0 ; 

	var num = sip+parseInt(F.dhcp_num.value); 
	var xnum = parseInt(parseInt(sip)+parseInt(MAX_RANGE_COUNT));

	// dhcp start ip cannot the same as router ip 
	if ( parseInt(lanip) == parseInt(F.dhcp_start.value) )
	{
		alert(errmsg.err62);
		return ; 
	}
	if ( parseInt(F.dhcp_start.value) < parseInt(sip) )  
	{
		alert(errmsg.err2);
		return ; 
	}
	if(mask[3] != tmpmask[3])
	{
		F.wait_time.value="61";
	}

	if ( RANGE_SET == 1 ) 
	{
		if ( (parseInt(sip) > parseInt(num)) || (parseInt(xnum) < parseInt(num))) 
		{
			alert(errmsg.err2);
			return ; 	
		}
	}
	else if ( RANGE_SET == 2 ) 
	{
		//if ( (parseInt(num) < parseInt(sip)) || (parseInt(num) == parseInt(lanip)) || (parseInt(num) > parseInt(xnum)) )
		if ( (parseInt(num) < parseInt(sip)) || (parseInt(num) > parseInt(xnum)) )
		{
			alert(errmsg.err2);
			return ; 	
		}
		
	}
	if (document.getElementById("DymRange").innerHTML == "")
	{
		alert(errmsg.err2);
		return;
	}
	
	var a1 = parseInt(F.dhcp_start.value,10);
        var a2 = parseInt(F.dhcp_num.value,10);
        if( a1 + a2 > 255){
                alert(errmsg.err2);
                return ;
        }
  
	if( F.lan_netmask.value != "255.255.255.0" && !check_reservated_IP(F.lan_ipaddr_3, F.lan_netmask) )
		return;

	if(DHCPRef)
		DHCPRef.close();

	/*Jemmy add for setting device name 2010.2.24*/
	//if(valid_value(F) && valid_lan_ip(F) ){
	if(valid_value(F) && valid_lan_ip(F) && valid_device_name(document.forms[0].machine_name)){
		if(F._daylight_time.checked == false)
			F.daylight_time.value = 0;
		else
			F.daylight_time.value = 1;
		if ( F.lan_netmask.value == "255.255.255.252")
		{
                	choose_enable(F.dhcp_start_tmp);
	                choose_enable(F.dhcp_num);
		}
		if(wan_ipv6_dhcp=="on"){
		if(F.wan_proto.value=="pppoe")
			F.wan_ipv6_proto.value="pppoe";
		else if(F.wan_proto.value=="pptp" || F.wan_proto.value=="l2tp")
			F.wan_ipv6_proto.value="disabled";
		else
			F.wan_ipv6_proto.value="dhcp";
	}
	else
		F.wan_ipv6_proto.value='<% nvram_get("wan_ipv6_proto"); %>';

		if (F.wan_proto.value == "dslite"){
			// IPv6-Automatic should be Enabled in DS-Lite mode
			F.wan_ipv6_proto.value = "dhcp";
		}	

		F.submit_button.value = "index";
		F.action.value = "Apply";
        	F.submit();
	}
	}
	else
	{
		if(F.switch_mode_dhcp.value == 1)
			choose_disable(F.switch_ipaddr);
		else
		{
			if(!valid_ip(F,"F.switch_ipaddr","IP",ZERO_NO|MASK_NO))
				return;
			if(!valid_mask(F,"F.switch_netmask",ZERO_NO|BCST_NO))
				return;
			if(!valid_ip(F,"F.switch_gateway","Gateway",ZERO_NO|MASK_NO))
				return;
			if(!valid_ip_gw(F,"F.switch_ipaddr","F.switch_netmask","F.switch_gateway"))
				return;
			if (valid_gn_ip(F, "F.switch_ipaddr_", "F.switch_netmask_", "1") == false)
			{
				//alert(errmsg.err82);
				alert(gn.err6);
				return;
			}

		}
	
		F.wan_proto.value='<% nvram_get("wan_proto");%>';
	/*Jemmy add for setting device name 2010.2.24*/
	//if(valid_value(F) && valid_lan_ip(F) ){
	if(valid_device_name(document.forms[0].machine_name)){
		if(F._daylight_time.checked == false)
			F.daylight_time.value = 0;
		else
			F.daylight_time.value = 1;
		if(wan_ipv6_dhcp=="on"){
		if(F.wan_proto.value=="pppoe")
			F.wan_ipv6_proto.value="pppoe";
		else if(F.wan_proto.value=="pptp" || F.wan_proto.value=="l2tp")
			F.wan_ipv6_proto.value="disabled";
		else
			F.wan_ipv6_proto.value="dhcp";
	}
	else
		F.wan_ipv6_proto.value='<% nvram_get("wan_ipv6_proto"); %>';
		F.submit_button.value = "index";
		F.action.value = "Apply";
        	F.submit();
	}
	}
}
function valid_value(F)
{
 	var ipaddr,lanip,wanip;
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
	if(F.now_proto.value == "pptp" || F.now_proto.value == "static"){
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
		if(F.now_proto.value == "static" || (F.now_proto.value=="pptp" 
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
							&& F.sel_pptp_dhcp[1].checked == true
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
		  ))
		{
			if(!valid_ip(F,"F.wan_ipaddr","IP",ZERO_NO|MASK_NO))
        	                return false;
		
			// EMILY ADD 032207 - For check WAN IP or LAN IP is the same with Router IP or not
			lanip = F.lan_ipaddr_0.value +"."+F.lan_ipaddr_1.value+"."+F.lan_ipaddr_2.value +"."+F.lan_ipaddr_3.value;
			wanip = F.wan_ipaddr_0.value +"."+F.wan_ipaddr_1.value+"."+F.wan_ipaddr_2.value +"."+F.wan_ipaddr_3.value;
		
			if(lanip == wanip)
			{
				alert(errmsg.err79);
				return false; 
			}
			// EMILY ADD END
			if(!valid_mask(F,"F.wan_netmask",ZERO_NO|BCST_NO))
				return false;	

			if (valid_gn_ip(F, "F.wan_ipaddr_", "F.wan_netmask_", "1") == false)
			{
				//alert(errmsg.err82);
				alert(gn.err6);
				return false;
			}
			//alert("---------------");
			//return false;
		}

		if(F.now_proto.value == "static"){
			if(!valid_ip(F,"F.wan_gateway","Gateway",ZERO_NO|MASK_NO))
              		  	return false;
			//if(!valid_ip(F,"F.wan_dns0","DNS",MASK_NO))
			//	return false;
			//if(!valid_ip(F,"F.wan_dns1","DNS",MASK_NO))
			//	return false;
			//if(!valid_ip(F,"F.wan_dns2","DNS",MASK_NO))
			//	return false;
			if(!valid_ip_for_dns_ex(F,"static_dns0","DNS1",ZERO_NO|MASK_NO) || 
			   !valid_ip_for_dns_ex(F,"static_dns1","DNS2",MASK_NO) ||
			   !valid_ip_for_dns_ex(F,"static_dns2","DNS3",MASK_NO))
			{ 
				return false;
			}
			
			valid_same_dns(F,"F.wan_dns0","F.wan_dns1","F.wan_dns2");
			if(!valid_ip_gw(F,"F.wan_ipaddr","F.wan_netmask","F.wan_gateway"))
				return false;
			if(valid_subnet(F,"F.wan_ipaddr","F.wan_netmask","F.lan_ipaddr")) {
				alert(errmsg.err81);
				return false;
			}
		}

		if(F.now_proto.value == "pptp"){
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
			if(F.sel_pptp_dhcp[1].checked == true)
			{
			if(!valid_ip(F,"F.wan_pptp_gateway","Gateway",ZERO_NO|MASK_NO))
				return false;
	
			if(!valid_ip_gw(F,"F.wan_ipaddr","F.wan_netmask","F.wan_pptp_gateway"))
				return false;
			}
				
			if(!valid_ip(F,"F.pptp_server_ip","PPTP Server IP",ZERO_NO|MASK_NO))
                		return false;
			if(F.sel_pptp_dhcp[1].checked == true)
			{
                                //delete the request that static pptp mode need enter one dns address at lease 
                                if(!valid_ip_for_dns(F,"F.wan_pptp_dns0","DNS1",MASK_NO) 
                                        || !valid_ip_for_dns(F,"F.wan_pptp_dns1","DNS2",MASK_NO) 
                                        || !valid_ip_for_dns(F,"F.wan_pptp_dns2","DNS3",MASK_NO) )
                                {
                                                return false;
                                }
                                valid_same_dns_ex(F,"F.wan_pptp_dns0","F.wan_pptp_dns1","F.wan_pptp_dns2"); 
				if(F.pptp_server_ip_0.value == F.wan_ipaddr_0.value 
					&& F.pptp_server_ip_1.value == F.wan_ipaddr_1.value 
					&& F.pptp_server_ip_2.value == F.wan_ipaddr_2.value 
					&& F.pptp_server_ip_3.value == F.wan_ipaddr_3.value)
				{
					alert(errmsg.pptpsameserver);
					return false;
				}
			}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
<% support_match("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
			if(!valid_ip(F,"F.pptp_server_ip","Gateway",ZERO_NO|MASK_NO))
                		return false;
			if(!valid_ip_gw(F,"F.wan_ipaddr","F.wan_netmask","F.pptp_server_ip"))
				return false;
<% support_match("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
		}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
	}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>

	if(F.now_proto.value == "pppoe" || F.now_proto.value == "pptp" || F.now_proto.value == "l2tp" || F.now_proto.value == "heartbeat"){
		if(F.ppp_username.value == ""){
//                      alert("You must input a username!");
                        alert(errmsg.err0);
			F.ppp_username.focus();
			return false;
		}
		if(F.ppp_passwd.value == ""){
//                      alert("You must input a passwd!");
                        alert(errmsg.err6);
			F.ppp_passwd.focus();
			return false;
		}
	}
	
	if(!valid_dhcp_server(F))
		return false;

	if(F.router_name && F.router_name.value == ""){
//              alert("You must input a Router Name!");
                alert(errmsg.err1);
                F.router_name.focus();
                return false;
	}	
	return true ; 
}

function valid_hb(I,M)
{
	if(I.value == "0.0.0.0" || I.value == "255.255.255.255") {
//		alert("The Telstra Cable Server IP Address is invalid!");
//              alert("The HeartBeat Server IP Address is invalid!");
                alert(errmsg2.err0);
		I.value = I.defaultValue;
		return false;
	}
	return valid_name(I,M);
}

function valid_dhcp_server(F)
{
	if(F.lan_proto.selectedIndex == 0)
                return true;
        F.dhcp_start.value = F.dhcp_start_tmp.value;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
	if(F.lan_ipaddr_3.value == F.dhcp_start_tmp.value)
		F.dhcp_start.value++;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>

	a1 = parseInt(F.dhcp_start.value,10);
        a2 = parseInt(F.dhcp_num.value,10);
        if( a1 + a2 > 255){
//                alert("Out of range, please adjust start IP address or user's numbers.");
                alert(errmsg.err2);
                return false;
        } 

        if(!valid_ip_for_dns(F,"F.wan_dns0","DNS1",MASK_NO))
                return false;
        if(!valid_ip_for_dns(F,"F.wan_dns1","DNS2",MASK_NO))
                return false;
        if(!valid_ip_for_dns(F,"F.wan_dns2","DNS3",MASK_NO))
                return false;
        if(!valid_ip(F,"F.wan_wins","WINS",MASK_NO))
                return false;
 
        valid_same_dns_ex(F,"F.wan_dns0","F.wan_dns1","F.wan_dns2");  

	return true;
}
function SelDHCP(T,F)
{
	dhcp_enable_disable(F,T);
}

function dhcp_enable_disable(F,T)
{
	var start = '';
	var end = '';
 	var total = F.elements.length;
	for(i=0 ; i < total ; i++){
		if(F.elements[i].name == "dhcp_res")	start = i;
		if(F.elements[i].name == "wan_wins_3")	end = i;
	}
	if(start == '' || end == '')	return true;

	if( T == "static" ) {
		EN_DIS = 0;
		for(i = start; i<=end ;i++)
			choose_disable(F.elements[i]);
	}
	else {
		EN_DIS = 1;
		for(i = start; i<=end ;i++)
			choose_enable(F.elements[i]);
	}

	if(F.now_proto.value == "static") {
		disable_second_dns();
	}
}
function SelTime(num,f)
{
	var str = f.time_zone.options[num].value;
	var Arr = new Array();
	Arr = str.split(' ');
	aaa = Arr[2];
	daylight_enable_disable(f,aaa);
}

function ppp_enable_disable(F,I)
{

	//wuzh add for ppp_demand
	F.ppp_demand_pppoe.value = "9";
	F.ppp_demand_pptp.value = "9";
	F.ppp_demand_l2tp.value = "9";
	F.ppp_demand_hb.value = "9";

	if(F.now_proto.value=="pppoe"){
		F.ppp_demand_pppoe.value = I;
	}else if(F.now_proto.value=="pptp"){
		F.ppp_demand_pptp.value = I;
	}else if(F.now_proto.value=="l2tp"){
		F.ppp_demand_l2tp.value = I;
	}else if(F.now_proto.value=="heartbeat"){
		F.ppp_demand_hb.value = I;
	}

	if( I == "0"){
		choose_disable(F.ppp_idletime);
		choose_enable(F.ppp_redialperiod);
	}
	else{
		choose_enable(F.ppp_idletime);
		choose_disable(F.ppp_redialperiod);
	}
}

function dslite_enable_disable(F,I)
{
	if( I == "0"){
		choose_enable(F.dslite_info);
	}
	else{
		choose_disable(F.dslite_info);
	}
}

function daylight_enable_disable(F,aaa)
{
	if(aaa == 0){
                F._daylight_time.checked = false;
                choose_disable(F._daylight_time);
                F.daylight_time.value = 0;
        }
        else{
                choose_enable(F._daylight_time);                
                F._daylight_time.checked = true;
                F.daylight_time.value = 1;
        }

}

function init_dual_image()
{
	var boot_from = '<% nvram_get("boot_from"); %>';
	var boot_from_fixed = '<% nvram_get("boot_from_fixed"); %>';
	var skip_prompt = '<% nvram_get("skip_prompt"); %>';

	if(boot_from == "2" && skip_prompt != "1" && boot_from_fixed != "2") 
	{
		if(confirm("Using backup image 2 due to the image 1 was broken. Click the Confirm button to skip prompt next time.")) 
		{
			document.setup.submit_button.value = "index";
			document.setup.change_action.value = "gozila_cgi";
			document.setup.submit_type.value = "skip_prompt";
			document.setup.submit();		
		}
	}
}

function init()
{
	var F = document.setup;
	var str;
	var sip;
	var num;
	var eip;	
	var first_bootup_flag = '<%nvram_get("login_checked");%>';
	if(first_bootup_flag != '1')
		Warningwin=dhtmlmodal.open("Warningbox", "iframe", "login_warning.asp", pctrl.warning, "width=700px,height=450px,resize=1,scrolling=1,center=1", "recal");

	mtu_enable_disable(document.setup,'<% nvram_get("mtu_enable"); %>');
	if(F.switch_mode.value==0)
	{
	F.dhcp_start_tmp.value = '<% nvram_get("dhcp_start");%>';
	F.dhcp_start.value = F.dhcp_start_tmp.value;		
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
	F.dhcp_start_conflict.value = '<% nvram_get("dhcp_start_conflict"); %>';
	if ( F.dhcp_start_conflict.value == 1 )
		F.dhcp_start_tmp.value--;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
	
	sip = F.dhcp_start.value ; //'<% nvram_get("dhcp_start"); %>';
	num = F.dhcp_num.value; //'<% nvram_get("dhcp_num");%>';
	eip = parseInt(parseInt(num)+parseInt(sip)-1);
	}
	str = F.time_zone.options[F.time_zone.selectedIndex].value;
	Arr = new Array();
	var RANGESET ; 

	Arr = str.split(' ');
	aaa = Arr[2];
	if(aaa == 0){
                document.setup._daylight_time.checked = false;
                choose_disable(document.setup._daylight_time);
                document.setup.daylight_time.value = 0;
        }

    if(F.switch_mode.value==0)
    {
        if(document.setup.now_proto.value == "pppoe")
                ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_pppoe"); %>');
        else if(document.setup.now_proto.value == "pptp")
                ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_pptp"); %>');
        else if(document.setup.now_proto.value == "l2tp")
                ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_l2tp"); %>');
        else if(document.setup.now_proto.value == "heartbeat")
                ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_hb"); %>');

        dhcp_enable_disable(document.setup,'<% nvram_get("lan_proto"); %>');

        if (document.setup.now_proto.value == "dslite")
                dslite_enable_disable(document.setup,'<% nvram_get("dslite_config"); %>');
        else {
		var max_mtu = <% get_mtu("max"); %>;
		if(document.setup.wan_mtu.value > max_mtu || document.setup.mtu_enable.value == '0') 
			document.setup.wan_mtu.value = max_mtu;
	}

<% support_invmatch("DUAL_IMAGE_SUPPORT", "1", "//"); %> init_dual_image();

	if ( '<% nvram_selget("time_zone"); %>' == '+12 2 4' ) {
		document.setup.time_zone.selectedIndex = '37';
	}

	if(document.setup.now_proto.value == "static") {
		disable_second_dns();
	}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
	if(document.setup.now_proto.value == "pptp") {
		pptp_dhcp = "<% nvram_else_match("sel_pptp_dhcp","1","1", "0"); %>" ; 
		selpptpmode(pptp_dhcp);
		if ( pptp_dhcp == 1 ) 
			document.setup.sel_pptp_dhcp[0].checked = true ; 
		else
			document.setup.sel_pptp_dhcp[1].checked = true ; 
	}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>

	if ((parseInt(sip)<parseInt(F.lan_ipaddr_3.value)) && (parseInt(eip)>=parseInt(F.lan_ipaddr_3.value)))RANGESET = 2 ; 	     else RANGESET = 1; 
	if ( RANGESET == 1 ) 
	{
		document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> "+sip+" "+portforward.to+" "+eip;
	}
	else if ( RANGESET == 2 ) 
	{
		document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> "+sip+" "+portforward.to+" "+parseInt(parseInt(F.lan_ipaddr_3.value)-1);
		/*if ( parseInt(F.lan_ipaddr_3.value)+1 > eip )*/ eip = eip + 1 ; 
                document.getElementById("DymRange").innerHTML += "<BR><% prefix_ip_get("lan_ipaddr",1); %> "+ parseInt(parseInt(F.lan_ipaddr_3.value)+1) + " "+portforward.to+" " + eip;
	}
	
	if ( F.lan_proto[1].checked == true ) return ; // IF DHCP Server is disabled.
	
        if(F.lan_netmask.options[F.lan_netmask.selectedIndex].value == "255.255.255.252") {
                choose_disable(F.dhcp_start_tmp);
                choose_disable(F.dhcp_num);
        }
        else {
                choose_enable(F.dhcp_start_tmp);
                choose_enable(F.dhcp_num);
  	}
    }

	if(F.switch_mode.value==1)
	{	
		SetControlStatus(F,0,"dhcp_start","ppp_demand_hb");
		if(F.switch_mode_dhcp.value==1)
		{
			SetControlStatus(F,0,"switch_ipaddr_0","switch_gateway_3");
		
		}		
	}
}

function disable_second_dns()
{
	document.getElementById("dns00").disabled = true;
	document.getElementById("dns01").disabled = true;
	document.getElementById("dns02").disabled = true;
	document.getElementById("dns03").disabled = true;

	document.getElementById("dns10").disabled = true;
	document.getElementById("dns11").disabled = true;
	document.getElementById("dns12").disabled = true;
	document.getElementById("dns13").disabled = true;

	document.getElementById("dns20").disabled = true;
	document.getElementById("dns21").disabled = true;
	document.getElementById("dns22").disabled = true;
	document.getElementById("dns23").disabled = true;
}

function enable_second_dns()
{
	document.getElementById("dns00").disabled = false;
	document.getElementById("dns01").disabled = false;
	document.getElementById("dns02").disabled = false;
	document.getElementById("dns03").disabled = false;

	document.getElementById("dns10").disabled = false;
	document.getElementById("dns11").disabled = false;
	document.getElementById("dns12").disabled = false;
	document.getElementById("dns13").disabled = false;

	document.getElementById("dns20").disabled = false;
	document.getElementById("dns21").disabled = false;
	document.getElementById("dns22").disabled = false;
	document.getElementById("dns23").disabled = false;
}

function valid_gn_ip(F,I,M,flag)
{	
	var mask = new Array(4);
        var ip = new Array(4);
        var a_gn_lan_ip = new Array();
        var a_lan_mask = new Array();

        var gn_lan_ip = '<% nvram_get("gn_lan_ipaddr"); %>';
        var gn_lan_mask = '<% nvram_get("gn_lan_netmask"); %>';
 
       	a_lan_ip = gn_lan_ip.split(".");
        a_lan_mask = gn_lan_mask.split(".");

        var i = 0;
	for(i=0,j=0;i<4;i++,j=j+4)
       	{
          	ip[i]=eval(I+i).value;
          	if(flag == "0")
        	{
             		mask[i]=M.value.substring(j, j + 3);
        	}
       		else
            		mask[i]=eval(M+i).value;
      	}

        if((((a_lan_ip[0] & mask[0]) == (ip[0] & mask[0])) && ((a_lan_ip[1] & mask[1]) == (ip[1] & mask[1])) && 
            ((a_lan_ip[2] & mask[2]) == (ip[2] & mask[2])) && ((a_lan_ip[3] & mask[3]) == (ip[3] & mask[3])))
          ||(((a_lan_ip[0] & a_lan_mask[0]) == (ip[0] & a_lan_mask[0])) && ((a_lan_ip[1] & a_lan_mask[1]) == (ip[1] & a_lan_mask[1])) && 
          ((a_lan_ip[2] & a_lan_mask[2]) == (ip[2] & a_lan_mask[2])) && ((a_lan_ip[3] & a_lan_mask[3]) == (ip[3] & a_lan_mask[3]))))
       	{
            	return false;
       	}
       	return true;
}

function valid_lan_ip(F)
{
	var mask = new Array(4);
	var ip = new Array(4);
	var netid = new Array(4);
	var brcastip = new Array(4);	

	for(i=0,j=0;i<4;i++,j=j+4)
	{
		ip[i]=eval("F.lan_ipaddr_"+i).value;
		mask[i]=F.lan_netmask.value.substring(j, j + 3);
		netid[i]=eval(ip[i]&mask[i]);
		if(i<3)
			brcastip[i]=netid[i];
		else
			brcastip[i]=eval(netid[i]+255-mask[i]);	
		
	}
	startip = eval(netid[3]+1);
	endip = eval(brcastip[3]-1);
	if( ip[0] == netid[0] && ip[1] == netid[1] && ip[2] == netid[2] && ip[3] == netid[3])
	{
		alert(errmsg.err14+" ["+startip+"-"+endip+"]");
		F.lan_ipaddr_3.focus();
		return false ; 
	}
	if( ip[0] == brcastip[0] && ip[1] == brcastip[1] && ip[2] == brcastip[2] && ip[3] == brcastip[3])
	{
		alert(errmsg.err14+" ["+startip+"-"+endip+"]");
		F.lan_ipaddr_3.focus();
		return false ; 
		
	}	

	if (valid_gn_ip(F, "F.lan_ipaddr_", F.lan_netmask, "0") == false)
	{
		//alert(errmsg.err83);
		alert(gn.err6);
		F.lan_ipaddr_0.focus();
		return false;
	}

	if( (F.lan_ipaddr_0.value != F.lan_ipaddr_0.defaultValue) || (F.lan_ipaddr_1.value != F.lan_ipaddr_1.defaultValue) || (F.lan_ipaddr_2.value != F.lan_ipaddr_2.defaultValue) || (F.lan_ipaddr_3.value != F.lan_ipaddr_3.defaultValue) )
	{
			//F.router2gateway.value="1";
			F.wait_time.value="80";
			F.need_reboot.value="1";
	}
	return true;
}

function DHCP_Res()
{
	DHCPRef = window.open('DHCP_Static.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=710,height=500');
	DHCPRef.focus();

	if( DHCPRef.opener == null )
		DHCPRef.opener = window;

}


function Sel_SubMask(F,I,M)
{
	var flg , MSG ; 
	if(I.switch_mode.value==0)
	{
		if ( I.lan_proto[1].checked == true ) return ; // IF DHCP Server is disabled.
	}	
	if ( M )
	{ 
		if ( I.lan_ipaddr_3.value <= 0 || I.lan_ipaddr_3.value >254)
			 return false ; 
	}
	MSG = DHCP_IP_RANGE(I,F.value,I.lan_ipaddr_3.value);
	switch ( RANGE_SET ) 
	{
		case 0 :
		case -1 :
		   alert(MSG);
		   return false; 
		case 1 : 	
		   document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> " + DHCP_START_IP[0] + " "+portforward.to+" " + DHCP_END_IP[0];
        	   I.dhcp_num.value = RANGE_COUNT;
		   I.dhcp_start_tmp.value = DHCP_START_IP[0];
		   break;
		case 2 : 
		   document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> " + DHCP_START_IP[0] + " "+portforward.to+" " + DHCP_END_IP[0];
                   document.getElementById("DymRange").innerHTML += "<BR><% prefix_ip_get("lan_ipaddr",1); %> "+ DHCP_START_IP[1] + " "+portforward.to+" " + DHCP_END_IP[1];
        	   I.dhcp_num.value = RANGE_COUNT;
		   I.dhcp_start_tmp.value = DHCP_START_IP[0];
		   break;
	}
	if(F.value == "255.255.255.252") {
                choose_disable(I.dhcp_start_tmp);
                choose_disable(I.dhcp_num);
        }
        else {
                choose_enable(I.dhcp_start_tmp);
                choose_enable(I.dhcp_num);
        }
	if( M == 0 && F.value != "255.255.255.0" )
		check_reservated_IP(I.lan_ipaddr_3, F);        
}

// Check if reservated IP in the range of new subnet, reture true if no conflict.
function check_reservated_IP(lanIp, Mask)
{
	var static_route = "<% nvram_get("dhcp_statics"); %>";

	if( static_route.length > 0 )
	{
		var route_array = static_route.split(";");
		var submask = parseInt(Mask.value.split(".")[3]);
		var subnet = submask & parseInt(lanIp.value);
		var reserve_ip;

		for ( var i = 0; i < (route_array.length-1); i++ ) {
			reserve_ip = parseInt(route_array[i].split(" ")[1]);
			if ((reserve_ip & submask) != subnet)
			{
				alert(errmsg.err102);
				return false;
			}
		}
	}
	return true;
}

function Sel_SubMask_onblur(F,I,string)
{
	var et = 256;
	var st = 0;
	var sip = new Array();
	var eip = new Array();
    var mask = new Array();
	var lanip3;
	var ucount;
	var iplen, iprange;
	var i; 
	var set2 = false;
	var start_ip, max_num, dhcp_max_num;
	var start_ip_min, start_ip_max;

	mask = F.value.split(".");
	iprange = 256 - parseInt(mask[3]);
	iplen = 256 / iprange;
	lanip3 = parseInt(I.lan_ipaddr_3.value);
	start_ip_min = (parseInt(mask[3])&lanip3) + 1;
	start_ip_max = start_ip_min + iprange - 3;

	/* check if the lan ip is valid */
	if( lanip3 == start_ip_min - 1 )
	{
		alert(errmsg.err77);
		return;
	}
	else if ( lanip3 == start_ip_max + 1 )
	{
		alert(errmsg.err78);
		return;
	}

	//alert ("iprange=" + iprange + " start_ip_min=" + start_ip_min + " start_ip_max=" + start_ip_max);
	if( string == "dhcp_start" && valid_range(I.dhcp_start_tmp,start_ip_min,start_ip_max,"DHCP%20starting%20IP") == false )
	{
		document.getElementById("DymRange").innerHTML = "";
		return;
	}

	I.dhcp_start.value = I.dhcp_start_tmp.value;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
	if(I.lan_ipaddr_3.value == I.dhcp_start_tmp.value)
		I.dhcp_start.value++;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
 
	start_ip = parseInt(I.dhcp_start.value);
	max_num = parseInt(I.dhcp_num.value);

	if (lanip3 > start_ip)
		dhcp_max_num = (parseInt(mask[3])&start_ip) + iprange - 3;
	else
		dhcp_max_num = (parseInt(mask[3])&start_ip) + iprange - 2;

	if( string == "dhcp_num" && valid_range(I.dhcp_num,1,dhcp_max_num-start_ip+1,"Number%20of%20DHCP%20users") == false )
	{
		document.getElementById("DymRange").innerHTML = "";     
		return;
	}

	if ((iprange - 3) >= max_num)
		ucount = max_num ;
	else
	{
		alert(errmsg.err2);
		document.getElementById("DymRange").innerHTML = "";
		return;
	}
	now_count = ucount;
    for(i = 0; i < iplen; i++)
        {
                if (iplen == 1) 
                {
                        sip[0] = start_ip;
 
                        if((parseInt(lanip3) > parseInt(sip[0])) && ((parseInt(lanip3) - parseInt(sip[0])) < parseInt(ucount)))
                        {
                                eip[0] = parseInt(lanip3) - 1;
                                sip[1] = parseInt(lanip3) + 1;
                                eip[1] = parseInt(sip[1]) + parseInt(ucount) - (parseInt(eip[0]) - parseInt(sip[0])) - 2;
                                set2 = true; 
                        }
                        else 
                                eip[0] = parseInt(sip[0])+parseInt(ucount) - 1;
                        et = 256;
                        break;
                }
                else
                {
                        st = i*iprange; 
                        et = (i + 1) * iprange;
 
                        if ((st < lanip3) && (lanip3 < et))
                        {
                                st = st + 1 ; //It can not be the network IP
                                if (st == lanip3)
                                {
                                        sip[0] = st+1;
                                        if((st < start_ip) && (start_ip <= et))
                                        {
                                                sip[0] = start_ip;
                                        }
                                        eip[0] = parseInt(sip[0]) + parseInt(ucount) - 1;
                                }
                                else
                                {
                                        if (lanip3 - st >= ucount)
        {
                                                sip[0] = st ; 
                                                if((st < start_ip) && (start_ip < et))
                                                {
                                                        sip[0] = start_ip;
                                                }
                                                if((parseInt(lanip3) > parseInt(sip[0])) 
                                                                && ((parseInt(lanip3) - parseInt(sip[0])) < parseInt(ucount)))
                                                {
                                                        eip[0] = parseInt(lanip3) - 1;
                                                        sip[1] = parseInt(lanip3) + 1;
                                                        eip[1] = parseInt(sip[1]) + parseInt(ucount) - (parseInt(eip[0]) - parseInt(sip[0])) - 2;
                                                        set2 = true; 
        }
        else 
                                                        eip[0] = parseInt(sip[0]) + parseInt(ucount) - 1;
                                        }
                                        else
        {
                                                sip[0] = st ; 
                                                if((st < start_ip) && (start_ip < et))
                                                {
                                                        sip[0] = start_ip;
                                                }
                                                if((parseInt(lanip3) > parseInt(sip[0])) 
                                                                && ((parseInt(lanip3) - parseInt(sip[0])) < parseInt(ucount)))
                                                {
                                                        eip[0] = parseInt(lanip3) - 1;
                                                        sip[1] = parseInt(lanip3) + 1;
                                                        eip[1] = parseInt(sip[1]) + parseInt(ucount) - (parseInt(eip[0]) - parseInt(sip[0])) - 2;
                                                        set2 = true; 
                                                }
                                                else 
                                                        eip[0] = parseInt(sip[0]) + parseInt(ucount) - 1;
                                        }
                                }                       
                                break;          
                        }
                }
        }
        
        if((!set2 && (parseInt(sip[0]) + parseInt(ucount)) > (et - 1)) 
                        || (set2 && (parseInt(sip[0]) + parseInt(ucount) + 1) > (et - 1)))
        {
                alert(errmsg.err2);
                document.getElementById("DymRange").innerHTML = "";     
                return;
        }
 
//        document.getElementById("DymRange").innerHTML = I.lan_ipaddr_0.value + "." + I.lan_ipaddr_1.value + "." + I.lan_ipaddr_2.value + "." + sip[0] + " to " + eip[0];        
	document.getElementById("DymRange").innerHTML =	"<% prefix_ip_get("lan_ipaddr",1); %> "+ sip[0] + " "+portforward.to+" " + eip[0];
        if (set2 == true)
        {
//                document.getElementById("DymRange").innerHTML += "<BR>" + I.lan_ipaddr_0.value + "." + I.lan_ipaddr_1.value + "." + I.lan_ipaddr_2.value + "." + sip[1] + " to " + eip[1];
		document.getElementById("DymRange").innerHTML += "<BR>" +"<% prefix_ip_get("lan_ipaddr",1); %> "+ sip[1] + " "+portforward.to+" " + eip[1];
        }
        
        I.dhcp_num.value = ucount;
	if(I.dhcp_start.value != sip[0])
	        I.dhcp_start_tmp.value = sip[0];
 
}

<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
function selpptpmode(I)
{
	var F = document.setup ; 
	var len = F.elements.length;
	var start ; 
	var end ; 
	var i ; 
	
	for(i=0; i<len; i++)
	{
		if(F.elements[i].name=="wan_ipaddr") start = i ; 
		if(F.elements[i].name=="wan_pptp_dns2_3") end = i ; 
	}
	if ( start == '' || end == '') return true ; 
	for(i=start; i<=end; i++)
	{
		if ( I == 0 ) 
			choose_enable(F.elements[i]);
		else
			choose_disable(F.elements[i]);
	}

	if ( I == 0 ) 
		disable_second_dns();
	else
		enable_second_dns();
}

function valid_wan_ip(F)
{
	var arrLanMask = new Array(4);
	arrLanMask = F.lan_netmask.options[F.lan_netmask.selectedIndex].value.split(".");
	
	if((F.now_proto.value == "pptp" && F.sel_pptp_dhcp[1].checked == true) || F.now_proto.value == "static")
	{
		if(((F.lan_ipaddr_0.value & arrLanMask[0]) == (F.wan_ipaddr_0.value & arrLanMask[0])) 
			&& ((F.lan_ipaddr_1.value & arrLanMask[1]) == (F.wan_ipaddr_1.value & arrLanMask[1]))
			&& ((F.lan_ipaddr_2.value & arrLanMask[2]) == (F.wan_ipaddr_2.value & arrLanMask[2]))
			&& ((F.lan_ipaddr_3.value & arrLanMask[3]) == (F.wan_ipaddr_3.value & arrLanMask[3])))
		{
			alert(errmsg.err74);
			return true;
		}	
	}
	if(F.now_proto.value == "pptp")
	{
		if(((F.lan_ipaddr_0.value & arrLanMask[0]) == (F.pptp_server_ip_0.value & arrLanMask[0])) 
			&& ((F.lan_ipaddr_1.value & arrLanMask[1]) == (F.pptp_server_ip_1.value & arrLanMask[1]))
			&& ((F.lan_ipaddr_2.value & arrLanMask[2]) == (F.pptp_server_ip_2.value & arrLanMask[2]))
			&& ((F.lan_ipaddr_3.value & arrLanMask[3]) == (F.pptp_server_ip_3.value & arrLanMask[3])))
		{
			alert(errmsg.pptpservererr);
			return true;
		}
	}
	if(F.now_proto.value == "l2tp")
	{
		if(((F.lan_ipaddr_0.value & arrLanMask[0]) == (F.l2tp_server_ip_0.value & arrLanMask[0])) 
			&& ((F.lan_ipaddr_1.value & arrLanMask[1]) == (F.l2tp_server_ip_1.value & arrLanMask[1]))
			&& ((F.lan_ipaddr_2.value & arrLanMask[2]) == (F.l2tp_server_ip_2.value & arrLanMask[2]))
			&& ((F.lan_ipaddr_3.value & arrLanMask[3]) == (F.l2tp_server_ip_3.value & arrLanMask[3])))
		{
			alert(errmsg.l2tpservererr);
			return true;
		}
	}
	return false;
}

function getall(F,I)
{
        var i , data=""; 
        for(i=0; i<4; i++)
        {
                data = data + eval(I+"_"+i).value ; 
                if ( i < 3 ) data = data + "." ; 
        }
        return data ; 
}
 
function getall_dns(F,I)
{
        var i , data=""; 
        for(i=0; i<4; i++)
        {
                data = data + eval(I+"_"+i+"[0]").value ; 
                if ( i < 3 ) data = data + "." ; 
        }
        return data ; 
}

function valid_same_dns(F,N0,N1,N2)
{
    var dns0, dns1, dns2;
    dns0 = getall_dns(F,N0);
    dns1 = getall_dns(F,N1);
    dns2 = getall_dns(F,N2);
 
    if(dns1 == dns0)
    {
        //alert("dns1 == dns0!!");
        for(i=0;i<4;i++)
            eval(N1+"_"+i+"[0]").value = 0;
    }
  
    if(dns2 == dns0)
    {
        //alert("dns2 == dns0!!");
        for(i=0;i<4;i++)
            eval(N2+"_"+i+"[0]").value = 0;
    }
 
    if(dns2 == dns1)
    {
        //alert("dns2 == dns0!!");
        for(i=0;i<4;i++)
            eval(N2+"_"+i+"[0]").value = 0;
    }
 
}

function valid_same_dns_ex(F,N0,N1,N2)
{
    var dns0, dns1, dns2;
    dns0 = getall(F,N0);
    dns1 = getall(F,N1);
    dns2 = getall(F,N2);
 
    if(dns1 == dns0)
    {
        //alert("dns1 == dns0!!");
        for(i=0;i<4;i++)
            eval(N1+"_"+i).value = 0;
    }
  
    if(dns2 == dns0)
    {
        //alert("dns2 == dns0!!");
        for(i=0;i<4;i++)
            eval(N2+"_"+i).value = 0;
    }
 
    if(dns2 == dns1)
    {
        //alert("dns2 == dns0!!");
        for(i=0;i<4;i++)
            eval(N2+"_"+i).value = 0;
    }
 
}

function valid_ip_for_dns(F,N,M1,flag){
    var m = new Array(4);
    M = unescape(M1);
 
    for(i=0;i<4;i++)
        m[i] = eval(N+"_"+i).value
 
    if(m[0] == 127 || m[0] == 224){
	alert(M + " : " + errmsg.err31);
        return false;
    }
    if(m[0] == "0" && (m[1] != "0" || m[2] != "0" || m[3] != "0"))
    {
		alert(M + " : " + errmsg.err31);
                return false;
    }
    if(m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0"){
        if(flag & ZERO_NO){
		alert(errmsg.staticnodns);
            return false;
        }       
    }
 
    if((m[0] != "0" || m[1] != "0" || m[2] != "0") && m[3] == "0"){
        if(flag & MASK_NO){
		alert(M + " : " + errmsg.err31);
            return false;
        }       
    }
    return true;
}

<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>

function valid_ip_for_dns_ex(F,N,M1,flag){
    var m = new Array(4);
    M = unescape(M1);
    for(i=0;i<4;i++)
	{
        m[i] = document.getElementById(N+i).value;
 	}

    if(m[0] == 127 || m[0] == 224){
		alert(M + " : " + errmsg.err31);
		return false;
    }
    if(m[0] == "0" && (m[1] != "0" || m[2] != "0" || m[3] != "0"))
    {
		alert(M + " : " + errmsg.err31);
                return false;
    }
    if(m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0"){
        if(flag & ZERO_NO){
		alert(errmsg.staticnodns);         
		return false;
        }
    }
 
    if((m[0] != "0" || m[1] != "0" || m[2] != "0") && m[3] == "0"){
        if(flag & MASK_NO){
		alert(M + " : " + errmsg.err31);
		return false;
        }       
    }
 
    return true;
}

function SelLang(num,F)
{
	F.submit_button.value = "index";
	F.change_action.value = "gozila_cgi";
	F.submit_type.value = "language";
<% support_match("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "/*"); %>
    F.ui_language.value=F.ui_language.options[num].value;
<% support_match("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "*/"); %>
<% support_invmatch("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "/*"); %>
    F.detect_lang.value=F.detect_lang.options[num].value;
<% support_invmatch("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "*/"); %>
	F.submit();
      	
}

function exit()
{
	if (DHCPRef)
		DHCPRef.close();
}

</SCRIPT>
</HEAD>
<BODY onload=init() onunload=exit()>
<FORM name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=action>
<input type=hidden name=now_proto value='<% nvram_gozila_get("wan_proto"); %>'>
<input type=hidden name=daylight_time value=0>
<input type=hidden name=switch_mode_dhcp value=<% nvram_get("switch_mode_dhcp");%>>
<input type=hidden name=switch_mode value=<% nvram_gozila_get("switch_mode");%>>
<input type=hidden name="switch_ipaddr" value="4">
<input type=hidden name=hnap_devicename value=<% nvram_get("hnap_devicename");%>>
<input type=hidden name="need_reboot" value="0">
<input type=hidden name=user_language>
<input type=hidden name="wait_time" value="0">
<input type=hidden name=dhcp_start value=<% nvram_get("dhcp_start");%>>
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "<!--"); %>
<input type=hidden name=dhcp_start_conflict value=0>
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "-->"); %>
<input type=hidden name="lan_ipaddr" value="4">
<input type=hidden name=ppp_demand_pppoe value="9">
<input type=hidden name=ppp_demand_pptp value="9">
<input type=hidden name=ppp_demand_l2tp value="9">
<input type=hidden name=ppp_demand_hb value="9">
<input type=hidden name=wan_ipv6_proto>
<% nvram_invmatch("wan_ipv6_proto", "tunnel", "<!--"); %>
<input type=hidden name=tunnel_status value="connecting">
<% nvram_invmatch("wan_ipv6_proto", "tunnel", "-->"); %>
 

<% web_include_file("Top.asp");%>
<% web_include_file("Fun.asp");%>
<TABLE class=TITLE_MAIN cellspacing=0>
<TR><TD class=NOSPACE>
	<TABLE class=FUNCTION_MAIN cellspacing=0>
<!-- Begin Multi lang 2008-4-11 wuzhihua -->
			
		<TR><script>draw_table(MAINFUN,adtopmenu.lang);</script></TR>
		<TR><script>draw_table(SUBFUN,adtopmenu.selan)</script>
		<TD colspan=2 class=FUNNAME1>
<% support_match("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "<!--"); %>
		  <select name="ui_language" onChange=SelLang(this.form.ui_language.selectedIndex,this.form)>
<option value="en" <% nvram_match("ui_language", "en", "selected"); %>><script>Capture(lang.en)</script></option>
<option value="frc" <% nvram_match("ui_language", "frc", "selected"); %>><script>Capture(lang.frc)</script></option>
<option value="fr" <% nvram_match("ui_language", "fr", "selected"); %>><script>Capture(lang.fr)</script></option>
<option value="de" <% nvram_match("ui_language", "de", "selected"); %>><script>Capture(lang.de)</script></option>
<option value="es" <% nvram_match("ui_language", "es", "selected"); %>><script>Capture(lang.es)</script></option>
<option value="it" <% nvram_match("ui_language", "it", "selected"); %>><script>Capture(lang.it)</script></option>
<option value="nl" <% nvram_match("ui_language", "nl", "selected"); %>><script>Capture(lang.nl)</script></option>
<option value="pt" <% nvram_match("ui_language", "pt", "selected"); %>><script>Capture(lang.pt)</script></option>
<option value="se" <% nvram_match("ui_language", "se", "selected"); %>><script>Capture(lang.se)</script></option>
<option value="ru" <% nvram_match("ui_language", "ru", "selected"); %>><script>Capture(lang.ru)</script></option>
<option value="pl" <% nvram_match("ui_language", "pl", "selected"); %>><script>Capture(lang.pl)</script></option>
<option value="tr" <% nvram_match("ui_language", "tr", "selected"); %>><script>Capture(lang.tr)</script></option>
<option value="ar" <% nvram_match("ui_language", "ar", "selected"); %>><script>Capture(lang.ar)</script></option>
<% support_match("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "-->"); %>
<% support_invmatch("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "<!--"); %>
          <select name="detect_lang" onChange=SelLang(this.form.detect_lang.selectedIndex,this.form)>
<option value="EN" <% nvram_match("detect_lang", "EN", "selected"); %>><script>Capture(lang.en)</script></option>
<option value="CA" <% nvram_match("detect_lang", "CA", "selected"); %>><script>Capture(lang.frc)</script></option>
<option value="FR" <% nvram_match("detect_lang", "FR", "selected"); %>><script>Capture(lang.fr)</script></option>
<option value="DE" <% nvram_match("detect_lang", "DE", "selected"); %>><script>Capture(lang.de)</script></option>
<option value="SP" <% nvram_match("detect_lang", "SP", "selected"); %>><script>Capture(lang.es)</script></option>
<option value="IT" <% nvram_match("detect_lang", "IT", "selected"); %>><script>Capture(lang.it)</script></option>
<option value="NL" <% nvram_match("detect_lang", "NL", "selected"); %>><script>Capture(lang.nl)</script></option>
<option value="PT" <% nvram_match("detect_lang", "PT", "selected"); %>><script>Capture(lang.pt)</script></option>
<option value="SW" <% nvram_match("detect_lang", "SW", "selected"); %>><script>Capture(lang.se)</script></option>
<option value="RU" <% nvram_match("detect_lang", "RU", "selected"); %>><script>Capture(lang.ru)</script></option>
<option value="PL" <% nvram_match("detect_lang", "PL", "selected"); %>><script>Capture(lang.pl)</script></option>
<option value="TR" <% nvram_match("detect_lang", "TR", "selected"); %>><script>Capture(lang.tr)</script></option>
<option value="AR" <% nvram_match("detect_lang", "AR", "selected"); %>><script>Capture(lang.ar)</script></option>
<% support_invmatch("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "-->"); %>
</select></TD>
	  </TR>
<TR><script>draw_table(ISHR,"");</script></TR>
<!-- End Multi lang 2008-4-11 wuzhihua -->
		<TR><script>draw_table(MAINFUN,lefemenu.intersetup);</script></TR>
		<TR><script>draw_table(SUBFUN,lefemenu.conntype)</script>
		<TD colspan=2 class=FUNNAME1><SELECT name="wan_proto" onChange=SelWAN(this.form.wan_proto.selectedIndex,this.form) >
<script>
	var NAME;
	var STRING;
	 if("<%nvram_get("boot_hw_model");%>" == "E1500"){
			NAME = new Array("dhcp", "static", "pppoe", "pptp", "<% support_match("L2TP_SUPPORT", "1", "l2tp"); %>", "<% support_match("L2TP_SUPPORT", "1", "heartbeat"); %>","bridge");
			STRING = new Array(setupcontent.dhcp, share.staticip, share.pppoe, share.pptp, hstatrouter2.l2tp, hindex2.telstra,share.bridge);
			}
	else
 			{
			NAME = new Array("dhcp", "static", "pppoe", "pptp", "<% support_match("L2TP_SUPPORT", "1", "l2tp"); %>", "<% support_match("L2TP_SUPPORT", "1", "heartbeat"); %>", "bridge", "dslite");
			STRING = new Array(setupcontent.dhcp, share.staticip, share.pppoe, share.pptp, hstatrouter2.l2tp, hindex2.telstra,share.bridge, share.dslite);
		}
			var wan_proto = '<% nvram_selget("wan_proto"); %>';
			var selected;
			var smode = '<% nvram_gozila_get("switch_mode"); %>';
			if(smode==0)
			{
					for(i=0;i<NAME.length;i++) {
							if(wan_proto == NAME[i]) selected = "selected";
							else                       selected = "";
							if(NAME[i] == "")       continue;
							document.write("<OPTION value="+NAME[i]+" "+selected+">"+STRING[i]+"</OPTION>");
					}
			}
			else
			{
					for(i=0;i<NAME.length;i++) {
							if("bridge" == NAME[i]) selected = "selected";
							else                       selected = "";
							if(NAME[i] == "")       continue;
							document.write("<OPTION value="+NAME[i]+" "+selected+">"+STRING[i]+"</OPTION>");
					}                       
			}			
		</script>
</SELECT></TD>
</TR>
<% show_index_setting(); %>
<TR><script>draw_table(ISHR,"");</script></TR>
<% show_index_optional(); %>
<TR><script>draw_table(MAINFUN,lefemenu.netsetup);</script></TR>
<TR><script>draw_table(SUBFUN,lefemenu.routerip);</script>


<%show_index_routermode_setting();%>
<!--TR>
          <TD align=right width=156 bgColor=#e7e7e7 colSpan=3 height=25><B>Time Setting</B></TD>
          <TD width=8 background=image/UI_04.gif height=25>&nbsp;</TD>
          <TD colSpan=3 height=25>&nbsp;</TD>
          <TD width=123 height=25><input type=radio name=time_mode>Manually</TD>
          <TD width=290 height=25>&nbsp;</TD>  
          <TD width=13 height=25>&nbsp;</TD>
          <TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD></TR>
        <TR>
          <TD width=156 bgColor=#e7e7e7 colSpan=3 height=25></TD>
          <TD width=8 background=image/UI_04.gif height=25>&nbsp;</TD>
          <TD colSpan=3 height=25>&nbsp;</TD>
          <TD width=123 height=25><FONT style="FONT-SIZE: 8pt" 
            face=Arial>&nbsp;Date:</FONT></TD>
          <TD width=290 height=25>&nbsp;<font face="Arial" style="font-size: 8pt">
                	<INPUT class=num maxLength=4 size=4 name="year" value="<% show_time_setting("year","0"); %>" style="font-family:Courier; font-size:10pt">&nbsp;-&nbsp;
                	<INPUT class=num maxLength=3 size=3 name="mon" value="<% show_time_setting("mon","0"); %>" style="font-family:Courier; font-size:10pt">&nbsp;-&nbsp;
                	<INPUT class=num maxLength=3 size=3 name="mday" value="<% show_time_setting("mday","0"); %>" style="font-family:Courier; font-size:10pt">&nbsp;
                	(yyyy-mm-dd)</font></TD>
          <TD width=13 height=25>&nbsp;</TD>
          <TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD></TR>
        <TR>
          <TD width=156 bgColor=#e7e7e7 colSpan=3 height=25></TD>
          <TD width=8 background=image/UI_04.gif height=25>&nbsp;</TD>
          <TD colSpan=3 height=25>&nbsp;</TD>
          <TD width=123 height=25><FONT style="FONT-SIZE: 8pt" 
            face=Arial>&nbsp;Time:</FONT></TD>
          <TD width=290 height=25>&nbsp;<font face="Arial" style="font-size: 8pt">
                	<INPUT class=num maxLength=3 size=3 name="hour" value="<% show_time_setting("hour","0"); %>" style="font-family:Courier; font-size:10pt">:&nbsp;
                	<INPUT class=num maxLength=3 size=3 name="min" value="<% show_time_setting("min","0"); %>" style="font-family:Courier; font-size:10pt">:&nbsp;
                	<INPUT class=num maxLength=3 size=3 name="sec" value="<% show_time_setting("sec","0"); %>" style="font-family:Courier; font-size:10pt">&nbsp;(hh-mm-ss)	</font></TD>
          <TD width=13 height=25>&nbsp;</TD>
          <TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD></TR>
        <TR>
          <TD width=156 bgColor=#e7e7e7 colSpan=3 height=1>&nbsp;</TD>
          <TD width=8 background=image/UI_04.gif height=1>&nbsp;</TD>
          <TD colSpan=6>
            <TABLE>
              <TBODY>
              <TR>
                <TD width=16 height=1>&nbsp;</TD>
                <TD width=13 height=1>&nbsp;</TD>
                <TD width=410 colSpan=3 height=1>
                  <HR color=#b5b5e6 SIZE=1>
                </TD>
                <TD width=15 height=1>&nbsp;</TD></TR></TBODY></TABLE></TD>
          <TD width=15 background=image/UI_05.gif height=1>&nbsp;</TD></TR>
        <TR>
          <TD align=right width=156 bgColor=#e7e7e7 colSpan=3 height=25><B>Time Setting</B></TD>
          <TD width=8 background=image/UI_04.gif height=25>&nbsp;</TD>
          <TD colSpan=3 height=25>&nbsp;</TD>
          <TD width=123 height=25><input type=radio name=time_mode checked value="1">Automatically</TD>
          <TD width=290 height=25>&nbsp;</TD>  
          <TD width=13 height=25>&nbsp;</TD>
          <TD width=15 background=image/UI_05.gif height=25>&nbsp;</TD></TR-->
		  
		  	  
		  <TR><script>draw_table(MAINFUN,lefemenu.timeset);</script></TR>
		  <TR><script>draw_table(SUBFUN,share.timezone)</script>
		<TD colspan=2 class=FUNNAME1>&nbsp;<select name="time_zone" onChange=SelTime(this.form.time_zone.selectedIndex,this.form) >
<option value="-12 1 0" <% nvram_match("time_zone", "-12 1 0", "selected"); %>><script>Capture(timezone.Kwajalein)</script></option>
<option value="-11 1 0" <% nvram_match("time_zone", "-11 1 0", "selected"); %>><script>Capture(timezone.Midway)</script></option>
<option value="-10 1 0" <% nvram_match("time_zone", "-10 1 0", "selected"); %>><script>Capture(timezone.Hawaii)</script></option>
<option value="-09 1 1" <% nvram_match("time_zone", "-09 1 1", "selected"); %>><script>Capture(timezone.Alaska)</script></option>
<option value="-08 1 1" <% nvram_match("time_zone", "-08 1 1", "selected"); %>><script>Capture(timezone.Pacific)</script></option>
<option value="-07 1 0" <% nvram_match("time_zone", "-07 1 0", "selected"); %>><script>Capture(timezone.Arizona)</script></option>
<option value="-07 2 1" <% nvram_match("time_zone", "-07 2 1", "selected"); %>><script>Capture(timezone.Mountain)</script></option>
<option value="-06 1 6" <% nvram_match("time_zone", "-06 1 6", "selected"); %>><script>Capture(timezone.Mexico)</script></option>
<option value="-06 2 1" <% nvram_match("time_zone", "-06 2 1", "selected"); %>><script>Capture(timezone.Central)</script></option>
<option value="-05 1 0" <% nvram_match("time_zone", "-05 1 0", "selected"); %>><script>Capture(timezone.Indiana)</script></option>
<option value="-05 2 1" <% nvram_match("time_zone", "-05 2 1", "selected"); %>><script>Capture(timezone.Eastern)</script></option>
<option value="-04 1 0" <% nvram_match("time_zone", "-04 1 0", "selected"); %>><script>Capture(timezone.Bolivia)</script></option>
<option value="-04 2 1" <% nvram_match("time_zone", "-04 2 1", "selected"); %>><script>Capture(timezone.Atlantic)</script></option>
<option value="-03.5 1 1" <% nvram_match("time_zone", "-03.5 1 1", "selected"); %>><script>Capture(timezone.Newfoundland)</script></option>
<option value="-03 1 0" <% nvram_match("time_zone", "-03 1 0", "selected"); %>><script>Capture(timezone.Guyana)</script></option>
<option value="-03 2 1" <% nvram_match("time_zone", "-03 2 1", "selected"); %>><script>Capture(timezone.Brazil)</script></option>
<option value="-02 1 2" <% nvram_match("time_zone", "-02 1 2", "selected"); %>><script>Capture(timezone.Mid)</script></option>
<option value="-01 1 2" <% nvram_match("time_zone", "-01 1 2", "selected"); %>><script>Capture(timezone.Azores)</script></option>
<option value="+00 1 0" <% nvram_match("time_zone", "+00 1 0", "selected"); %>><script>Capture(timezone.Gambia)</script></option>
<option value="+00 2 2" <% nvram_match("time_zone", "+00 2 2", "selected"); %>><script>Capture(timezone.England)</script></option>
<option value="+01 1 0" <% nvram_match("time_zone", "+01 1 0", "selected"); %>><script>Capture(timezone.Tunisia)</script></option>
<option value="+01 2 2" <% nvram_match("time_zone", "+01 2 2", "selected"); %>><script>Capture(timezone.France)</script></option>
<option value="+02 1 0" <% nvram_match("time_zone", "+02 1 0", "selected"); %>><script>Capture(timezone.South)</script></option>
<option value="+02 2 2" <% nvram_match("time_zone", "+02 2 2", "selected"); %>><script>Capture(timezone.Greece)</script></option>
<option value="+03 1 0" <% nvram_match("time_zone", "+03 1 0", "selected"); %>><script>Capture(timezone.Iraq)</script></option>
<option value="+04 1 0" <% nvram_match("time_zone", "+04 1 0", "selected"); %>><script>Capture(timezone.Armenia)</script></option>
<option value="+05 1 0" <% nvram_match("time_zone", "+05 1 0", "selected"); %>><script>Capture(timezone.Pakistan)</script></option>
<option value="+05.5 1 0" <% nvram_match("time_zone", "+05.5 1 0", "selected"); %>><script>Capture(timezone.india)</script></option>
<option value="+06 1 0" <% nvram_match("time_zone", "+06 1 0", "selected"); %>><script>Capture(timezone.Bangladesh)</script></option>
<option value="+07 1 0" <% nvram_match("time_zone", "+07 1 0", "selected"); %>><script>Capture(timezone.Thailand)</script></option>
<option value="+08 1 0" <% nvram_match("time_zone", "+08 1 0", "selected"); %>><script>Capture(timezone.China)</script></option>
<option value="+08 2 0" <% nvram_match("time_zone", "+08 2 0", "selected"); %>><script>Capture(timezone.Singapore)</script></option>
<option value="+09 1 0" <% nvram_match("time_zone", "+09 1 0", "selected"); %>><script>Capture(timezone.Japan)</script></option>
<option value="+10 1 0" <% nvram_match("time_zone", "+10 1 0", "selected"); %>><script>Capture(timezone.Guam)</script></option>
<option value="+10 2 4" <% nvram_match("time_zone", "+10 2 4", "selected"); %>><script>Capture(timezone.Australia)</script></option>
<option value="+11 1 0" <% nvram_match("time_zone", "+11 1 0", "selected"); %>><script>Capture(timezone.Solomon)</script></option>
<option value="+12 1 0" <% nvram_match("time_zone", "+12 1 0", "selected"); %>><script>Capture(timezone.Fiji)</script></option>
<!--John@2008.05.27-->
<option value="+12 2 3" <% nvram_match("time_zone", "+12 2 3", "selected"); %>><script>Capture(timezone.New_Zealand)</script></option>
</select></TD></TR>
<TR><script>draw_table(SUBFUN,"")</script>
		<TD colspan=2 class=FUNNAME1><INPUT type=checkbox value="1" name="_daylight_time" <% nvram_match("daylight_time","1","checked"); %>><font face="Arial" style="font-size: 8pt"><script>Capture(setupcontent.autoadjtime)</script></font></TD></TR>

<TR><script>draw_table(ISHR,"");</script></TR>
<TR><script>draw_table(MAINFUN,sbutton.reboot);</script></TR>
<TR><script>draw_table(SUBFUN,"")</script>
		<TD colspan=2 class=FUNNAME1><script>document.write("<input type=button name=btn_reboot value='" + sbutton.reboot + "' onclick=reboot(document.setup)>");</script></TD></TR>

        <TR><script>draw_table(ISBLANK,"");</script></TR>
</TABLE>
</TD>
<script>draw_table(ISHELP,"");</script> 
</TR></TABLE>
<TABLE class=TITLE_MAIN cellspacing=0>
<TR><TD class=NOSPACE>
	<TABLE class=FUNCTION_MAIN cellspacing=0>
<TR><script>draw_table(ISTAIL,"");</script></TR>
<TR>
	    <TD class=TITLE1 colspan=2></TD>
	    <TD class=FUNNAME4 colspan=2>
		<script>
			draw_bottom("",sbutton.save);
			draw_bottom("index.asp",sbutton.cancel);
		</script>
	    </TD>    
	    <TD class=HELP2></TD>
</TR>
</TABLE>
</TD></TR></TABLE>
</FORM></BODY></HTML>
