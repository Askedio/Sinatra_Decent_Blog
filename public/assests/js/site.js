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

	hljs.configure({
	  tabReplace: '  '
	})
	hljs.initHighlighting();
    
	$('[data-toggle="tooltip"]').tooltip();
});
$.fn.postJson = function(success) {
  return this.each(function() {
	$(this).on('submit', function(){
	  $.post( $(this).data('action'),  $(this).serialize(), success, "json");
	  return false;
	});
  });
};