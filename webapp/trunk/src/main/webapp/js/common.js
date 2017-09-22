var editableTable;

$(function() {
	eventBinder();
	initTable();
	initLeftMenuScroll();
});

$(window).load(function() {
	$(".loader_inner").fadeOut();
	$(".loader").delay(400).fadeOut("slow");
});

function initTable() {
	editableTable = $('.js-editable-table').DataTable();
}

function initLeftMenuScroll() {
	$('.js-left-navigation').mCustomScrollbar({
		theme:"minimal"
	});
}

function eventBinder() {
	$('body')
		.on('click', '.js-toggle-menu', function() {
			toggleLeftMenu(this);
		})
		.on('click', '.js-left-menu-list li a', function() {
			if($(this).closest('.js-left-menu.opened').length) {
				$(this).toggleClass('opened');
				if($(this).hasClass('opened')) {
					$(this).next().slideToggle(200).addClass('opened');
				} else {
					$(this).next().removeClass('opened').slideToggle(200);
				}
			}
			$(this).closest('.js-left-menu-list').find('.active-item').removeClass('active-item');
			$(this).addClass('active-item');
			openLeftMenu($(this).closest('.js-left-menu').find('.js-toggle-menu'));
		}).on('click', '.js-main-item', function() {
		$(this).closest('.js-left-menu-list').find('li.active').removeClass('active');
		$(this).closest('li').addClass('active');
	})
		.on('click', '.js-prevent-default', function(e) {
			e.preventDefault();
		})
		.on('click', '.js-row-edit', function(e) {
			e.preventDefault();
			table.editTableRow(this);
		})
		.on('click', '.js-row-save', function(e) {
			e.preventDefault();
			table.rowSave(this);
		})
		.on('click', '.js-row-cancel', function(e) {
			e.preventDefault();
			e.stopPropagation();
			table.rowCancel(this);
		})
		.on('click', '.js-add-row', function(e) {
			table.addRow();
		})
}


