//кнопка вверх
$(function() { 
  $.fn.scrollToTop = function() { 
    
    $(this).hide().removeAttr("href"); if ($(window).scrollTop() != "0") { 
      $(this).fadeIn("slow")
    }
    
    var scrollDiv = $(this); $(window).scroll(function() {
      if ($(window).scrollTop() == "0") { $(scrollDiv).fadeOut("slow") }
      else { $(scrollDiv).fadeIn("slow") }
    });

    $(this).click(function() { $("html, body").animate({ scrollTop: 0 }, "slow") })
  }
});
$(function() { $("#w2b-StoTop").scrollToTop(); });

//прокрутка вверх при открытии страницы
$(function() {
  $('body').animate({'scrollTop':'0px'});
});

//ресайз окна и изменение левого отступа для mainheader на главной странице
$(window).resize(function() {
      
    var window_width = $(window).width();
    var window_height = $(window).height();
    var contactLayer_width = $("#contactLayer").width();
    var videoLayer_width = $("#videoLayer").width();
    var margin_left_wraperPanel = $("#wrapperPanel").offset().left;
       
    if (window_width < 1200) {
      if (window_width < 340) {
        $("#titleContainer").css("margin-left" , "7px");
      } else {
        var margin_left_title = 130*(window_width/1200)*0.8;
        $("#titleContainer").css("margin-left" , margin_left_title + "px"); 
      }     
    } else {
      margin_left_title_big = margin_left_wraperPanel + 80;
      $("#titleContainer").css("margin-left" , margin_left_title_big + "px");
    }
    
    if (contactLayer_width < 830) {
     var map_width = 720*(contactLayer_width/830)
     var map_height = 450*(contactLayer_width/830)
     var margin_left = 7*(contactLayer_width/830)
     $("#centerLayer").css("width" , map_width + "px").css("height" , map_height + "px").css("margin-left" , margin_left + "%");      
    } else {
     $("#centerLayer").css("width" , "720px").css("height" , "450px").css("margin-left" , "7%"); 
    }   
 
});


$(document).ready(function() { 
    
  var window_width = $(window).width();
  var window_height = $(window).height();
  var contactLayer_width = $("#contactLayer").width();
  var videoLayer_width = $("#videoLayer").width();
  var margin_left_wraperPanel = $("#wrapperPanel").offset().left;
  
  if (window_width < 1200) {
    if (window_width < 340) {
      $("#titleContainer").css("margin-left" , "7px")
    } else {
      var margin_left_title = 130*(window_width/1200)*0.8;
      $("#titleContainer").css("margin-left" , margin_left_title + "px"); 
    }
    //alert(window_width + "====" + margin_left_wraperPanel + "---");    
  } else {
    margin_left_title_big = margin_left_wraperPanel + 80;
    $("#titleContainer").css("margin-left" , margin_left_title_big + "px");
    //alert(window_width + "====" + margin_left_wraperPanel + "---" + margin_left_title_big);
  }
    
  if (contactLayer_width < 830) {
    var map_width = 720*(contactLayer_width/830)
    var map_height = 450*(contactLayer_width/830)
    var margin_left = 7*(contactLayer_width/830)
    $("#centerLayer").css("width" , map_width + "px").css("height" , map_height + "px").css("margin-left" , margin_left + "%");      
  } else {
    $("#centerLayer").css("width" , "720px").css("height" , "450px").css("margin-left" , "7%"); 
  }

});


