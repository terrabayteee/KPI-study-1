$(document).ready(function () {

	$('#accordion').find('.accordion-toggle').click(function() {
		$(this).next().slideToggle('fast');
		$(".accordion-content").not($(this).next()).slideUp('fast');
	});

	$('.add_book').click(function () {
		$('input[name="book[]"]').first().clone().val('').insertBefore($(this));
	});

	/* delete section */

	$('.librariers-btn-link').click(function (e) {
		e.preventDefault();
		sendAjax('/librariers-del', 'id=' + $(this).parent().parent().attr('class'), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/librariers/', 'librarier was not deleted');
		});
	});

	$('.books-btn-link').click(function (e) {
		e.preventDefault();
		sendAjax('/books-del', 'id=' + $(this).parent().parent().attr('class'), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/books/', 'book was not deleted');
		});
	});

	$('.readers-btn-link').click(function (e) {
		e.preventDefault();
		sendAjax('/readers-del', 'id=' + $(this).parent().parent().attr('class'), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/readers/', 'reader was not deleted');
		});
	});

	$('.delete').click(function (e) {
		e.preventDefault();
		sendAjax('/extradition-del', $(this).attr('href'), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/extradition/', 'extradition was not deleted');
		});
	});

	/* end delete section */

	/* add section */

	$('#fill_with_json').click(function (e) {
		e.preventDefault();
		sendAjax('/fill-db-from-json', '', function (answer) {
			alert(answer);
		});
	});

	$('.librariers_add').click(function (e) {
		e.preventDefault();
		sendAjax('/librariers-add', $('#librariers_add').serialize(), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/librariers/', 'librarier was not added');
		});
	});

	$('.books_add').click(function (e) {
		e.preventDefault();
		sendAjax('/books-add', $('#books_add').serialize(), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/books/', 'book was not added');
		});
	});

	$('.readers_add').click(function (e) {
		e.preventDefault();
		sendAjax('/readers-add', $('#readers_add').serialize(), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/readers/', 'reader was not added');
		});
	});

	$('.extradition_add').click(function (e) {
		e.preventDefault();
		sendAjax('/extradition-add', $('#extradition_add').serialize(), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/extradition/', 'extradition was not added');
		});
	});

	/* end add section*/

	/* upd section */

	$('.update').click(function (e) {
		e.preventDefault();
		sendAjax('/update', $(this).attr('href'), function (answer) {
			setResultOfAdding(answer, 'http://localhost:8000/extradition/', 'error with updating');
		});
	});

	/* end upd section */

});

function setResultOfAdding(res, link, message) {
	if (res == 1)
		$(location).attr("href", link);
	else
		alert(message);
}

function sendAjax(link, data, callback) {
	$.ajax({
		url: link,
		type: 'get',
		data: data,
		success: callback
	});
}