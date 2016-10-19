/*
*	author:lisen
*   date: 2011-01-25
*   description:
*   jQuery implemention
*   attention:
*   1. ������Ҫ��չԭ������,����ԭ�����������Ⱦ
*   2. �����Լ��Ķ��������ռ�,���ⱻ��Ŀ������,GF
*   3.
*/

(function(undefined){
	window.GF = {
			Ver:"1.0 beta",
			Browser:function(){
				var Sys = {};
				var ua = navigator.userAgent.toLowerCase();
				var s;
				(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
				(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
				(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
				(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
				(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
				//return browser type and version
				if (Sys.ie)return {type:'IE',version:Sys.ie};
				if (Sys.firefox)return { type:'Firefox',version:Sys.firefox };
				if (Sys.chrome)return { type:'Chrome',version:Sys.chrome };
				if (Sys.opera)return { type:'Opera',version:Sys.opera };
				if (Sys.safari)return { type:'Safari',version:Sys.safari };
			}(),
			jsonKeys:function(json){
				var keys = [];
				for(var p in json){
					if(json.hasOwnProperty(p))keys.push(p);
				};
				return keys;
			}
		};
})();
