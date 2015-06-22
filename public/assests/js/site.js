$( 'a[href^="http"]:not(".internal")' ).attr( 'target','_blank' );

var jumboHeight = $('.jumbotron').outerHeight();
function parallax(){
    var scrolled = $(window).scrollTop();
    $('.bg').css('height', (jumboHeight-scrolled) + 'px');
}

$(window).scroll(function(e){
    parallax();
});

$(document).ready(function() {
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });

	$('#search').on('submit', function(e){
		e.preventDefault();
		if($('#srch-term').val())
			window.location='/search/'+ $('#srch-term').val();
	});
});