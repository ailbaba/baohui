/**
 * 重要提醒:通过桌面底下右下角弹出提醒，点击跳转至目标地址
 * 描述：点击该提示跳转至目标页面，有且仅有一次弹出
 * 参数：bgUrl-背景图片，content-要显示的内容，targetHref-跳转的目标地址
 *      getDataUrl-获取接口的地址，params--接口地址参数 ,接口类型为POST
 */
(function($){
	var IMPORTANTTIP=function(el,options){
		var defaultOption={
				"id":"",
				"bgUrl":"",
				"content":"",
				"targetHref":"",
				"getDataUrl":'rest/restAPI/AccountOpenService/getBless/' + elsAccount + '/' + elsSubAccount+'/newYear',
				"params":{ "elsAccount":elsAccount,"elsSubAccount":elsSubAccount }
		};
		var opts=$.extend(defaultOption,options);
		var _th=this;
		_th._options=opts;
		_th._$el = $(el);
		_th._init();
	}
	IMPORTANTTIP.prototype={
			_options:{},
			_$el:'',
			_init: function() {
				var opts = this._options,_th=this,$el=this._$el;
				var closeIconBase64="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA1MDcuMiA1MDcuMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTA3LjIgNTA3LjI7IiB4bWw6c3BhY2U9InByZXNlcnZlIiB3aWR0aD0iNTEycHgiIGhlaWdodD0iNTEycHgiPgo8Y2lyY2xlIHN0eWxlPSJmaWxsOiNGMTUyNDk7IiBjeD0iMjUzLjYiIGN5PSIyNTMuNiIgcj0iMjUzLjYiLz4KPHBhdGggc3R5bGU9ImZpbGw6I0FEMEUwRTsiIGQ9Ik0xNDcuMiwzNjhMMjg0LDUwNC44YzExNS4yLTEzLjYsMjA2LjQtMTA0LDIyMC44LTIxOS4yTDM2Ny4yLDE0OEwxNDcuMiwzNjh6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiNGRkZGRkY7IiBkPSJNMzczLjYsMzA5LjZjMTEuMiwxMS4yLDExLjIsMzAuNCwwLDQxLjZsLTIyLjQsMjIuNGMtMTEuMiwxMS4yLTMwLjQsMTEuMi00MS42LDBsLTE3Ni0xNzYgIGMtMTEuMi0xMS4yLTExLjItMzAuNCwwLTQxLjZsMjMuMi0yMy4yYzExLjItMTEuMiwzMC40LTExLjIsNDEuNiwwTDM3My42LDMwOS42eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojRDZENkQ2OyIgZD0iTTI4MC44LDIxNkwyMTYsMjgwLjhsOTMuNiw5Mi44YzExLjIsMTEuMiwzMC40LDExLjIsNDEuNiwwbDIzLjItMjMuMmMxMS4yLTExLjIsMTEuMi0zMC40LDAtNDEuNiAgTDI4MC44LDIxNnoiLz4KPHBhdGggc3R5bGU9ImZpbGw6I0ZGRkZGRjsiIGQ9Ik0zMDkuNiwxMzMuNmMxMS4yLTExLjIsMzAuNC0xMS4yLDQxLjYsMGwyMy4yLDIzLjJjMTEuMiwxMS4yLDExLjIsMzAuNCwwLDQxLjZMMTk3LjYsMzczLjYgIGMtMTEuMiwxMS4yLTMwLjQsMTEuMi00MS42LDBsLTIyLjQtMjIuNGMtMTEuMi0xMS4yLTExLjItMzAuNCwwLTQxLjZMMzA5LjYsMTMzLjZ6Ii8+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=";
				var defaultBgBase64="data:image/jpg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMpaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCNjk2NTI0QkYyNkExMUU2QUFBOEY5QkQ5QjdFOUU5QyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCNjk2NTI0Q0YyNkExMUU2QUFBOEY5QkQ5QjdFOUU5QyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkI2OTY1MjQ5RjI2QTExRTZBQUE4RjlCRDlCN0U5RTlDIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkI2OTY1MjRBRjI2QTExRTZBQUE4RjlCRDlCN0U5RTlDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEB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3WIhN9ux1+/iphv1dmlxZOois+6kuNQ3WTSom1mXBZmSfsMiKtbyt+jW7ut/RXH8jxOJppdiZidN6LwTuFab7GWtlKkKxG067Rs27ZL9p/xocQn8byMfLu11S6ltwsrOmhJ2qCwOoJAOo03euutY3zh1gouoV3kao7cTZdDvabaKicUdh5cdZ2kWvnoJuQ06w80uQ7GkmhaTQbjBGZeuZC/6bvf+f2F8tqOyKbGTtnvjjL6b6wdEGdgI+bh5ABBUOvStr10IK3OGBX7Z3vcvD8f3X2VmcHzVXX462izHtQMy9THya2puq3IyWLurdl3IyOBoVZWGszmgW0++0vWbm0sKe0sbKoiSp02hz+JdlOIy8iLmRJycdeW3D5ERuoVhKC+xPpV4jIsy+OqyLWLOwP1ADDRiAtgXRRcoG25VAUWhwqqAFHnH8u9vcX2n5M5rtvhMXNwuIw8566assk3CsabX1KITVaD1ccsGY471brLW1tfbx2M1zARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARK5dVsoPj/AOXDDha3K0qkuLmxoo9fYEttk2b+M5XsXERazUwmrtr9pLrSWlmwylztpMko4lXz/qD+Ps3yT8P+7uJ4ep35biUx+Vox1BNiLxdy3WVaEBiRiLkOoGq6aLU9lapY3oe+NHP38n437fzuT5rH57kjiCvIzKipDWuCwqs2/d16Eeqi5rQl9rp170W611l4lLYx3Sq7NcVqfGJyLIfgvLcQ3JS04hcuC+ppRONdzgptRkfJJZx1Iec3gOUxMqvD5g1pk4RNdj1sSEsUEF6mZdCAwBQsPuGpI9QJujPxbkF2JuNdpDKGAH2kggOAdQdNQfUHX6fT0nf2jPeNnq62vPE+2RtBkKpYJXdNcvyXYVJIO+rnlWs2JbzVxFOuMJdh9xtRtO95BcyP1se8fXeLMnjM3n/DfM1duZLcfV7rGymsarFf3dLe4tTItNepUWYu9GNb9RNHU+hjh3DX3XXk04HeWE/JV9dulbUFDWjo2Dpo1S7tAdtu0/cuw+hkJ/JjadQ2jbadesyollKrqqREuLaAaXYklxchDkGKiUgu3MVDQTpqWk1JSThJzkjItD/Kru/sru7vLCt7Tupy8jFxHrysinRkclwaqxYPtsNahyWUsqhwoPoQM98U8PznEcNenLV2U1W3K1Vb+jKNv3NtJ1XcdoAOh1UnT1BNPPz03KBVeLpevG6g7DYZlZRRWSwa1GibHu7JxJeplEhQm0qPoRKeSn1Md3/p2dk53fPzJ4zuDGRjwXZnE5mdl2+oRbciizDxamb6B3svLBTp9tVh+itpt7I1x+CfX0sybFVfrqdp1J0/q/D9o/aJj/BlYxU+LdTitavM1F84HdsaqxStM92zNxSJtpK7pnJ5WrrffQl0kKbaWhBJSlKUl6YeFH+S3sPzWY7n9R1SoCC0A6EBlVQq6bFUBamekVu3nr+T3MZPNea+aybeZo5vDW4Lj20FTTRjkdSvDr2a1H2u81WPWzdW4WXWt7iy4CWh200DARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARAROEvl141eeOD5Ii2dzPnOSqzWm6NqF7liBFbi2c9MqFJiE3JhtokMOOL7iXTU89klpLCRi/KomFkHKy7aPY5D7WFui7dKj9m6x+m1bbCOjsBLW2PuI1Es8+CHlmuzHyPELcfjY9WLjZHI+8S0q99jZGNURbUysGt6dqItyOgWnGrQ1s35k6E+HfyYc3CGWh7nL5bRURUrblvKIlX1WxwaO2SSuJHaQOSET0F/VRh/GSXjzk/O74lL8au7R5T8dUH+QncGbttorBK8JyNxLCtdN3+QytGbFP0qYNjE/bSXtXxbzy9HRs9OVpX0P/AFFX09f+Zf8A3/GWxaNg9P8AMHoZHplKZehkZHt9KeS/gf1/UaA7AIbsnvYggg8Fjf2fxLG0mD9wDTnOE09D763/APNbOY/K3lDXvFmsWWwXk9EFiHH7y3DInXU9w+3GjxYxmk5djOeLhHZLHJeVHhBGZa67V7R738od7cd4p8XYZzu++WcrWv7tWNSoJty8l9CKqKEBeywjRQPQMxRHzfGx6tjZmWduDX9f2sfwVf6T+P8A6ymN65v/AJV+Y6789Is9f19RWcelRCirsW6SFDiyLRxp6UpTUX8vaqY5PyVZLumhKUmhKUj0rfFf4z9m/Fvx/V487dyMfP7z5O4X8vn3AG3OyelYxboCxbBh1AGnGo3grXY91jGyyzdozz75at8beP8AkO/a8VMq3BSkU4zW9DXrZNOMGD9OzXYbeoyqhLCtl3IBuWzeIwuNEjRnJL8xyPHZYXLlds5MpbTaW1SZBstssm++aeS+CEJ5GeCIugmNjVNRj10M7WMiKpZvVmIAG5j+JP1P9Jnnu5TMr5Hk8nkKaKcWm++yxaagwqpDuWFVQZmYV1g7EDMzbQNWJ9Z7A/tODARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARARAROR7744L13ate37xbZzWdojb4i8tU31jGRVNUs56U/aMR0w61l8o7SXDYJr9xTjDyyUajIjGmfLXiXhvJ3jLl/F/Nq2T25zPE24LIwp0x2NY9tlq5CMGxrq6rfQu+5VetdU2tZV4X+eOfxmU2L5PxsVOLweMU4r4VOQcnIyadiCmwWX21lsmsuTZ+RWjoASBYSLR/H/mfQaDTd5pb3YoLFpd63Apq9lM2E+Rvw9jgWJtyHClpKObUKKZHyIvuLHQx5VeF53jvF+F3n425/8AiOVydavxdF9eDd08hsLk1/NO0utYspoLgdRlB+3ex9TZ8mLnd5Y/Ad24NdVONciZj1tapNQyMMnYDopcq9gUHauoGu0fQcC+edJsfOO86hFVcRXfGda7cWexNVVux+UXOXHXGonGkoalMONEhnsoPJm1l88EfEW+/wClL4YwcDsXl/OVrO/dndGU2GjtUiW8bx+DkXBqQtzFm97bXVZvWoA7ArrpQGujD8k/lZx/iU8p2RhYp/WmBTitgm1LLMPMfIFT3Mz1Gs1tiVu7NWzgvrRtY9VxVvGgaLT+ONYhapRuzpFfCemvokWTkd6c85OmPS3FSHIsaGwo0G9wTxbT9iSzk8mdxGJhpiK+0lnsfcxOmpIVUB9AB6Kij0AHproJT35V8n8/5e7wt707krxqeRtpqr6eOti0otSBQEFtltgDNuc7rGO5zodNANzHLmuYCICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICJ5mGHZT7UZhHcffcQyy2RpSbjriiS22k1GkuS1GREWepngdZzPMcZ2/xd/NczcuPxWNWXtsYEqiD6s20EhV+rHTRRqToATO14LguW7m5fH4DgqGyeYyrBXTUpAaxz9EXcQCzaaKuurHRVBYgFIjvxH3Y0plyPIYWpp5h5Cm3WnEHhSFoURKSojH3xPLcbzvG0cxw19eTxeTWLKr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";
				var styleObj={
						"importantContain":"display:none;position:fixed;right: 0;width:320px;height:84px;bottom:0;background:#eee url('"+defaultBgBase64+"') no-repeat center ;z-index: 10;background-size: 100% 100%;",
						"containRelative":"position:relative;width: 100%;height: 100%;",
						"containClose":"position:absolute;width:20px;height:20px; right: 0;z-index:10;cursor: pointer;",
						"boxContain":"height: 100%;padding-left: 36px;display: -webkit-box;-webkit-box-align: center;-webkit-box-pack: center;color: #fffc01;font-size: 16px;cursor: pointer; font-family: serif;display: -moz-box; -moz-box-align: center;-moz-box-pack: center;display: -o-box;-o-box-align: center;-o-box-pack: center;display: -ms-box;-ms-box-align: center;-ms-box-pack: center;display: box;box-align: center;box-pack: center;"
				};
				var defaultHtml='<div class="important-box" style="'+styleObj.importantContain+'">'+
								'<div style="'+styleObj.containRelative+'">'+
								'<div class="impotant-close" style="'+styleObj.containClose+'">'+
								'<img style="width:100%;" src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA1MDcuMiA1MDcuMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTA3LjIgNTA3LjI7IiB4bWw6c3BhY2U9InByZXNlcnZlIiB3aWR0aD0iNTEycHgiIGhlaWdodD0iNTEycHgiPgo8Y2lyY2xlIHN0eWxlPSJmaWxsOiNGMTUyNDk7IiBjeD0iMjUzLjYiIGN5PSIyNTMuNiIgcj0iMjUzLjYiLz4KPHBhdGggc3R5bGU9ImZpbGw6I0FEMEUwRTsiIGQ9Ik0xNDcuMiwzNjhMMjg0LDUwNC44YzExNS4yLTEzLjYsMjA2LjQtMTA0LDIyMC44LTIxOS4yTDM2Ny4yLDE0OEwxNDcuMiwzNjh6Ii8+CjxwYXRoIHN0eWxlPSJmaWxsOiNGRkZGRkY7IiBkPSJNMzczLjYsMzA5LjZjMTEuMiwxMS4yLDExLjIsMzAuNCwwLDQxLjZsLTIyLjQsMjIuNGMtMTEuMiwxMS4yLTMwLjQsMTEuMi00MS42LDBsLTE3Ni0xNzYgIGMtMTEuMi0xMS4yLTExLjItMzAuNCwwLTQxLjZsMjMuMi0yMy4yYzExLjItMTEuMiwzMC40LTExLjIsNDEuNiwwTDM3My42LDMwOS42eiIvPgo8cGF0aCBzdHlsZT0iZmlsbDojRDZENkQ2OyIgZD0iTTI4MC44LDIxNkwyMTYsMjgwLjhsOTMuNiw5Mi44YzExLjIsMTEuMiwzMC40LDExLjIsNDEuNiwwbDIzLjItMjMuMmMxMS4yLTExLjIsMTEuMi0zMC40LDAtNDEuNiAgTDI4MC44LDIxNnoiLz4KPHBhdGggc3R5bGU9ImZpbGw6I0ZGRkZGRjsiIGQ9Ik0zMDkuNiwxMzMuNmMxMS4yLTExLjIsMzAuNC0xMS4yLDQxLjYsMGwyMy4yLDIzLjJjMTEuMiwxMS4yLDExLjIsMzAuNCwwLDQxLjZMMTk3LjYsMzczLjYgIGMtMTEuMiwxMS4yLTMwLjQsMTEuMi00MS42LDBsLTIyLjQtMjIuNGMtMTEuMi0xMS4yLTExLjItMzAuNCwwLTQxLjZMMzA5LjYsMTMzLjZ6Ii8+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=" />'+
								'</div>'+
								'<div class="target-href" style="'+styleObj.boxContain+'">'+
								'<span class="imp-content"></span>'+
								'</div>'+
								'</div></div>';
				$.ajax({
					url         : opts.getDataUrl,
					type        : "POST",
					contentType : "application/json",
					data        : JSON.stringify(opts.params),
					dataType    : "json",
					success  : function(data) {
						if(data) {
							$el.append(defaultHtml);
							$el.find('.important-box').css({'background':'#eee url('+data.bgUrl+') no-repeat center'});
							$el.find('.imp-content').text(data.content);
							var setTimer=setTimeout(function() {
								$el.find('.important-box').slideDown('slow');
								
								$('.impotant-close').click(function() {
									$el.find('.important-box').slideUp('slow',function() {
										$el.hide('slow');
									});
									
								})
								$('.target-href').click(function() {
									$('#'+data.targetHref).trigger('click');
									$el.find('.important-box').slideUp('slow',function() {
										$el.hide('slow');
									});
									
									data.elsAccount = elsAccount;
									data.elsSubAccount = elsSubAccount;
									
									$.ajax({
										url         : opts.setLogUrl,
										type        : "POST",
										contentType : "application/json",
										data        : JSON.stringify(data),
										dataType    : "json"
										});
								})
							},4000)
						}
					}
				}); 
				
			}
	};
	$.fn.importantTip= function(opts) {
		var obj = new IMPORTANTTIP(this, opts);
		return $.extend(true,this, obj);
	}
})(window.jQuery)
$(window).load(function() {
	var impObj={
			getDataUrl:'/ELSFinance/rest/AdvertisementService/getAdvertisementInfo',
			setLogUrl:'/ELSFinance/rest/AdvertisementService/setAdvertisementLog',
			params:{ "elsAccount":elsAccount,"elsSubAccount":elsSubAccount ,"role": role,"type":"SCF"}
	};
	
	$('.important-tip').importantTip(impObj);
});