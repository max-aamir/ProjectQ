var c=0;
var twice=1;
var d=0;
var refer = 0;
var x,flag = 0;
window.addEventListener('focus', function() { 
	//console.log('Window has focus');
	//console.log('  '+c);
	if(c==0 && d==2 && flag==0){
	//alert('You will be logged out and if you do this again.');
	alert('You will be logged out if you switch tab or window. Its a warning. One more time and it will be over for you.');
	//alert('');
	c=1;
}
else if(c==0 && d==3 && flag==0){
	//alert('You will be logged out and if you do this again.');
	c=1;
}
if(d==3){
	var form2 = document.getElementById('answers');
	form2.submit();
	//	please check whether the warning for final submission is 
	// only on the button or on the form itself
	// this feature requires form submission not using the final button
}
	 });
window.addEventListener('blur', function() { 
	//console.log('Window lost focus'); 
	//console.log('  '+c);
	twice +=1;
	if(twice==2)
		{c=0;twice=0;
			d+=1;
		}				
	else
		c=1;
});
function auto_timeout(duration){
	var deadline = new Date().getTime() + (1000 * 60 * duration);
	x = setInterval(function() { 
	var now = new Date().getTime();
	var t = deadline - now;  
	var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60)); 
	var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60)); 
	var seconds = Math.floor((t % (1000 * 60)) / 1000);
	sessionStorage.setItem('hr',String(hours));
	sessionStorage.setItem('min',String(minutes));
	document.getElementById("hour").innerHTML =hours; 
	document.getElementById("min").innerHTML = minutes; 
	document.getElementById("sec").innerHTML =seconds; 
	if (t < 0) { 
			clearInterval(x); 
			document.getElementById("hour").innerHTML ='0'; 
			document.getElementById("min").innerHTML ='0' ; 
			document.getElementById("sec").innerHTML = '0';
			sessionStorage.removeItem('hr');
			sessionStorage.removeItem('min');
			sessionStorage.removeItem('test');
			alert('Its timeout for you. Bye bye!');
			document.getElementById("answers").submit();
			} 
	}, 1000);
}
function submit_confirmation(){
	if(confirm("You still have time to answer questions. If you submit now, later you won't be able to change your responses. Submit or not.")){
		sessionStorage.removeItem('hr');
		sessionStorage.removeItem('min');
		sessionStorage.removeItem('test');
		flag=1;
		return true;
		//sessionStorage.removeItem('test');
		
	}
	else
		return false;
}
function check(duration){
	if(sessionStorage.getItem('test')=='1'){
		var s = sessionStorage.getItem('test') + '1';
		sessionStorage.setItem('test',s);
		var hr = sessionStorage.getItem('hr');
		var min = sessionStorage.getItem('min');
		//var sec = document.getElementById('sec');
		console.log(hr);
		console.log(min);
		//console.log(sec);
		var duration = 60 * Number(hr) + Number(min) - Number(10);
		clearInterval(x);
		auto_timeout(duration);
		alert('You are not allowed to refresh the page. All your anwsers are gone and 10 minutes have been deducted from your time. Be careful next time.');		
	}
	else if(sessionStorage.getItem('test')=='11'){
		//alert('logout success');
		sessionStorage.removeItem('hr');
		sessionStorage.removeItem('min');
		sessionStorage.removeItem('test');
//		document.getElementById("answers").submit();
		auto_timeout(0);
	}
	else{
		sessionStorage.setItem('test',1);
		auto_timeout(duration);
/*		var hrs = document.getElementById('hour').innerHTML;
		var mins = document.getElementById('min').innerHTML;
		console.log(hrs);
		console.log(mins);
		//var sec = document.getElementById('sec');
		sessionStorage.setItem('hr',hrs);
		sessionStorage.setItem('min',mins);*/
	}
}
//If you do it again, you will lose all of your answers and 10 minutes will be deducted from your time