let alertElement = $('#fail');
function hideAlert() {
    alertElement.alert('close')
}
if(alertElement.css('display')==='block'){
    setTimeout(hideAlert, 2000);
}