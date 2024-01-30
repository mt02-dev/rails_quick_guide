document.addEventListener('turbolinks:load', function(){
  document.querySelectorAll('td').forEach(function(td){
    td.addEventListener('mouseover', function(e){
     e.currentTarget.style.backgroundColor = '#97f3f3';
    }); 

    td.addEventListener('mouseout', function(e){
     e.currentTarget.style.backgroundColor = '';
    });
 });
});