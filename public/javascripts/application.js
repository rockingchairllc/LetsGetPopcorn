// validation for registration pages


jQuery(document).ready(function() {
  jQuery("#user_new").validate({
	
	rules: {
		"user[first_name]":{
	                  required: true,
					  minlength: 2
                        		
			 },
		
		     "user[last_name]":{
						required: true,
						minlength: 2
			 },
			"user[username]":{
						required: true,
						minlength: 2
			 },
			"user[login]":{
						required: true,
						minlength: 2
			 },
	
		     "user[email]":{
						required:true,
						email:true
		     },
		
		    "user[password]":{
						required: true,
						minlength: 6
			},
			"user[password_confirmation]":{
							required: true
			},
			"user[zip]":{
							required: true
			}
		},
	messages: {
		"user[first_name]":{
						required: "Please enter first name",
                        minlength: "Your first name must consist of at least 2 characters"
			},
		
		"user[last_name]":{
						required: "Please enter last name",
                        minlength: "Your last name must consist of at least 2 characters"          
						
		},
		"user[username]":{
						required: "Please enter username",
                        minlength: "Your username must consist of at least 2 characters"          
						
		},
		"user[login]":{
						required: "Please enter username",
                        minlength: "Your username must consist of at least 2 characters"          
						
		},
		"user[email]":{
						            required: "Please enter email address",
						            email: "Please enter valid email address"
						
		},
		"user[password]":{
						            required: "Please provide a password",
									minlength: "Your password must be at least 6 characters long"
						
		},
		"user[password_confirmation]":{
						            required: "Please provide a confirmation password"
		},
	
		
			"user[zip]":{
									required: "Please enter zip code"
			}
		}
	});
});

// validation for Forget password pages

jQuery(document).ready(function() {
  jQuery("#forg_pass").validate({
	
	rules: {
		
	
		     "user[login]":{
						required:true,
						email:true
		     }
		},
	messages: {
		
	
		"user[login]":{
						            required: "Please enter email address",
						            email: "Please enter valid email address"	
					 }
		}
	});
});


// validation for Contact Us pages

$(document).ready(function() {
  $("#contactform").validate({
	errorElement:'div',
	rules: {
		"reset_password[name]":{
					                  required: true,
                        			character:true,
     					              maxlength:49
			},
		
		"reset_password[email]":{
						required:true,
						email:true
		},
		
		"reset_password[message]":{
						required:true,
							minlength:10,
						maxlength:499
		}
		},
	messages: {
		"reset_password[name]":{
			required: "Please enter name",
                        character: "Please enter only character",
			                  maxlength:jQuery.format("do not enter more than 50 charecter")
			},
		
		"reset_password[email]":{
						            required: "Please enter email address",
						            email: "Please enter valid email id"
						
		},
		"reset_password[message]":{
						            required: "Please enter message",
						            minlength:jQuery.format("Please enter at least 10 characters."),
						            maxlength:jQuery.format("Can not exceed 500 characters")
		}
		}
	});
});

// validation for Add highlight reel pages

jQuery(document).ready(function() {
  jQuery("#add_photo").validate({
	
	rules: {
		
	
		     "album[name]":{
						required:true,
						minlength: 2
		     },
			"album[photo]":{
						required:true			
		     }
		},
	messages: {
		
	
		"album[name]":{
						            required: "Please enter photo name",
						            minlength: "Your photo name must consist of at least 2 characters"	
					 },
		"album[photo]":{
									required:"Please enter photo"			
					    }
					
		}
	});
});

// validation for Edit highlight reel pages

jQuery(document).ready(function() {
  jQuery("#edit_photo").validate({
	
	rules: {
		
	
		     "album[name]":{
						required:true,
						minlength: 2
		     }
		},
	messages: {
		
	
		"album[name]":{
						            required: "Please enter photo name",
						            minlength: "Your photo name must consist of at least 2 characters"	
					 }
					
		}
	});
});
