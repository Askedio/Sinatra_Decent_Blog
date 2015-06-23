$(document).ready(function() {
	$('#search').on('submit', function(e){
		e.preventDefault();
		if($('#srch-term').val())
			window.location='/search/'+ $('#srch-term').val();
	});
	$( 'a[href^="http"]:not(".internal")' ).attr( 'target','_blank' );
});