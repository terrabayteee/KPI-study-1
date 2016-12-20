$(document).ready(function () {

	$('.add_book').click(function () {
		$('input[name="book[]"]').parent().first().clone().val('').insertBefore($(this));
	});

	/* add section */

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

function deleteBook($id) {
	if ($('input[name="book[]"]').length - 1 == 0)
		return false;
	$($id).parent().remove();
}