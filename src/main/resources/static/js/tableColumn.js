function timeFormat(val){
	if (!val&& val!="") {
		return "";
	}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
}
function dateFormat(val,pattern) {
	if (!val&& val!="") {
		return "";
	}
	if (!pattern || pattern == "" || pattern == 'null') {
		pattern = "yyyy-MM-dd";
	}
	if (val!=""&&val.length != pattern.length) {
		if (isNaN(val) &&val.length > pattern.length) {
 			val = val.replace(/-/g, "/").substring(0,pattern.length);
 		}
		return new Date(val).format(pattern);
	}
	return val;
}
function dictionaryFormat(val,pattern) {
	if (!val&& val!="") {
		return "";
	}
	var list = pattern.split(";");
	for (var i=0;i<list.length;i++){
		var key = list[i].split(":")[0];
		console.log();
		if (key == val) {
			return list[i].split(":")[1];
		}
	}
	console.log(val);
	return val;
}
function numberFormat(val,pattern) {
	if (!val&& val!="") {
		return "0.00";
	}
	return val;
}
function dateInputFormat(val,type,property,pattern) {
	val = dateFormat(val,pattern);
	if (type == "R") {
		return "<span class='showText'>" + val + "</span>" + "<input name='"+property+"' class='noEdit' type='text' style='display:none' value='"+val+"'/>";
	} else {
		return "<input name='"+property+"' class=' Wdate' onfocus='WdatePicker()' type='text' value='"+val+"'/>";
	}
}
function dictionaryInputFormat(val,type,property,pattern) {
	if (type =="R") {
		return "<span class='showText'>" + dictionaryFormat(val,pattern) + "</span>" + "<input name='"+property+"' class='noEdit' type='text' style='display:none' value='"+val+"'/>";
	} else {
		var html = "<select name='" + property + "'>";
		var list = pattern.split(";");
		for (var i=0;i<list.length;i++){
			var key = list[i].split(":")[0];
			var value = list[i].split(":")[1];
			if (key != val) {
				html += "<option value='" + key + "'>" + value + "</option>";
			} else {
				html += "<option value='" + key + "' selected>" + value + "</option>";
			}
		}
		html += "</select>";
		return html;
	}
	
}
function numberInputFormat(val,type,property,pattern) {
	val = numberFormat(val,pattern);
	if (type == "R") {
		return "<span class='showText'>" + val + "</span>" + "<input name='"+property+"' class='noEdit' type='text' style='display:none' value='"+val+"'/>";
	} else {
		return "<input name='"+property+"' type='text' value='"+val+"'/>";
	}
}
function stringInput(val,type,property) {
	if (!val&& val!="") {val = "";}
	if (type == "R") {
		return "<span class='showText'>" + val + "</span>" + "<input name='"+property+"' class='noEdit' type='text' style='display:none' value='"+val+"'/>";
	} else {
	    return "<input name='"+property+"' type='text' value='"+val+"'/>";
	}
}