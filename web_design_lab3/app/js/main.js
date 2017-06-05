 $(document).ready(function() {
   $.ajax({
     type: "GET",
     url: "/data.xml",
     dataType: "xml",
     success: function(xml) {
       let domStr = '<div class="list">';
       $(xml).find('book').each(function() {
         domStr += `<div class="block">
                  <h2>${ $(this).attr('category') }</h2>
                  <ul>
                    <li><span>title: </span>${ $(this).find('title').text() }</li>
                    <li><span>autor: </span>${ $(this).find('autor').text() }</li>
                    <li><span>year: </span>${ $(this).find('year').text() }</li>
                    <li><span>price: </span>${ $(this).find('price').text() }</li>
                  </ul>
                </div>`;
       });
       domStr += '</div>'
       $('.content').html(domStr);

       $('.block').click(function() {
       	$('.block ul').hide(150);
       	$(this).closest('.block').find('ul').show(300);
       });
     }
   })
 })
