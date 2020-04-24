function validate_login(){
	var p=document.getElementById('pass').value;
	var q=document.getElementById('email').value;
	if(p.length < 8 || q.length==0){
		alert('1. Password must be atleast 8 characters long \n2. Empty fields not allowed');
		return false;
	}
}
function validate_signup(){
	var enroll = document.forms["form-signup"]['enroll'].value;
	var name= document.forms["form-signup"]['name'].value;
	var email= document.forms["form-signup"]['email'].value;
	var dob= new Date(document.forms["form-signup"]['dob'].value);
	var role= document.forms["form-signup"]['role'].value;
	var akey= document.forms["form-signup"]['akey'].value;
	
	if(enroll.length <= 0){
		alert('Enrollment can\'t be empty and must contain letters followed by numbers. Example - ABC1234567');
		return false;
	}
	if(name.length <= 0 || name.length <=3){
		alert('Name must be more than 3 characters');
		return false;
	}
	if(email.length == 0){
		alert('Email is required. That field can not be empty');
		return false;
	}

	if(compareDatesOnly(dob,new Date())>=0){
		alert('You must be alive and more than 16 to take the quiz.');
		return false;
	}
	if(role == 'admin'){
		if(akey != '$$2020$$'){
			alert('You can not become an admin with a wrong key. Contact Developer.');
			return false;
		}
	}
}
function field_akey(obj){
	if(obj.value == "admin"){
		var key = document.getElementById('akey');
		key.removeAttribute('disabled');
	}
	else{
		var key = document.getElementById('akey');
		key.setAttribute('disabled', 'true');
	}
}

function validate_count(){
	var a = document.getElementById('quescount').value;
	if(a<=0){
		alert('Unable to create quiz with zero questions try a different value.');
		return false;
	}
	var b = document.getElementById('qname').value;
	if(b.length <= 8){
		alert('Quiz name must more than 8 characters');
		return false;
	}
}

