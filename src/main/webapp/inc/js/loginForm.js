/*loginForm.js */
let loginSubmitBtn = document.querySelector('#loginSubmitBtn');

loginSubmitBtn.addEventListener('click',function(){
	console.log('submitBtn click!');
	
	let id = document.querySelector('#id');
	let pw = document.querySelector('#pw');
	
	if(id.value=='' || pw.value=='') {
		alert('ID 또는 PW를 입력해주세요.');
		return;
	}
	
	let loginForm = document.querySelector('#loginForm');
	loginForm.submit();
});