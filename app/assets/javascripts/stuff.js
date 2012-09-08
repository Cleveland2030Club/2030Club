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

//membership rewards scripts
$(document).ready(function(){
	var tabs = $('div.sub-tabs a');
	var tabSelection = $('div.sub-nav');
	tabs.click(function(event){
		event.preventDefault();
		if(!$(this).hasClass('active')){
			tabs.toggleClass('active');
			tabSelection.toggleClass('hide');
		}
	});
});