function validate_rowCount(){
	var a = document.getElementById('row-count').value;
	var b = document.getElementsByName('choice')[1];
	if(a <= 0 && b.checked){
		alert('Can\'t produce result with zero rows');
		return false;
	}
}
function field_specificrow(){
	var obj = document.getElementsByName('choice')[1];
	if(obj.checked){
		var key = document.getElementById('row-count');
		key.removeAttribute('disabled');
	}
	else{
		var key = document.getElementById('row-count');
		key.setAttribute('disabled', 'true');
	}
}
function export_csv(){
	alert('This function will be available in future releases');
}
function validate_quizhosting(){
	var qinfo = document.getElementById('qinfo').value;
	if(qinfo.length <= 50){
		alert('Quiz information must be atlest 50 characters long with an upper bound of 500 charaters');
		return false;
	}
	var sdate = document.getElementById('sdate').value;
	if(sdate.length <= 0){
		alert('A start date is required');
		return false;
	}
	var edate = document.getElementById('edate').value;
	if(edate.length <= 0){
		alert('An end date is required');
		return false;
	}
	var rdate = document.getElementById('rdate').value;
	if(rdate.length <= 0){
		alert('Register by date is required');
		return false;
	}
	var duration = document.getElementById('duration').value;
	if(duration < 10 || duration > 240){
		alert('Duration can only be between 10mins and 240mins');
		return false;
	}
	var difficulty = document.getElementById('difficulty').value;
	if(difficulty == 'none'){
		alert('Difficulty can not be none. If you have no idea select "Easy" instead. ');
		return false;
	}
	return validate_quizhosting2();
}
function compareDate(d1,d2){
	// compares date d1 and d2 
	// returns 1 if d1>d2
	// -1 d1<d2
	// 0 d1=d2
	var d1day = d1.getDate();
	var d1mon = d1.getMonth();
	var d1year = d1.getFullYear();

	var t1hr = d1.getHours();
	var t1min = d1.getMinutes();

	var d2day = d2.getDate();
	var d2mon = d2.getMonth();
	var d2year = d2.getFullYear();

	var t2hr = d2.getHours();
	var t2min = d2.getMinutes();

	if(d1year>d2year){
		
		return 1;
	}
	else{
		
		if(d1year<d2year)	return -1;
		if(d1mon>d2mon){
			
			return 1;
		}
		else{

			
			if(d1mon<d2mon)	return -1;
			if(d1day>d2day){
				
				return 1;
			}
			else{
				
				if(d1day<d2day)	return -1;
				if(t1hr>t2hr){
					
					return 1;
				}
				else{
					
					if(t1hr<t2hr)	return -1;
					if(t1min>t2min){
						
						return 1;
					}
					else if(t1min<t2min) return -1;
					
				}
			}
		}
	}
	return 0;
}
function validate_quizhosting2(){
	var sdate = new Date(document.getElementById('sdate').value);
	var rdate = new Date(document.getElementById('rdate').value);	
	var edate = new Date(document.getElementById('edate').value);
	var cdate = new Date();
	var res = compareDate(cdate,sdate);
	if( res > 0){
		alert('Start date-time must be greater than current date-time');
		return false;
	}
	var res = compareDate(cdate,edate);
	if( res > 0){
		alert('End date-time must be greater than current date-time');
		return false;
	}
	var res = compareDate(cdate,rdate);
	if( res > 0){
		alert('Registration date-time must be greater than current date-time');
		return false;
	}
	var res = compareDate(sdate,edate);
	if( res > 0){
		alert('Start date-time cannot be greater than end date-time');
		return false;
	}
	var res = compareDate(rdate,sdate);
	if( res > 0){
		alert('Start date-time cannot be less than registration date-time');
		return false;
	}
	var res = compareDate(rdate,edate);
	if( res > 0){
		alert('Registration date-time cannot be greater than end date-time');
		return false;
	}
}
function compareDatesOnly(d1,d2){
	// compares date d1 and d2 
	// returns 1 if d1>d2
	// -1 d1<d2
	// 0 d1=d2
	var d1day = d1.getDate();
	var d1mon = d1.getMonth();
	var d1year = d1.getFullYear();

	var d2day = d2.getDate();
	var d2mon = d2.getMonth();
	var d2year = d2.getFullYear();

	if(d1year>d2year){
		
		return 1;
	}
	else{
		
		if(d1year<d2year)	return -1;
		if(d1mon>d2mon){
			
			return 1;
		}
		else{

			
			if(d1mon<d2mon)	return -1;
			if(d1day>d2day){
				
				return 1;
			}
			else{
				
				if(d1day<d2day)	return -1;
				
			}
		}
	}
	return 0;
}
function validate_delete(){
	if(confirm('Are you sure you want to delete that quiz?')){
		return true;
	}
	else{
		return false;
	}
}
function auto_modal_show(i,n){
	var j=0;
	for(j=1;j<=n;j++){
		var k =document.getElementsByClassName('auto-hide-'+j);
		for(var m=0;m<k.length;m++){
			k[m].style.display = 'none';
		}
	}
	var k = document.getElementsByClassName('auto-hide-'+i);
	for(var m=0;m<k.length;m++){
		k[m].style.display = 'block';
	}
}
function current_radio_clear(i){
	var m = document.getElementsByName('selected-answer-'+i);
	var k;
	for(k=0;k<m.length;k++){
		m[k].checked = false;
	}
}
function validate_create(){
	var ques = document.getElementById('ques').value;
	if(ques.length < 20){
		alert('Question must have a minimum of 20 characters.');
		return false;
	}
	var c1 = document.getElementById('c1').value;
	if(c1.length <= 0){
		alert('Choice one is mandatory');
		return false;
	}
	var c2 = document.getElementById('c2').value;
	if(c2.length <= 0){
		alert('Choice two is mandatory');
		return false;
	}
	var c3 = document.getElementById('c3').value;
	if(c3.length <= 0){
		alert('Choice three is mandatory');
		return false;
	}
	var c4 = document.getElementById('c4').value;
	if(c4.length <= 0){
		alert('Choice four is mandatory');
		return false;
	}
	var nmarks = document.getElementById('nmarks').value;
	if(nmarks.length <= 0){
		alert('Negative mark is mandatory, if you do not want then fill it with a zero(0).');
		return false;
	}
	else if(nmarks.length >=2 ){
		alert('You have a very large value for negative marks.');
			return false;
	}
	var marks = document.getElementById('marks').value;
	if(marks.length <= 0){
		alert('Marks field is mandatory.');
		return false;
	}
	else if(marks.length >=2 ){
		alert('You have a very large value for marks.');
		return false;
	}
	var cc = document.getElementById('cc').value;
	if(c2.length <= 0){
		alert('Correct choice is mandatory');
		return false;
	}
	else if(cc!='1' && cc!='2' && cc!='3' && cc!='4'){
		alert('Correct choice can only be a number from 1 to 4.');
		return false;
	}
	var topic = document.getElementById('topic').value;
	if(topic.length <= 0){
		alert('You have not mention any subject. If you do not want that just type "n"');
		return false;
	}
	var diff = document.getElementById('diff').value;
	if(diff == 'none'){
		return confirm('You have selected "none" for difficulty. Are you sure?');
	}
}