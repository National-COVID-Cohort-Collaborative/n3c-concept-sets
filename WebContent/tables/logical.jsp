<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$.getJSON("feeds/logical_data.jsp?id=${param.id}", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="logic_hierarchy";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("logic-div");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#logic_hierarchy').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 25,
    	lengthMenu: [ 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'concept_id', orderable: true },
        	{ data: 'concept_code', orderable: true },
        	{ data: 'concept_name', orderable: true },
        	{ data: 'domain', orderable: true },
        	{ data: 'standard_concept', orderable: true },
        	{ data: 'exclude', orderable: true },
        	{ data: 'descendants', orderable: true },
        	{ data: 'mapped', orderable: true }
    	]
	} );

	
});
</script>
