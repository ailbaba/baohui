<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<!--讨论区滚动条begin-->
	<link rel="stylesheet" type="text/css" href="css/jscrollpane1.css" />
	<script type="text/javascript" src="<%=basePath %>xheditor/xheditor-1.2.1.min.js"></script>
	<!--讨论区滚动条end-->
	<script type="text/javascript">
        toElsAccount=GetQueryString("toElsAccount");
        toElsSubAccount=GetQueryString("toElsSubAccount");
        businessType=GetQueryString("businessType");
        businessID=GetQueryString("businessID");
        function showContent(subH) {
        var html="";
        var data = {"fromElsAccount":elsAccount,"fromElsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"toElsSubAccount":toElsSubAccount,"businessType":businessType,"businessID":businessID,"fromStation":role};
        $.ajax({
            url : "rest/ChatMessageService/findMyChatMessage",
            type : "POST",
            contentType : "application/json",
            data : JSON.stringify(data),
            dataType : "json",
            success : function(data) {
                if(data && data.length) {
                    for (var i = 0; i < data.length; i++) {
                    if(data[i].fromElsAccount==elsAccount) {
                    	html+='<div class="text-right" style="margin-top: 6px;">';
                    	html+='<div class="text-center"><span>'+timeStamp2String(data[i].chatDateTime,language)+'</span></div>';
                        html+='<div class="pos-relative" style="width: 100%;min-height: 50px; margin-top:4px;"><div class="fl-right eContent-user me" >'+data[i].fromName+'</div>';
                        html+='<div class="fl-right eContent-content"><span class="dis-in-b eContent-main pos-relative mr-distance"><span class="dis-in-b pos-absolute dir-icon right rotate-180"></span>' +data[i].content+'</span></div><div class="clear-both"></div></div>';
                        html+='</div>';
                    } else {
                    	html+='<div class="text-left pos-relative" style="margin-top: 6px;">';
                    	html+='<div class="text-center"><span>'+timeStamp2String(data[i].chatDateTime,language)+'</span></div>';
                        html+='<div class="pos-relative" style="width: 100%;min-height: 50px; margin-top:4px;"><div class="fl-left eContent-user other">'+data[i].fromName+'</div>';
                        // html+='<div class="dis-in-b ">&nbsp;</div>';
                        html+='<div class="fl-left eContent-content"><span class="dis-in-b eContent-main pos-relative ml-distance"><span class="dis-in-b pos-absolute dir-icon left"></span>' +data[i].content+'</span></div><div class="clear-both"></div></div>';
                        html+='</div>';
                    }
                    
                    }
                }
                $("#jp-container").html(html);

                document.getElementById('jp-container').scrollTop = document.getElementById('jp-container').scrollHeight*2;
            },
            error : function(data) {
                console.log(data);
            }
        });
	      //自定义聊天区的高度,240是窗口头部与标题的高度当前聊天人的高度，20是预留距离表情的高度
	    	var th = $('body').height()-subH;
	    	$('.talk_record').css({'height': parseInt(th) + 'px'});
	    	$('.jp-container').css({'height': parseInt(th-20) + 'px'});
        }
        //获取iframe参数比较方法
        function getQueryStr(name) {
            var urlParams = window.location.href;
            console.log(urlParams);
            var args = urlParams.split("?");
            var str = args[1];
            args = str.split("&");
            for(var i = 0; i < args.length; i ++){
                var arg = args[i].split("=");
                if(arg[0] == name) {
                    return arg[1];
                }
            }
        }
        $(function() {
            console.log(decodeURI(getQueryStr('list')));
            // 初始化在线编辑器
        	var multiEdit = $('.xContent').xheditor({tools:'Emot,Bold,Italic,Underline,Strikethrough',skin:'default'});
        	multiEdit.focus();
        	multiEdit.addShortcuts('ctrl+enter',function() {
        		$('#send').trigger('click');
        	});
        	//输入区域高度调整 让表情可以完整显示
        	$(multiEdit.win.parent.document).find('.xheIframeArea').css('height','90px')
        	//自定义聊天区的高度//自定义聊天区的高度,240是上下窗口栏的高度与聊天窗口标题的高度，20是预留距离表情的高度
			var subH,th,
				people				= "",
				multiChatMode		= decodeURI(getQueryStr('type')) === 'multi',
				$btnCurrentPChart 	= $('.talk .btnCurrentPChart'),
				$currPChat			= $('.talk .currPChat');
				
			subH 	= multiChatMode ? 380 : 188;
        	th		= $('body').height()-subH;	
			
			$('.talk_record').css({'height': parseInt(th) + 'px'});
            $('.jp-container').css({'height': parseInt(th-20) + 'px'});
            $('button').button();
            
            $currPChat.niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'});
            var jpContainerNiceScroll=$('.jp-container').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'});
			
            if(multiChatMode) {
                var obj = JSON.parse(decodeURI(getQueryStr('list')));
                if(obj.list && obj.list.length) {
                    for(var i=0; i<obj.list.length; i++) {
                    people +='<p>'+obj.list[i].name+'</p>';
                    }
                }
                $currPChat.append(people);
            } else {
                $btnCurrentPChart.hide();
            }

            showContent(subH);
            window.setInterval(function(){
                showContent(subH);
                jpContainerNiceScroll.resize();
            }, 3500);
            
            $("#send").click(function(){
                var value=$("#chatMsg").val();
                if(value.length==0){
                    return;
                }
                
                
                var frm = $("#chatform");

                $("#content").val(value);
                $("#fromElsAccount").val(elsAccount);
                $("#fromElsSubAccount").val(elsSubAccount);
                $("#toElsAccount").val(toElsAccount);
                $("#toElsSubAccount").val(toElsSubAccount);
                $("#businessType").val(businessType);
                $("#businessID").val(businessID);
                $("#fromName").val(companyShortName+"_"+username);
                $("#fromStation").val(role);
                $("#companyShortName").val(companyShortName);

                var html="";


                 $.ajax({
                    url : "rest/ChatMessageService/sendMessage",
                    type : "POST",
                    contentType : "application/json",
                    data : JSON.stringify(frm.serializeJSON()),
                    dataType : "json",
                    success : function(data) {
						
                    	if(data.statusCode!=200)
                    		parent.elsDeskTop.tip.init({type: 'alert',message:data.message});
                        
                        
                        $("#chatMsg").val("");
                        showContent(subH);
                    },
                    error : function(data) {
                    	parent.elsDeskTop.tip.init({type: 'alert',message:'发送失败'});
                    }
                });
            });
			//多人聊天人员窗口展开收起
			$btnCurrentPChart.click(function(){
				if($btnCurrentPChart.hasClass('mmg-btnBackboardDn')){
					$currPChat.slideDown(300,function(){
						$btnCurrentPChart.removeClass('mmg-btnBackboardDn').addClass('mmg-btnBackboardUp');
					})	
				}else{
					$currPChat.slideUp(300,function(){
						$btnCurrentPChart.addClass('mmg-btnBackboardDn').removeClass('mmg-btnBackboardUp');
					})
				}
			});
        });
	</script>
	
	<div class="talk" style="width: 100%;height:100%;">
		<div class="ui-state-default talk_header" style="padding: 1px;display:none;">
            <div>
                <span style="padding-left: 6px;">聊天窗口</span>
				<a class="btnCurrentPChart mmg-btnBackboardDn"></a>
            </div>
        </div>
        <div class="currPChat" style="height: 100px; overflow-y: scroll;display:none;">
            <div class="cp_title">当前聊天</div>
        </div>
		<div class="talk_record" style="">
			<div id="jp-container" class="jp-container" style="width: 100%;overflow-y: scroll;overflow-x: hidden;">
	
			</div>
		</div>
		
		<form id="chatform">
			<input type="hidden" value="" id="fromElsAccount" name="fromElsAccount" />
			<input type="hidden" value=""  id="fromElsSubAccount" name="fromElsSubAccount" />
			<input type="hidden" value="" id="toElsAccount" name="toElsAccount" />
			<input type="hidden" value="" id="toElsSubAccount" name="toElsSubAccount" />
			<input type="hidden" value="" id="fromName" name="fromName" />
			<input type="hidden" value=""  id="fromStation" name="fromStation" />
			<input type="hidden" value="" id="companyShortName" name="companyShortName" />
			<input type="hidden" value="" id="content" name="content" />
			<input type="hidden" value="" id="businessType" name="businessType" />
			<input type="hidden" value="" id="businessID" name="businessID" />
			
		</form>
		
		<div class="">
			<textarea class="xContent" id="chatMsg" rows="4" cols="80" style="width: 100%; margin: 0 auto;"></textarea>
		</div>
        <div class="text-center" style=" margin: 10px 0 4px;height: 50px;line-height: 30px;padding: 0 6px;">
			<button id="send" class=" button-wrap"  >发送</button>
        	<div class="text-center"  >可通过Ctrl+enter键快捷发送信息</div>
        </div>
	</div>
</body>