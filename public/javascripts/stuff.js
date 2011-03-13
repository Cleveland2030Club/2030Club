//show and hide for user wether addmision to an event will be charged
$(document).ready(function() {
	$(".attendeeCharged").hide();
	$("#attendeeCharge").change(function(e){
		$(".attendeeCharged").toggle();
	});
});

//show and hide for user wether event is sponsored
$(document).ready(function() {
	$(".eventSponsored").hide();
	$("#event_sponsor").change(function(e){
		$(".eventSponsored").toggle();
	});
});

//hide for message
$(document).ready(function() {
	$(".beta-flag .close").click(function(e){
		$(".beta-flag").slideToggle();
	});
});

//home page content
$(document).ready(function() {
	
	$("#link-social, #link-networking, #link-philanthropic, #link-educational").click(function(e){
		$('.intro-content').each(function(index) {
    	if(!$(this).hasClass("hide")){
				$(this).addClass("hide", 1000);
			};
  	});
		if($("#content-"+ $(this).attr('id').substr(5)).hasClass("hide")){
			$("#content-"+ $(this).attr('id').substr(5)).removeClass("hide", 1000);
		};
		return false;
	});
});

