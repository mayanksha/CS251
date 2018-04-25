function validateFormOnSubmit(contact) {
	var Name  = validateName(contact.name); 
	var Address  = validateAddress(contact.add)   ; 
	var Email  = validateEmail(contact.email)    ; 
	var Phone  = validatePhone(contact.phone)   ; 
	var Acc  = validateAc(contact.ac); 
	var Pass  = validatePass(contact.pass);
	console.log(Name , Address , Email , Phone , Acc , Pass);
	if (Name && Address && Email && Phone && Acc && Pass){
		return true;
	}
	else {
		return false;
	}
}

// validate required fields
function validateName(name) {
    var error = "";
    if (name.value.length <= 0) {
        name.style.background = 'Red';
        document.getElementById('name-error').innerHTML = "The required field has not been filled in";
        var error = "1";
        return false;
    }
    else if(name.value.length <= 20) {
    	var val = document.getElementById("name").value
    	var reg = new RegExp("[a-zA-Z ]+")
		if(val.match(reg)[0] != val){
			console.log(val.match(reg)[0])
			name.style.background = 'Red';
			document.getElementById('name-error').innerHTML = "Invalid characters present in name. Only spaces and Alphabets are allowed.";
			error = "1";
			return false;
		}
		else {
			name.style.background = 'White';
			document.getElementById('name-error').innerHTML = "";
			error = "";
			return true;
		}    
	}
	else {
        name.style.background = 'Red';
        document.getElementById('name-error').innerHTML = "The Name must be less than 20 characters long.";
        return false;
	}
    return error;
}

// validate email as required field and format
function trim(s) {
    return s.replace(/^\s+|\s+$/, '');
}

function validateAddress(add) {
	if(add.value.length > 100){
        add.style.background = 'Red';
        document.getElementById('add-error').innerHTML = "The Address must be less than 100 characters.";
			return false;
	}
	else if (add.value.length == 0){
		add.style.background = 'Red';
        document.getElementById('add-error').innerHTML = "Please enter the address.";
			return false;
	}
	else {
		add.style.background = 'White';
        document.getElementById('add-error').innerHTML = "";
			return true;
	}
}
function validateEmail(email) {
    var error = "";
    var temail = trim(email.value); // value of field with whitespace trimmed off
    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/;
    var illegalChars = /[\(\)\<\>\,\;\:\\\"\[\]]/;

    if (email.value == "") {
        email.style.background = 'Red';
        document.getElementById('email-error').innerHTML = "Please enter an email address.";
        var error = "2";
        return false;
    } else if (!emailFilter.test(temail)) { //test email for illegal characters
        email.style.background = 'Red';
        document.getElementById('email-error').innerHTML = "Please enter a valid email address.";
        var error = "3";
        return false;
    } else if (email.value.match(illegalChars)) {
        email.style.background = 'Red';
        var error = "4";
        document.getElementById('email-error').innerHTML = "Email contains invalid characters.";
        return false;
    } else {
        email.style.background = 'White';
        document.getElementById('email-error').innerHTML = '';
        return true;
    }
}

// validate phone for required and format
function validatePhone(phone) {
    var error = "";
    var stripped = phone.value.replace(/[\(\)\.\-\ ]/g, '');

    if (phone.value == "") {
        document.getElementById('phone-error').innerHTML = "Please enter a phone number";
        phone.style.background = 'Red';
        var error = '6';
        return false;
    } else if (isNaN(parseInt(stripped))) {
        var error = "5";
        document.getElementById('phone-error').innerHTML = "The phone number contains illegal characters.";
        phone.style.background = 'Red';
        return false;
    } else if (stripped.length < 10) {
        var error = "6";
        document.getElementById('phone-error').innerHTML = "The phone number is too short.";
        phone.style.background = 'Red';
        return false;
    } else if (stripped.length > 10) {
        var error = "6";
        document.getElementById('phone-error').innerHTML = "The phone number is too long.";
        phone.style.background = 'Red';
        return false;
    } else {
        phone.style.background = 'White';
        console.log(stripped);
        document.getElementById('phone-error').innerHTML = '';
        return true;
    }
}

function validateAc(phone) {
    var error = "";
    var stripped = phone.value.replace(/[\(\)\.\-\ ]/g, '');

    if (phone.value == "") {
        document.getElementById('ac-error').innerHTML = "Please enter an a/c number";
        ac.style.background = 'Red';
        var error = '6';
        return false;
    } else if (isNaN(parseInt(stripped))) {
        var error = "5";
        document.getElementById('ac-error').innerHTML = "The ac number contains illegal characters.";
        ac.style.background = 'Red';
        return false;
    } else if (stripped.length < 5) {
        var error = "6";
        document.getElementById('ac-error').innerHTML = "The ac number is too short.";
        ac.style.background = 'Red';
        return false;
    } else if (stripped.length > 5) {
        var error = "6";
        document.getElementById('ac-error').innerHTML = "The ac number is too long.";
        ac.style.background = 'Red';
        return false;
    } else {
        ac.style.background = 'White';
        console.log(stripped);
        document.getElementById('ac-error').innerHTML = '';
        return true;
    }
}

function validatePass(pass){
	var reg = new RegExp("^[a-zA-Z0-9_]*$");
    if (pass.value == "") {
        document.getElementById('pass-error').innerHTML = "Please enter Password.";
        pass.style.background = 'Red';
        return false;
	}
	else if(pass.value != phone.value.match(reg)[0] && phone.value.length > 20){
        document.getElementById('pass-error').innerHTML = "Password contains invalid characters or is too long (max 20 char).";
        pass.style.background = 'Red';
        return false;
	}
	else {
        document.getElementById('pass-error').innerHTML = "";
        pass.style.background = 'White';
        return true;
	}
}
