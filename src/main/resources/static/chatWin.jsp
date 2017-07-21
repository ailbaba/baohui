<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<link rel="stylesheet" type="text/css" href="css/chat.css" />
<link href="css/smartMenu.css" rel="stylesheet"  type="text/css" />
<script type="text/javascript" src="js/chat.js"></script>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="js/jquery-powerFloat-min.js"></script>
<script type="text/javascript" src="js/jquery-smartMenu-min.js"></script>


<!--讨论区滚动条begin
<link rel="stylesheet" type="text/css" href="css/jscrollpane1.css" />
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>

<script type="text/javascript" src="js/jquery.mousewheel.js"></script>

<script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" src="js/scroll-startstop.events.jquery.js"></script>
讨论区滚动条end-->


<!--[if lt IE 7]>
<script src="js/IE7.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
<script src="js/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
EvPNG.fix('body, div, ul, img, li, input, a, span ,label'); 
</script>
<![endif]-->
</head>
<body >
<script type="text/javascript">


	toElsAccount=GetQueryString("toElsAccount");

	$(function() {
		
		showContent();
		
		window.setInterval(showContent, 2000); 
		
	function showContent(){
			
		
		
		var html="";
			
		 $.ajax({
				url : "rest/ChatMessageService/findMyChatMessage/"+elsAccount+"/"+elsSubAccount+"/"+toElsAccount+"?t="+new Date().getTime(),
				type : "GET",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					 for (var i = 0; i < data.length; i++) {
						html+="<font color='blue'><b>"+data[i].fromName+"</b>&nbsp;&nbsp;&nbsp;"+timeStamp2String(data[i].chatDateTime)+"</font><br>";
						html+="&nbsp;&nbsp;"+data[i].content+"<br>";
					}
					
					$("#chatMsg").val(html);  
					
					//$("#chatMsg").scrollTop(10000000);
					//document.getElementById("chatMsg").style.overflow='auto';
					//document.getElementById('chatMsg').scrollTop = document.getElementById('chatMsg').scrollHeight*2;
					
					
				},
				error : function(data) {
					
				}
			}); 
		}
		
		$("#send").click(function(){
			var value=$("#content").val();
			if(value.length==0){
				return;
			}
			var frm = $("#chatform");
			
			$("#fromElsAccount").val(elsAccount);
			$("#fromElsSubAccount").val(elsSubAccount);
			$("#toElsAccount").val(toElsAccount);
			
			$("#fromName").val(companyShortName+"_"+username);
			$("#fromStation").val(role);
			$("#companyShortName").val(companyShortName);
			
			var html="";
			
			
			 $.ajax({
				url : frm[0].action,
				type : frm[0].method,
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					
					$("#content").val("");
				},
				error : function(data) {
					
				}
			}); 
			
			
			
		});
		
		$("#clean").click(function(){
			
			$("#content").val("");
		});
		
		
		
	});
</script>
	

<div style="display:block; align:center;overflow:hidden; padding:0 5px; line-height:21px;">
	

				<form method="post" action="rest/ChatMessageService/sendMessage" id="chatform">
				
					
					
			
						<div class="unit">
					
							<textarea  class="xheditor-mini" id="chatMsg" name="chatMsg" rows="22" cols="60" tools="mini">
				
							
						
							
							
							
							 </textarea> 
						</div>
						<div class="unit">
						<input type="hidden" value="" id="fromElsAccount" name="fromElsAccount"></input>
						<input type="hidden" value=""  id="fromElsSubAccount" name="fromElsSubAccount"></input>
						<input type="hidden" value="" id="toElsAccount" name="toElsAccount"></input>
						
						<input type="hidden" value="" id="fromName" name="fromName"></input>
						<input type="hidden" value=""  id="fromStation" name="fromStation"></input>
						<input type="hidden" value="" id="companyShortName" name="companyShortName"></input>
						
							<textarea class="xheditor-simple" id="content" name="content" rows="8" cols="60"></textarea>
						</div>
						
						
						
					
					
				</form>
			
			
			
			
		
		
	

</div>
<br>
<p>
<input id="send" value="发&nbsp;&nbsp;送" type="button"></input>
<input id="clean" value="清&nbsp;&nbsp;空" type="button"></input>
</p>

<script type="text/javascript" src="xheditor/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="xheditor/xheditor-1.2.1.min.js"></script>
<script src="js/jquery.serializejson.js" type="text/javascript"></script>

