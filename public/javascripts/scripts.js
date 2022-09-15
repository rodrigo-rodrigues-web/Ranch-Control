document.addEventListener("DOMContentLoaded", function(){

    let listgroup = document.querySelector("body > div > div.list-group");
    listgroup.addEventListener('click', function (event) {
        let id = event.target.getAttribute('data-id');
        location.href += ( 'auditinfo/'+id);
    })
});