var table = {
	editTableRow: function(element) {
		var $element = $(element),
			$row = $element.parents('tr'),
			value, textarea;
		$element.hide();
		$element.parent().find('.js-row-save, .js-row-cancel').show();
		$row.find('td > div').not('.js-not-editable').each(function () {
			value = $(this).text().trim();
			$(this).attr('default-value', value);
			textarea = '<div><textarea style="padding: 0 5px;" rows="3" cols="40">' + value + '</textarea></div>';
			$(this).html(textarea);
		});

	},
	rowSave: function(element) {
		var $element = $(element),
			$row = $element.parents('tr'),
			id = $element.parent().find('.js-row-info').data('identifiableid'),
			allAttributes = $element.parent().find('.js-row-info').data(),
			$thead = $element.closest('table').find('thead'),
			tableColName = [], rowValues = {};
		if (Object.keys(allAttributes).length == 0) { // если запись новая
			editableTable.row($row).remove().draw();
		}
		$thead.find('th').not('.js-not-editable-col').each(function () {
			tableColName.push($(this).data('name'));
		});
		$row.find('td > div').not('.js-not-editable').each(function (index) {
			rowValues[tableColName[index]] = $(this).find('textarea').val();
		});

		var info = {
			'values' : rowValues,
			'additionalInfo': allAttributes
		};

		var json_data = JSON.stringify(info);
		showLoader();
		$.ajax({
			url: "/getCreateResult",
			type: "POST",
			data: json_data,
			contentType : "application/json",
			dataType: 'json',

			/* JSON который отсылается на сервер если запись новая:
			 {"values":{"id":"id1","locale":"locale1","code":"code1","value":"value1"},"additionalInfo":{}}
			 */

			/* JSON который отсылается на сервер если запись редактируется:
			 {"values":{"id":"1","locale":"ru1","code":"passengers.auto.fill","value":"test"},"additionalInfo":{"identifiableid":111,"test":222}}
			 */

			/* JSON который должен прийти с сервера в случаи редактирования записи:
			 {"edited": true}';
			 */

			/* JSON который должен прийти с сервера в случаи добавления новой записи:
			 {"values":{"id":"1","locale":"locale1","code":"code1","value":"value1"},"additionalInfo":{"identifiableid":11100,"test":222}, "addedrow":true}
			 */

			success: function(data) {
				var newValue, $td;
				$td = $element.parents('td');
				if(data.addedrow) { // только что добавленная строка, а не редактируемая
					var dataArray = [], attributes = '';
					for(var i = 0; i < tableColName.length; i++) {
						dataArray.push('<div>' + data.values[tableColName[i]] + '</div>');
					}

					for (var key in data.additionalInfo) {
						attributes += 'data-' + key + '=' + data.additionalInfo[key] + ' ';
					}
					var buttons = '<div class="test-test js-not-editable"> ' +
						'<div class="hidden js-row-info" '+ attributes +'></div>' +
						'<a class="js-row-edit" href="#">Edit</a> ' +
						'<a class="js-row-save" style="display: none;" href="#" type="Submit">Save </a> ' +
						'<a class="js-row-cancel" style="display: none;" href="#">Cancel</a> ' +
						'</div>';

					dataArray.push(buttons);
					editableTable.row.add(dataArray).draw();
				} else if(data.edited) {
					$row.find('td > div').not('.js-not-editable').each(function (index) {
						newValue = $(this).find('textarea').val();
						$(this).text(newValue);
					});
				} else {
					$element.parent().find('.js-row-cancel').trigger('click');
				}
				$td.find('.js-row-edit').show();
				$td.find('.js-row-save, .js-row-cancel').hide();
				hideLoader();
				$('.js-ajax-messages').html('<div class="alert alert-success"> <strong>Success! </strong>Saved</div>');
			},
			error: function(error) {
				$('.js-ajax-messages').html('<div class="alert alert-danger"> <strong>Error! </strong>Not saved</div>');
				hideLoader();
				$element.parent().find('.js-row-cancel').trigger('click');
			}
		});
	},
	rowCancel: function(element) {
		var $element = $(element),
			$row = $element.parents('tr'),
			$td = $element.parent(),
			defaultValue;
		$element.hide();
		$td.find('.js-row-save').hide();
		$td.find('.js-row-edit').show();
		$row.find('td > div').not('.js-not-editable').each(function () {
			defaultValue = $(this).attr('default-value');
			if (typeof defaultValue !== "undefined") {
				$(this).text(defaultValue);
			} else {
				editableTable.row($(this).parents('tr')).remove().draw();
				return false;
			}
		});
	},
	addRow: function() {
		var $th = $('.js-editable-table thead th'),
			notEditableCol = [],
			textarea = '<td><div><textarea style="padding: 0 5px;" rows="3" cols="40"></textarea></div></td>',
			emptyTd = '<td><div></div></td>';
		$th.each(function (index) {
			if($(this).hasClass('js-not-editable-col')) {
				notEditableCol.push(index);
			}
		});
		var row = $('<tr>');
		for (var i = 0; i < $th.length; i++) {
			if($.inArray(i, notEditableCol) != -1) {
				if (i == $th.length - 1) {
					row.append('<td><div class="js-not-editable"> ' +
					'<div class="hidden js-row-info"></div>' +
					'<a class="js-row-edit" style="display: none;" href="#">Edit</a> ' +
					'<a class="js-row-save" href="#">Save </a> ' +
					'<a class="js-row-cancel" href="#">Cancel</a> ' +
					'</div></td>');
				} else {
					row.append(emptyTd);
				}
			} else {
				row.append(textarea);
			}
		}
		editableTable.row.add(row);
		$('.js-editable-table tbody').prepend(row);
	}
};

function showLoader() {
	$('.js-loader, .js-loader div').show();
}

function hideLoader() {
	$('.js-loader, .js-loader div').hide();
}

function toggleLeftMenu(element) {
	var $element = $(element);
	$element.toggleClass("active");
	$element.closest('.js-left-menu').toggleClass("opened");
	$element.closest('.js-page').toggleClass("expanded");
}

function openLeftMenu(element) {
	var $element = $(element);
	$element.addClass("active");
	$element.closest('.js-left-menu').addClass("opened");
	$element.closest('.js-page').addClass("expanded");
}
