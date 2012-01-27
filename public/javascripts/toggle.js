// jquery for in place editing. 

 jQuery(function()
{
jQuery("#click_here").click(function(event) {
  event.preventDefault();
  jQuery("#div1").slideToggle();
  jQuery("#synopsis").slideToggle();

});

jQuery("#div1 a").click(function(event) {
  event.preventDefault();
  jQuery("#div1").slideUp();
  jQuery("#synopsis").slideToggle();
});

jQuery("#click_favmovie").click(function(event) {
    event.preventDefault();
    jQuery("#div2").slideToggle();
    jQuery("#favmovie").slideToggle();

});

jQuery("#div2 a").click(function(event) {
    event.preventDefault();
    jQuery("#div2").slideUp();
    jQuery("#favmovie").slideToggle();
});

jQuery("#click_funnyque").click(function(event) {
      event.preventDefault();
      jQuery("#div3").slideToggle();
      jQuery("#funnyque").slideToggle();

  });

  jQuery("#div3 a").click(function(event) {
      event.preventDefault();
      jQuery("#div3").slideUp();
      jQuery("#funnyque").slideToggle();
  });


});