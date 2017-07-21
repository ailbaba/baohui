<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="i18n" uri="/WEB-INF/tld/i18n.tld"%>
<%@ include file="sessionCheck.jsp"%>
 <%
	response.addHeader("Access-Control-Allow-Origin", "http://www.51qqt.com");
   	response.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
   	response.addHeader("Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	//正式环境
	//String basePath="http://www.51qqt.com"+path + "/";
	String version = "0.0.2";
	// 获取客户端IP地址
	String ip = request.getHeader("x-forwarded-for");
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<title>ELS互联网企业解决方案</title>
<link rel="icon" href="images/logo.ico" />
<link rel="shortcut icon" href="images/logo.ico" />
      <script>
	      var jsLang  ={};
	      try {
		      jsLang = JSON.parse(localStorage.getItem('bLang'));
		   }catch (e){
		      console.log('')
	      }
      </script>
		<script type="text/javascript" src="js/jquery-1.8.2.min.js?version=<%=version%>"></script>
		<script type="text/javascript" src="js/jquery.messager.js?version=<%=version%>"></script>
		<script src="js/common.js" type="text/javascript"></script>
        <!--[if lt IE 7]>
 			<style type="text/css">
 				div, img { behavior: url(js/iepngfix.htc) }
 			</style>
		<![endif]-->
	 <script type="text/javascript"  src="message/notice.js?version=<%=version%>"></script> 
	<script type="text/javascript"   src="js/comet4j.js?version=<%=version%>"></script> 
	<script type="text/javascript"   src="message/messageListener.js?version=<%=version%>"></script>
<!-- 	<script language="javascript" type="text/javascript" src="https://pv.sohu.com/cityjson?ie=utf-8">
	</script>  
	<script >
		var elsDeskTop= elsDeskTop||{};
		elsDeskTop.loginStore = $.extend({},elsDeskTop.loginStore,{ip:returnCitySN.cip});
	</script>-->
    <script type="text/javascript" src="lib/js/elsDeskTop/elsDeskTopBase.js?version=<%=version%>"></script>
    <script type="text/javascript" src="lib/js/elsDeskTop/elsDesktopInit.js?version=<%=version%>"></script>
    <!--[if IE 6]> <script type="text/javascript" src="lib/js/jquery/DD_belatedPNG_0.0.8a.js" ></script> <script type="text/javascript">
    DD_belatedPNG.fix('.dock_middle,.dock_pos_right #start_item .item li b,#shizhong_btn,#weather_btn,#showZm_btn,#them_btn,#start_btn,#start_item,#start_item .item li:hover,#start_item .item li span,#start_item .item li b,#start_item .childItem,#default_app .btnOver,.dock_drag_effect,.myWidget,.innerWidgetTitle,.widgetClose,.widgetClose:hover,.ui_boxyClose,.login_logo,#navBar s,#navBar span,#navBar span a,#navBar a.currTab,.indicator_header,.indicator_manage,.desktop,#bottomBarBgTask,.taskItem,.taskItem:hover,.taskCurrent .taskItem:hover,.taskCurrent .taskItem ,.taskPreBox,.taskPre,.taskNextBox,.taskNext,.aMg_dock_container,.aMg_line_y,.aMg_folder_container,.aMg_close,.aMg_close:hover,#aMg_prev,#aMg_next,.folderInner .desktopIcon .icon .txInfo,.folderInner .hover');
</script><![endif]-->
<script>
function beforeFrameHtmlUnload(){
	return "----------------------------------------------\n提示：未保存的内容将会丢失\n----------------------------------------------";
}
</script>
	</head>
<body class="fullScreen" onbeforeunload='return (beforeFrameHtmlUnload && beforeFrameHtmlUnload())'>

<script type="text/javascript">
<!--
window.history.forward(1);
//--> 
//当前登录的账号
currentElsAccount='<%=session.getAttribute("elsAccount") %>';
elsAccount='<%=session.getAttribute("elsAccount") %>';
elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
username='<%=session.getAttribute("username") %>';
role='<%=session.getAttribute("role") %>';
companyShortName='<%=session.getAttribute("companyShortName") %>';	
language='<%=session.getAttribute("language") %>';	
logo='<%=session.getAttribute("logo") %>';	
elsDeskTop.loginStore.currentElsAccount=currentElsAccount;
elsDeskTop.loginStore.elsSubAccount=elsSubAccount;
elsDeskTop.loginStore.username=username;
elsDeskTop.loginStore.role=role;
elsDeskTop.loginStore.companyShortName=companyShortName;
elsDeskTop.loginStore.language=language;
elsDeskTop.loginStore.logo=logo;
window.onload = function() {
	//正式环境logo的完整地址
	window.logoPath = location.href.match(/https?:\/\/.*?\//)[0] + ('opt/nfsshare/'+logo||"icon/icon1.png");
	$('#navbarHeaderImg').attr('src',logoPath);
};
window.basicMessage = function(opt) {
	var id = opt.elsId|| opt.friendElsAccount;
	if(id){
		//return window.open('http://cs.51qqt.com/ELSSpace/ToBlog?elsAccount='+elsAccount);
		return;
	}
}
</script>
    <div id="desktopWrapper">
        <div id="topBar"></div>
        <div id="leftBar">
	        <div id="dockBar"></div>
            <div id="dockContainer" class="dock_container pin dock_pos_left">
	            <div class="pin-bar"></div>
                <div class="dock_middle">
                    <div id="default_app">
                    	<div class="default-app-part"></div>
                    	<div class="active-app-part"></div>
                    </div>
                    <div class="default_tools"> 
	                    <a href="javascript:void(0);" id="showZm_btn" title=<i18n:I18n key="i18n_js_full_screen" defaultValue="全屏(IE环境请直接按F11)"/>></a>
	                    <a href="javascript:void(0);" id="search_app_btn" title=<i18n:I18n key="i18n_js_search_app" defaultValue="查找应用"/>></a>
                    </div>
                    <div class="default_tools"> 
	                    <a href="javascript:void(0);" id="reset_btn" title=<i18n:I18n key="i18n_js_reset_app" defaultValue="恢复默认设置"/>></a>
	                    <a href="javascript:void(0);" id="them_btn" title=<i18n:I18n key="i18n_js_theme_set" defaultValue="主题设置"/>></a>
                    </div>
                    <div id="start_block"> <a title=<i18n:I18n key="i18n_js_begin_menu" defaultValue="开始菜单"/> id="start_btn"></a>
                        <div id="start_item">
                            <!-- <ul class="item admin">
                                <li><span class="adminImg"></span> PSSDSS</li>
                            </ul> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="rightBar"></div>
        <div class="dock_drag_effect dock_drag_effect_top" ></div>
        <div class="dock_drag_effect dock_drag_effect_left" ></div>
        <div class="dock_drag_effect dock_drag_effect_right" ></div>
        <div class="dock_drag_mask">
            <div name="top" class="dock_drop_region_top"></div>
            <div name="left" class="dock_drop_region_left"></div>
            <div name="right" class="dock_drop_region_right"></div>
        </div>
        <div id="desktopsContainer">
            <div id="desktopContainer"></div>
        </div>
        <div id="bottomBarBgTask" class="pin"></div>
        <div id="taskBlock" class="pin">
	        <div class="tray">
		        <i class="tray-msg"></i>
	        </div>
	        <div class="pin-bar"></div>
	        <div id="taskPreBox" class="taskPreBox"> <a href="javascript:void(0);" id="taskPre" class="taskPre"></a> </div>
            <div id="taskOuterBlock">
                <div id="taskInnnerBlock"> </div>
            </div>
	        <div class="taskNextBox" id="taskNextBox"> <a href="javascript:void(0);" class="taskNext" id="taskNext"></a> </div>
        </div>
        <div id="bottomBarMouseEnter">
        </div>
        <div id="navBar">
	        <div class="l">
		        <div class="indicator indicator_header" cmd="user" title=<i18n:I18n key="i18n_js_edit_personal_information" defaultValue="编辑个人资料"/> >
		        <img src="" alt="" class="indicator_header_img" id="navbarHeaderImg" onerror="this.src='icon/icon1.png';" />
	            </div>
            </div>
	        <span></span>
	        <div class="r">
		        <a class="indicator indicator_manage" href="javascript:void(0);" hidefocus="true" cmd="manage" title=<i18n:I18n key="i18n_js_global_view" defaultValue="全局视图"/>></a>
	        </div>
        </div>
	    <div id="wallpaper"></div>
	    <script  type="text/javascript">
		    if(window.localStorage) {
			    var getStoreSkin = localStorage.getItem('shinTheme');
			    if(getStoreSkin) {
				    var storeObj = JSON.parse(getStoreSkin);
				    var b = document.getElementById('wallpaper');
				    b.style.backgroundImage='url('+storeObj.bgImg+')';
				    b.style.backgroundSize = 'cover';
			    }
		    }
	    </script>
    </div>
    <div id="appManagerPanel" >
        <a class="aMg_close" href="javascript:void(0);"></a>
        <div class="aMg_dock_container"></div>
        <div class="aMg_line_x"></div>
        <div class="aMg_folder_container">
            <div class="aMg_folder_innercontainer"></div>
        </div>
        <a href="javascript:void(0);" id="aMg_prev"></a>
        <a href="javascript:void(0);" id="aMg_next"></a>
    </div>
    
    <script type="text/javascript">
    //新春祝福
    $(function() {	
    	$("head").append('<link rel="stylesheet" href="extend/xinchun/festival.css"  />');
    	$.ajax({
    		'cache':false,
    		'url':'/ELSServer/rest/restAPI/AccountOpenService/getBless/' + elsAccount + '/' + elsSubAccount+'/newYear2',
    		'success': function(data) {
    			if(data) {
    				$('.fixed-container').show();
    				var setAnimeTimer=setTimeout(function() {
    					if($(".xinchun .logo")[0]) {
    						$(".xinchun .logo").show().addClass("zoomInLeft");
    					}
    					if($(".xinchun .content")[0]) {
    						$(".xinchun .content").show().addClass("zoomInRight");
    					}
    					clearTimeout(setAnimeTimer);
    				},1000)
    				$('.fixed-container').click(function() {
    					$(this).hide();
    				})
    			} 
    			
    		},
    		'error':function() {}
    	});
    })
    </script>
 	<div class="fixed-container animated fadeIn">
 		<div class="xinchun animated bounceInUp">
 			<div class="animated  logo"></div>
 			<div class="title animated tada"></div>
 			<div class="animated  content">
 				<div class="txt">
	 				<p>感恩过去岁月，我们精诚合作，值此新春佳节到来之际，</p>
	 				<p><span class="blue">深圳市企企通科技有限公司CEO徐辉率全体员工</span></p>
	 				<p>祝尊敬的客户新春快乐！阖家幸福！祝贵公司生意兴隆,</p>
	 				<p>财源广进！2017，携手共赢未来、开创新的辉煌！</p>
 				</div>
    			<div class="new-year"></div>
 			</div>
 			<div class="xinchun shadow animated animateSnow "></div>
 		</div>
 	</div>
 	<div class="important-tip"></div>
       <script type="text/javascript" src="extend/publicPlugins/importantTip.js?version=<%=version %>"></script>
</body>
<%-- <script type="text/javascript" src="http://cs.51qqt.com/ELSServer_STA/extend/dialog/dist/dialog.js?version=<%=version%>"></script> --%>
<%-- 	<script type="text/javascript" src="http://cs.51qqt.com/ELSServer_STA/notice/showDialog.js?version=<%=version%>"></script> --%>
<%-- 	<script type="text/javascript" src="http://cs.51qqt.com/ELSServer_STA/notice/weixinCode.js?version=<%=version%>"></script> --%>
</html>