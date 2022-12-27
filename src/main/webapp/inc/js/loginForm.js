/*loginForm.js */
$(document).ready(function() {
	$('#loginSubmitBtn').click(function() {
		console.log('submitBtn click!');
		
		if($('#id').val().length<1 || $('#pw').val.length < 1) {
			alert('ID 또는 PW를 입력해주세요.');
			return;
		}
		
		$('#loginForm').submit();
	});
});
