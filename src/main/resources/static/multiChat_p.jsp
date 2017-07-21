<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<!--讨论区滚动条begin-->
	<link rel="stylesheet" type="text/css" href="css/jscrollpane1.css" />
	<script type="text/javascript" src="<%=basePath %>xheditor/xheditor-1.2.1.min.js"></script>
	<!--讨论区滚动条end-->
	<script type="text/javascript">
		//报价、议价聊天窗口
		var 
			toElsAccount	= GetQueryString("toElsAccount"),
			toElsSubAccount	= GetQueryString("toElsSubAccount"),
			businessType	= GetQueryString("businessType"),
			businessID		= GetQueryString("businessID"),
			displayType     = GetQueryString('displayType'),
			orderType		= GetQueryString("orderType"),
			beginDate		= GetQueryString("beginDate"),
			endDate     	= GetQueryString('endDate'),
			sendType = 0,
			sendPeople = [],
			$body			= $('body'),
			talkDragOriginY = 'N',// 保存原始位置		
			talkDragOffsetY	= 0,// 消息窗口和消息发送窗口大小偏移
			filterAttrs		= [/^on/,/formaction/,/srcset/],//过滤标签属性
			bid,				// businessID后部分
			plist,				// 多人信息缓存				
			urlParams,			// 前窗口链接参数转换为JSON对象
			isMultiChat,		// bool 是否是多人聊天
			multiEdit,			// 富文本编辑器
			$mouseMoveMask,		// 聊天窗口鼠标拖动遮罩
			$btnCurrentPChart,	// 多人聊天展开收起窗口按钮
			$btnSend,			// 发送消息按钮
			$currPChat,			// 多人聊天容器
			$cpList,			// 多人聊天列表
			$subTitle,
			$talkRecord,		// 聊天记录窗口
			$talkDragBar,		// 工具栏上方拖动条
			$jpContainer,		// 消息记录窗口的消息容器
			$xContent,			// 富文本初始化目标
			$xheIframeArea,		// 富文本输入框容器
			//聊天窗口调整
			// opt {animate : 使用动画 , flag : 空 subH自动判断 / bool subH主动设定}
			resizeTalkWin = function(opt){
				opt = $.extend({animate: true},opt);
				var 
					flag = opt.flag,
					anim = opt.animate?'animate':'css',
					subH = $currPChat.is(':hidden')? 250 :350,
					reHeight;
				if(undefined!==flag)subH = flag ? 250 : 350;
				reHeight 	= $body.height()- subH -  talkDragOffsetY;
				$xheIframeArea[anim]({height : 100 + talkDragOffsetY + 'px'});
				$talkRecord[anim]({height : reHeight + 'px'})
				$jpContainer[anim]({height : reHeight + - 5 +'px'});
				if($currPChat.nScroll)$currPChat.nScroll.resize(); 
				$jpContainer.nScroll.resize();
			},
			showContent = function(){
				var list = $cpList.data('list');
				var sendType = 0;
				var sendPeople = [];
				var sendSubPeople = [];
				var data={};
				if(businessID && businessID.length && !displayType) {
					//报价聊天窗口获取内容参数
					var storBusiness = $.parseJSON(decodeURI(businessID));
					var storeSubAccount = $.parseJSON(decodeURI(toElsSubAccount));
					sendType = 1;
					if(list && list.length) {
						list.forEach(function(item,i){
							sendSubPeople.push(storeSubAccount[item]);
						});
					} else {
						sendPeople = [];
					}
					data = {
							"fromElsAccount"			: elsAccount,
							"fromElsSubAccount"			: elsSubAccount,
							"toElsAccount"				: toElsAccount,
							"toElsSubAccount"			: JSON.stringify(sendSubPeople),
							"businessType"				: businessType,
							"businessID"				: JSON.stringify(storBusiness),
							"fromStation"				: role
						};
				} else {
					//议价聊天窗口获取内容参数
					sendType = 0;
					var storeSubAccount = $.parseJSON(decodeURI(toElsSubAccount));
					if(list && list.length) {
						list.forEach(function(item,i){
							//sendPeople.push(plist[item]);
							sendPeople[i]=plist[item].name;
							sendSubPeople.push(storeSubAccount[item]);
						});
					}  else {
						sendPeople = [];
						sendSubPeople=[];
					}
					data = {
							"fromElsAccount"			: elsAccount,
							"fromElsSubAccount"			: elsSubAccount,
							"toElsAccount"				: JSON.stringify(sendPeople),
							"toElsSubAccount"			: displayType?JSON.stringify(sendSubPeople):'',
							"businessType"				: businessType,
							"businessID"				: businessID,
							"fromStation"				: role
						};
				}
				
				var 
					html ="",
					onSuccess = function() {
						var data = arguments[0];
						if(data && data.length) {
							var uniqueArray=[];
							for (var i = 0; i < data.length; i++) {
								var isMe = data[i].me? 'right' : 'left';
								if($.inArray(data[i].chatDateTime+"_"+data[i].content, uniqueArray)==-1){
									
								html+='<div class="pos-relative text-'+isMe+'" style="margin-top: 6px;">'
									+ '<div class="text-center" ><span class="eContent-time">'
									+ timeStamp2String(data[i].chatDateTime,language)
									+ '</span>'
									+ '</div><div class="pos-relative" style="width: 100%;min-height: 50px; margin-top:4px;">'
									+ '<div class="fl-'+isMe+' eContent-content">'
									+ '<span class="fl-'+isMe+' eContent-user" >'
									+ data[i].fromName
									+ '</span>'
									+'<div class="clear"></div>'
									+ '<span class="dis-in-b eContent-main pos-relative">'
									+ '<span class="dis-in-b pos-absolute dir-icon '+isMe+'"></span>' 
									+ data[i].content
									+'</span></div><div class="clear-both"></div></div></div>';
								}
								uniqueArray.push(data[i].chatDateTime+"_"+data[i].content);
							}
						}
						$("#jp-container").html(filterDOMString(html,filterAttrs));
						document.getElementById('jp-container').scrollTop = document.getElementById('jp-container').scrollHeight*2;
					},
					onError = function(){
						//console.log(arguments[0]);
					}
					//console.log(JSON.stringify(data));
					if(list && list.length) {
						$.ajax({
							url 			: "rest/ChatMessageService/findEnquiryChatMessage",
							type 			: "POST",
							contentType 	: "application/json",
							data 			: JSON.stringify(data),
							dataType 		: "json",
							success 		: onSuccess,
							error 			: onError
						});
					}
					
			},
			// 刷新多人聊天列表
			// TODO: 负责人是否唯一？ 
			// TODO: 负责人去重复
			refreshCurrPChatTitle = function(t){
				if(!t){
					var _d = $cpList.data('list');
					if(_d&&_d.length){
						_d=_d.map(function(a){
							return plist[a].name;
						});
						t=textClip(_d.join(',').replace(/,$/,''),20);
					}
				}
				$subTitle.text(t&&'['+t+']'||'');
			},
			refreshCurrPChat = function(){
				if(plist&&plist.length&&$cpList&&$cpList.length){
					$cpList.html('');
					for(var i=0; i<plist.length; i++) {
						$cpList.append(
							'<p data-p="'
							+ i
							+ '">'
							+ plist[i].name
							+ '</p>'
						);
					}
					$currPChat.nScroll = $currPChat.niceScroll({
						cursorcolor 	: "#ddd",
						cursorwidth 	: '2px'
					});
					$cpList.data('list',[]);
					$ps = $cpList.find('p');
					$ps.click(function(e){
// 						console.debug(e.target);
						e.stopPropagation();
						var $p = $(e.target);
						var _d = $cpList.data('list');
						if($p.hasClass('sel')){
							var i = _d.indexOf($p.attr('data-p'));
							if(i>-1)_d.splice(i,1);
							$p.removeClass('sel');
						}else{
							_d.push($p.attr('data-p'));
							$p.addClass('sel');
						}
						_d.sort();
						$cpList.data('list',_d);
						refreshCurrPChatTitle();
					});
					$ps.click();
					return;
				}
				refreshCurrPChatTitle(bid);
				if(bid)return;
			},
			
			//talk窗口拖动
			//by zwy
			//鼠标移动事件 
			onTalkMouseMove = function(e){
				if('N' === talkDragOriginY){
					talkDragOriginY = e.clientY;
				}else{
					// 边界判断
					var _talkDragOffsetY =talkDragOriginY- e.clientY;
					if(_talkDragOffsetY<300 && _talkDragOffsetY > -40){
						talkDragOffsetY = _talkDragOffsetY;
						resizeTalkWin({animate:false});
					}
				}
			},
			//鼠标弹起事件
			onTalkMouseStop = function(e){
				mouseMoveMaskStopListen();
			},
			//鼠标拖动区域添加监听
			mouseMoveMaskStartListen = function(e){
				$mouseMoveMask.on('mousemove',onTalkMouseMove);
				$mouseMoveMask.on('mouseup mouseleave',onTalkMouseStop);
				$mouseMoveMask.css('z-index',9999);
			},
			//鼠标拖动区域移除监听
			mouseMoveMaskStopListen = function (e){
				$mouseMoveMask.off('mousemove',onTalkMouseMove);
				$mouseMoveMask.off('mouseup mouseleave',onTalkMouseStop);
				$mouseMoveMask.css('z-index',-9999);
			},
			
			init = function(){
				$mouseMoveMask		= $('.mouse-move-mask');
				$xContent 			= $('.xContent');
				$btnCurrentPChart 	= $('.talk .btnCurrentPChart');
				$currPChat			= $('.talk .currPChat');
				$btnSend			= $('.talk #send');
				$talkRecord			= $('.talk .talk_record');
				$talkDragBar		= $('.talk_drag_bar');
				$jpContainer		= $('.talk .jp-container');
				$cpList				= $('.talk .cp_list');
				$subTitle			= $('.talk .subTitle');
				
				$jpContainer.nScroll = $jpContainer.niceScroll({
					cursorcolor 	: "#ddd",
					cursorwidth 	: '2px'
				});
				urlParams = $.parseJSON(
					decodeURIComponent(window.location.href)
						.replace(/.*?\?/g,'{"')
						.replace(/=/g,'":"').replace(/&/g,'","')
						.replace(/"{/g,'{').replace(/}"/g,'}')
						.replace(/"\[\{/g,'[{')
						.replace(/\}\]"/g,'}]')
						
						+'"}'
				);
				isMultiChat = 'multi' === urlParams.type;
				bid			= (businessID||'').split('_')[1];
				multiEdit 	= $xContent.xheditor({
					tools	:'Emot,Cut,Copy,Paste,Bold,Italic,Underline,Strikethrough',
					skin	:'default'
				});
				multiEdit.addShortcuts('ctrl+enter',function(){
					$btnSend.trigger('click');
				});
				$xheIframeArea	= $('.talk .xheIframeArea');
				resizeTalkWin();
				$btnSend.button();
				var $warnTip = $(definedDom('div',{
					class : 'btn-tip-warn',
					children : {tag:'span'}
				}));
				$btnSend.click(function(){
					$warnTip.remove();
					var text = multiEdit.getSource().replace(/^\s+|\s+$/g,'');
					if(!text.length){
						$warnTip.hide();
						$warnTip.find('span').text('发送内容不能为空，请重新输入');
						$btnSend.append($warnTip);
						$warnTip.fadeIn(300);
						setTimeout(function(){
							$warnTip.fadeIn(300,function(){
								$warnTip.remove();
							});
						},2000);
						return;
					}
					if(text.length){
						if(text.length>2000){
							//return parent.elsDeskTop.tip.init({type: 'alert',message:'发送内容不能超过2000字!'});
						}
						var list = $cpList.data('list');
						if(!list.length) {
							return parent.parent.elsDeskTop.tip.init({type: 'alert',displayType:3,message:'您还没选择当前聊天对象'});
						}
						var sendType = 0;
						var sendPeople = [];
						var sendSubPeople = [];
						if(businessID && businessID.length && !displayType) {
							//报价聊天窗口获取内容参数
							var storBusiness = $.parseJSON(decodeURI(businessID));
							var storeSubAccount = $.parseJSON(decodeURI(toElsSubAccount));
							sendType = 1;
							if(list && list.length) {
								list.forEach(function(item,i){
									sendPeople.push(storeSubAccount[item]);
								});
							} else {
								sendPeople = [];
								sendSubPeople=[];
							}
						} else {
							//议价聊天窗口获取内容参数
							sendType = 0;
							var storeSubAccount = $.parseJSON(decodeURI(toElsSubAccount));
							if(list && list.length) {
								list.forEach(function(item,i){
									//sendPeople.push(plist[item]);
									sendPeople[i]=plist[item].name;
									sendSubPeople.push(storeSubAccount[item]);
								});
							}  else {
								sendPeople = [];
								sendSubPeople=[];
							}
						}
						var pData={};
						pData={
								businessID			: businessID,
								businessType		: businessType,
								companyShortName	: companyShortName,
								content				: text,
								fromElsAccount		: elsAccount,
								fromElsSubAccount	: elsSubAccount,
								fromName			: companyShortName+"_"+username,
								fromStation			: role,
								toElsAccount		:  displayType?JSON.stringify(sendPeople):decodeURI(toElsAccount),
								toElsSubAccount		: displayType?JSON.stringify(sendSubPeople):JSON.stringify(storeSubAccount),
								orderType			: orderType,
								beginDate			: beginDate,
								endDate     		: endDate
							};
						/* if(!displayType) {
							pData={
									businessID			: businessID,
									businessType		: businessType,
									companyShortName	: companyShortName,
									content				: text,
									fromElsAccount		: elsAccount,
									fromElsSubAccount	: elsSubAccount,
									fromName			: companyShortName+"_"+username,
									fromStation			: role,
									toElsAccount		:  displayType?JSON.stringify(sendPeople):decodeURI(toElsAccount),
									toElsSubAccount		: displayType?JSON.stringify(sendSubPeople):JSON.stringify(storeSubAccount),
									orderType			: orderType,
									beginDate			: beginDate,
									endDate     		: endDate
								};
						} else {
							pData={
									businessID			: businessID,
									businessType		: businessType,
									companyShortName	: companyShortName,
									content				: text,
									fromElsAccount		: elsAccount,
									fromElsSubAccount	: elsSubAccount,
									fromName			: companyShortName+"_"+username,
									fromStation			: role,
									toElsAccount		:  displayType?JSON.stringify(sendPeople):decodeURI(toElsAccount),
									toElsSubAccount		: displayType?JSON.stringify(sendSubPeople):JSON.stringify(storeSubAccount),
									orderType			: orderType,
									beginDate			: beginDate,
									endDate     		: endDate	
							};
						} */
						
						$.ajax({
							url 			: "rest/ChatMessageService/sendEnquiryMessage",
							type 			: "POST",
							contentType 	: "application/json",
							data : JSON.stringify(pData),
							dataType 		: "json",
							success : function(data) {
								$xContent.val('');
								if($currPChat.nScroll)$currPChat.nScroll.resize(); 
								$jpContainer.nScroll.resize();
							},
							error : function(data) {
								console.log('error:',data);
							}
						});
					}
				});
				if(isMultiChat) {
					if(urlParams.list) {
						if($.isArray(urlParams.list))plist = urlParams.list;
						else{
							if(urlParams.list.list&&$.isArray(urlParams.list.list))
								plist = urlParams.list.list;
						}
					}
					refreshCurrPChat();
					//多人聊天人员窗口展开收起
					$btnCurrentPChart.click(function(){
						if($btnCurrentPChart.hasClass('mmg-btnBackboardDn')){
							resizeTalkWin({flag:false});
							$currPChat.slideDown(300,function(){
								$btnCurrentPChart.removeClass('mmg-btnBackboardDn').addClass('mmg-btnBackboardUp');
								$currPChat.css({'overflow':''});
								if($currPChat.nScroll)$currPChat.nScroll.resize(); 
							})	
						}else{
							resizeTalkWin({flag:true});
							$currPChat.slideUp(300,function(){
								$btnCurrentPChart.addClass('mmg-btnBackboardDn').removeClass('mmg-btnBackboardUp');
								if($currPChat.nScroll)$currPChat.nScroll.resize(); 
							})
						}
					});
				} else {
					$btnCurrentPChart.hide();
				}
				showContent();
				resizeTalkWin();
				//拖动改变列表和发送窗口高度
				$talkDragBar.on('mousedown',mouseMoveMaskStartListen);
				$talkDragBar.on('mousedup',mouseMoveMaskStopListen);
				
				$(window).resize(function(){
					talkDragOriginY = 'N';
					talkDragOffsetY = 0;
					resizeTalkWin({animate:false});
				});	
				window.setInterval(function(){
					// 1003-1578 展开加载聊天窗口 @author jiangzhidong @date 20170110 begin
					if(parent.$sob[0] &&(parent.$sob[0].toggleState===1 || parent.$sob[0].toggleState===undefined)) return false;
					// 1003-1578 展开加载聊天窗口 @author jiangzhidong @date 20170110 end
					showContent();
				}, 2000);
			};
        $(function() {
			init();
        });
	</script>
	<div class="talk" style="width: 100%;height:100%;overflow: hidden;">
		<div class="ui-state-default talk_header" style="padding: 1px;">
            <div>
                <span style="padding-left: 6px;">聊天窗口</span>
				&nbsp;
				<span class="subTitle" > </span>
				<a class="btnCurrentPChart mmg-btnBackboardDn"></a>
            </div>
        </div>
        <div class="currPChat" style="display:none;">
            <div class="cp_title">当前聊天</div>
			<div class="cp_list"></div>
			<div class="clear"></div>
        </div>
		<div class="talk_record" style="overflow:hidden">
			<div id="jp-container" class="jp-container" style="width: 100%;overflow-y: scroll;overflow-x: hidden;">
	
			</div>
			<div class="talk_drag_bar" ></div>
		</div>
		<div >
			<textarea class="xContent" id="chatMsg" rows="4" cols="80" style="width: 100%; margin: 0 auto;"></textarea>
		</div>
        <div class="text-center" style="margin-top: 10px;">
        	<button id="send" class=" button-wrap">发送</button>
        	<p style="margin-top: 14px; ">可通过Ctrl+enter键快捷发送信息</p>
        </div>
		<div class="mouse-move-mask" ></div>
	</div>
</body>