$(document).ready(function() {$('#products').dataTable( {
					'bScrollInfinite': true,
					'bScrollCollapse': true,
					'sScrollY': '200px',
					'bProcessing': true,
					'bServerSide': true,
					'sAjaxSource': 'http://localhost:3000/admin/tbl_countries/search.datatables',
    "aaSorting"       : [[0, 'asc']],
    "aoColumns"       : [
      {"sName":"name"},
      {"sName":"printale_name"},
      {"sName":"iso3"},
    ],
    "fnServerData"    : simpleDatatables
									} );} );