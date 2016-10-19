/*
*   2011-01-27.   jsontree.修改为jquery.treeview插件.
*   1. 实现jsontree可配置，插件化
*
*/
(function(win,$,undefined){		
	//jQuery implemenion api
	$.fn.treeview =  function(structobj,opts){	
		var tv = this;
		opts = opts || {};
		var options = {
			init:true,
			accepttype:"json",
			display:"default",
			hascheckbox:true,
			depth:0,
			treeArr:[],
			text:"",
			tab:"  ",
			r:"\r",
			icons:{
				 L0        : 'L0.gif',  //┏
				 L1        : 'L1.gif',  //┣
				 L2        : 'L2.gif',  //┗
				 L3        : 'L3.gif',  //━
				 L4        : 'L4.gif',  //┃
				 PM0       : 'P0.gif',  //＋┏
				 PM1       : 'P1.gif',  //＋┣
				 PM2       : 'P2.gif',  //＋┗
				 PM3       : 'P3.gif',  //＋━
				 M0		   : 'M0.gif',
				 M1		   : 'M1.gif',
				 M2		   : 'M2.gif',		 
				 empty     : 'empty.gif',        //空白图
				 root      : 'root.gif',   		//缺省的根节点图标
				 folder    : 'folder.gif',	   //缺省的文件夹图标
				 folderopen: 'folderopen.gif',
				 file      : 'file.gif',       //缺省的文件图标
				 exit      : 'exit.gif',
				 home	   : 'home.gif'
			}				
		};
		this.confs = $.extend( options,opts );
		var icons = this.confs.icons;
		var treeArr = this.confs.treeArr;
		function lines( flag,obj){
			var line = "";
			for(var i=0;i<flag.length;i++){
				var f = flag[i];				
				if(f=="end")line += createImg( icons.empty );
				else line += createImg( icons.L4 );
			}				 
			return line;
		}
		function createImg( icon ){
			return "<img src='./img/"+ icon +"' align='absmiddle' />"
		};
		function createValSpan( value,obj ){
			var ret = "<span>" + value + "</span>";
			return  ret;
		}		 
		function createColorLabel( value,color,otherstyle){
			otherstyle = otherstyle || "";			
			return "<label style='color:"+ color + ";" + otherstyle + "'>" + value + "</label>";
		}
		
		//draw tree code method;
		this.draw = function(){	
			var o   = arguments[0]!=undefined?arguments[0]:structobj;	//当前传入的对象					
			var clv = arguments[1] || 0;    						 	 /*当前层次*/
			var flag = arguments[2]||["end"];
			var slv = clv + 1 ; 								         /*递进层次*/			 
			
			//draw tree
			if( 0==clv ){
				if(typeof o!="object"){
					try{
						o = JSON.parse( o );
					}catch(e){
						return false;
					}		
				}
				var root = "";
				o.constructor==Object?root=createColorLabel("Root[Object]","navy"):root=createColorLabel("Root[Array]","navy");
				treeArr.push( createImg( icons.M2 ) + createImg( icons.folderopen ) + root);
			} 
			switch(o.constructor){
				case Object :
					treeArr.push("<ul>");
					var keys = GF.jsonKeys(o);						 
					for(var i=0;i<keys.length;i++ ){
						var k = keys[i];
						var v = o[k];		
						var lisuffix = "";
						var line1 = lines(flag,o);						 										 
						var line2 = i == keys.length-1 ?createImg( icons.M2 ):createImg( icons.M1 );	
						typeof v == "object"?function(){lisuffix = "";line2 += createImg(icons.folderopen)}():lisuffix = "</li>";
						var objtype =  typeof v =="object"?(v.constructor==Array?"array":"object"):typeof v;
						var val = createColorLabel("[KEY]","red")   + createColorLabel(k,"black","margin-left:5px;margin-right:5px;") + 
								  createColorLabel("[VALUE]","red") + createColorLabel( "[" + objtype + "]" )  +
								  createColorLabel( JSON.stringify(v),"black","margin-left:5px;");
						treeArr.push( "<li ptype='object' key=" + k + " pNode=" + JSON.stringify(o) + ">" + 
							line1 + line2 + createValSpan( val,v ) + lisuffix );	
						if( typeof v == "object"){							 
							i==keys.length-1?flag.push("end"):flag.push("noend");						 								
							tv.draw(v,slv,flag); 
							treeArr.push("</li>");	
							flag.pop();
						};							
					};					 
					treeArr.push("</ul>");
					break;
				case Array  :
					treeArr.push("<ul>");
					for(var i=0;i<o.length;i++ ){
						var v = o[i];
						var lisuffix = "";						
						var line1 = lines(flag,o);
						var line2 = i == o.length-1 ?("object" == typeof v?createImg( icons.M2 ):createImg( icons.L2 )):"object" == typeof v?createImg( icons.M1 ):createImg( icons.L1 );
					 	typeof v == "object"?function(){lisuffix = "";line2 += createImg(icons.folderopen)}():lisuffix = "</li>";
						var objtype =  typeof v =="object"?(v.constructor==Array?"array":"object"):typeof v;					
						var val = createColorLabel( "[" + i + "]","blue" ) + createColorLabel( "[" + objtype + "]" ) + 
								  createColorLabel( JSON.stringify(v),"black","margin-left:5px;") ;
						treeArr.push(  "<li ptype='object' key=" + k + " pNode=" + JSON.stringify(o) + ">" + 
							line1 + line2 + createValSpan( val,v ) + lisuffix );
						if( typeof v == "object"){
							i==o.length-1?flag.push("end"):flag.push("noend");							 
							tv.draw(v,slv,flag); 
							treeArr.push("</li>");
							flag.pop();
						};
						
					};					 
					treeArr.push("</ul>");		
					
			};				 
		};	
		//缩进函数			  
		this.dealIndent = function( str,lv ){
			var level = lv || 1;			
			try{
				var obj = JSON.parse( str ); 
			}catch(e){}	
			if(!obj)obj=str;
			var tabs="";
			for(var i=1;i<lv;i++)tabs+=tv.confs.tab;
			if(null==obj){
				arguments[2]=="array"?tv.confs.text += tabs + str:tv.confs.text += str;
				return tv.confs.text;
			}	
			switch( obj.constructor ){
				case Object:
					if(arguments[2]=="object")tv.confs.text += "{" + tv.confs.r ;
					else tv.confs.text += tabs + "{" + tv.confs.r ;
					level++;
					var keys=[];
					for(var k in obj)keys[keys.length]=k;
					for(var j=0;j<keys.length;j++){
						var k = keys[j];
						tv.confs.text += tabs + tv.confs.tab + '"' + k + '"' + ":";
						var val = obj[k];							
						tv.confs.text = tv.dealIndent( val,level,"object");	
						if(j!=keys.length-1) tv.confs.text += "," + tv.confs.r ;
					}	
					tv.confs.text +=  tv.confs.r + tabs  + "}";
					break;
				case Array:
					if(arguments[2]=="array")tv.confs.text += tabs + "[" + tv.confs.r ;
					else tv.confs.text += "[" + tv.confs.r;
					level++;
					for(var k in obj){
						var val = obj[k];
						tv.confs.text = tv.dealIndent( val,level,"array" );
						if(obj[ parseInt(k)+1 ]) tv.confs.text += "," + tv.confs.r;
					}
					tv.confs.text +=   tv.confs.r + tabs +  "]";
					break;
				case Boolean:	
				case Number:
				case String:
					//arrval
					if(typeof str=="number"||typeof str=="boolean")arguments[2]=="array"?tv.confs.text +=  tabs + str:tv.confs.text += str;
					else arguments[2]=="array"?tv.confs.text +=  tabs  + '"' + str + '"' :tv.confs.text += '"' + str + '"';					 				 
			}			
			return tv.confs.text;
		};
		this.init = function(){
			treeArr = [];
			tv.draw();	
			$(tv).each(function(i){
				$(this).html("");//clear before childdom
				$(this).append($(treeArr.join("")));
			});
			/*事件-BEGIN-*/
			 $("img",tv).click(function(e){	
				if($("ul:eq(0)",$(this).parent()).length){
					if(this.src.indexOf("M")>-1){					
						this.src = this.src.replace("M","P");						
						$("ul:eq(0)",$(this).parent()).hide();					 
						this.nextSibling.src = this.nextSibling.src.replace("folderopen","folder");
						return false;
					};
					if(this.src.indexOf("P")>-1){
						this.src = this.src.replace("P","M");
						$("ul:eq(0)",$(this).parent()).show();
						this.nextSibling.src = this.nextSibling.src.replace("folder","folderopen");
						return false;
					};	
				}		
			 });
			/*事件-END*/
		}
		return this;
	};
})(window,jQuery);