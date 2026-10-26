(function ($) {

    "use strict";

	// jquery visible plugin
	!function(t){var i=t(window);t.fn.visible=function(t,e,o){if(!(this.length<1)){var r=this.length>1?this.eq(0):this,n=r.get(0),f=i.width(),h=i.height(),o=o?o:"both",l=e===!0?n.offsetWidth*n.offsetHeight:!0;if("function"==typeof n.getBoundingClientRect){var g=n.getBoundingClientRect(),u=g.top>=0&&g.top<h,s=g.bottom>0&&g.bottom<=h,c=g.left>=0&&g.left<f,a=g.right>0&&g.right<=f,v=t?u||s:u&&s,b=t?c||a:c&&a;if("both"===o)return l&&v&&b;if("vertical"===o)return l&&v;if("horizontal"===o)return l&&b}else{var d=i.scrollTop(),p=d+h,w=i.scrollLeft(),m=w+f,y=r.offset(),z=y.top,B=z+r.height(),C=y.left,R=C+r.width(),j=t===!0?B:z,q=t===!0?z:B,H=t===!0?R:C,L=t===!0?C:R;if("both"===o)return!!l&&p>=q&&j>=d&&m>=L&&H>=w;if("vertical"===o)return!!l&&p>=q&&j>=d;if("horizontal"===o)return!!l&&m>=L&&H>=w}}}}(jQuery);
	
	
	// Check if yellow-pencil active.
	function is_yellow_pencil(){
		
		if($("body").hasClass("yp-yellow-pencil")){
			return true;
		}else{
			
			if($(document).find(".yp-select-bar").length > 0){
				return true;
			}else{
				return false;
			}
			
		}
		
	}
	
	
	// Getting Custom Selectors by Yellow Pencil Styles.
	function yp_get_selectors_array(selector){

		if($("style#yellow-pencil,style#yp-live-preview").length === 0){
			return false;
		}
		
		if($("style#yellow-pencil").length != 0){
			var styles = $("style#yellow-pencil").html();
		}

		if($("style#yp-live-preview").length != 0){
			var styles = $("style#yp-live-preview").html();
		}

		if($("style#yellow-pencil,style#yp-live-preview").length == 2){
			var styles = $("style#yellow-pencil").html() + $("style#yp-live-preview").html();
		}
		
		styles = styles.replace(/(\r\n|\n|\r)/g,"").replace(/\t/g, '');
		
		var selectors = $.trim(styles.replace(/\{.*?\}/g, "|"));
		selectors = selectors.replace(/\/\*.*?\*\//g, "");
		selectors = selectors.substring(0, selectors.length - 1);
		selectors = selectors.replace(/\}/g).replace(/\{/g).split("|");
		
		var arrayReturn = [];
		
		$.each(selectors,function(i,v){
			
			if (v.indexOf(selector) >= 0){
				arrayReturn.push(v.replace(selector,""));
			}
			
		});
		
		return arrayReturn.toString();
		
	}
	
	// detect if click on any element from yellow pencil,
	//so add click animation.
	function yp_click_checker(){
	
		var click = $(yp_get_selectors_array(".yp_click"));
	
		click.each(function(){
			$(this).click(function(){
				$(this).addClass("yp_click");
			});
		});
	
	}
	
	// detect if on screen any element from yellow pencil,
	//so add animation.
	function yp_onsceen_checker(){

		$(yp_get_selectors_array(".yp_onscreen")).each(function(){
		
			if($(this).visible(true)){
				$(this).addClass("yp_onscreen");
			}
			
		});
		
	}
	
	if(!is_yellow_pencil()){
		
		$(window).resize(function(){
			yp_onsceen_checker();
		});
		
		$(document).ready(function(){
			yp_onsceen_checker();
			yp_click_checker();
		});
		
		$(document).scroll(function(){
			yp_onsceen_checker();
		});
		
	}
	
	
}(jQuery));