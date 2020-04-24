/**
 * 
 */
function partialSubmit(i,n){
	//console.log('enter partial');
	var qid = document.getElementsByName("qid")[0].value;
	var uid = document.getElementsByName("uid")[0].value;
	var temp=i;
	if(Number(i)==1){
		i=Number(n)+1;
	}
		var cas = document.getElementsByName("selected-answer-"+(Number(i)-1));
		var quesid = document.getElementsByName(Number(i)-1)[0].value;
	var ca=0;
	for(var m=0;m<cas.length;m++){
		if(cas[m].checked == true){
			ca = m+1;
			break;
		}
	}
	/*console.log('values ');
	console.log(qid);
	console.log(uid);
	console.log(quesid);
	console.log(ca);*/
	
	var timerH = document.getElementById("hour").innerHTML;
	var timerM = document.getElementById("min").innerHTML;
	var timerS = document.getElementById("sec").innerHTML;
	var remtime = Number(timerH) *60 + Number(timerM);// + Number(timerS);
	//console.log(timer);
	//var ctime = new Date().getTime();
	//ctime = Math.floor((ctime%(1000 * 60 * 60 * 24))/(1000 * 60 * 60)) * 60 + Math.floor((ctime % (1000 * 60 * 60)) / (1000 * 60));
	//console.log(ctime);
	//var remtime = Math.floor(ctime - timer);
	//console.log(remtime);
	//console.log({qid,uid,quesid,remtime,ca});
	/*var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60)); 
	var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60)); 
	var seconds = Math.floor((t % (1000 * 60)) / 1000);*/
	var xhr = new XMLHttpRequest();
	xhr.open('POST','partialSubmit.jsp',true);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	var params = "uid="+uid+"&qid="+qid+"&quesid="+quesid+"&ca="+ca+"&remtime="+remtime;
	//alert('exsiting');
	xhr.send(params);
	xhr.onload = function() {
		//alert(params+'send succ');
		auto_modal_show(temp,n);
	}
}