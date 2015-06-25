$(document).ready(function() {
	$('#search').on('submit', function(e){
		e.preventDefault();
		if($('#srch-term').val())
			window.location='/search/'+ $('#srch-term').val();
	});
	$( 'a[href^="http"]:not(".internal")' ).attr( 'target','_blank' );
	$('.popup').on('click', function() {
		window.open($(this).prop('href'), '', 'height=260,width=520');
		return false;
	});
	$('pre').each(function(i, block) {
		hljs.highlightBlock(block);
	});
});
