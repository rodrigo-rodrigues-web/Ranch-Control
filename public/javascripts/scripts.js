$(document).ready(function () {
    
    // $(function(){ 
    //   $("#nav-placeholder").load("/nav"); // Load Navbar
    // });

    let alertElement = $('#fail');
    function hideAlert() {
        alertElement.alert('close')
    }
    if(alertElement.css('display')==='block'){
        setTimeout(hideAlert, 2000);
    }
  }); // End of document.ready

