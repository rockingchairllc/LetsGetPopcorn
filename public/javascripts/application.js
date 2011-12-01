// application-specific JavaScript functions and classes here


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
		}
		}
	});
});


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

