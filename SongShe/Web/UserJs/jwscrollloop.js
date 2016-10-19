(function($){
	$.fn.scrollLoop = function(options){
	
	var def = $.extend({
		'time' : 5000,					//	The duration it takes to complete the animation (in milliseconds).
		'offsetX' : 1000,   			//	The starting X-offset from the original position (in pixels)
		'deltaX' : -1000,				//  The ending X-offset from the original position (in pixels)
		'offsetY' : 0,					//  The starting Y-offset from the original position (in pixels)
		'deltaY' : 0,					//  The ending Y-offset from the original position (in pixels)
		'position_type' : 'relative',	//  The positioning type, Relative or Absolute. Makes a difference in where the object begins and ends.
		'play_count' : -1				//  The number of times to play the animation. -1 will play infinitely.
	}, options);
	
	if(def['play_count'] == 0)
		return this; 
	else 
		def['play_count']--;
	
	return this.css({position : 'relative', left : def['offsetX'], top : def['offsetY']}).animate({left : def['deltaX'], top : def['deltaY']}, def['time'], function(){$(this).scrollLoop({'time' : def['time'], 'offsetX' : def['offsetX'], 'deltaX' : def['deltaX'], 'offsetY' : def['offsetY'], 'deltaY' : def['deltaY'], 'position_type' : def['position_type'], 'play_count' : def['play_count']});});
}
})(jQuery);