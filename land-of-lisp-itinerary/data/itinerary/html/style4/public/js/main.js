$(document).ready(function() {

	changeContainerPosition();
	
	$(window).bind("resize", function(){
	    changeContainerPosition();
	});
	
	function changeContainerPosition() {
	
		var windowHeight = $(window).height();
		var containerHeight = $('.container').height() + $('.container > .footerMenu').height();
		var calculate = (windowHeight - containerHeight) / 2;
		calculate += $('.container > .footerMenu').height();
		
		if(calculate >= 0) {
			$('.container').css({ margin: calculate + 'px auto 0 auto' });
		}
	
	}

	var rightContentHeight = parseInt($('.rightContent').height());
	var leftContentHeight = parseInt($('.leftContent').height());
	
	if(leftContentHeight > rightContentHeight) {
	
		var calculate = ((leftContentHeight - rightContentHeight) / 2) - 5;
		if(calculate >= 0) {
			$('.rightContent').css({ margin: calculate + 'px 0' });
		}
	
	}
	
	var menuItems = $('.footerMenu li').size();
	var i = 1;
	$('.footerMenu li').each(function() {
	
		if(i != menuItems) {
		
			$(this).after('<li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;</li>');
		
		}
		
		i++;
	
	});

});