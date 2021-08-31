<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="head.jsp" flush="true">
	<jsp:param name="title" value="N3C Concept Search" />
</jsp:include>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet">
	<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>


<style type="text/css" media="all">
@import "resources/layout.css";

ol {
    padding-inline-start: 10px;
    maring-left:0;
    padding-left:15px;
}

ul {
	padding-inline-start: 10px;
    maring-left:0;
    padding-left:25px;
}


input {
    padding-left: 7px;
    -webkit-box-sizing: border-box; 
    -moz-box-sizing: border-box;    
    box-sizing: border-box;       
}

.desc-list{
	width=45%;
	display=inline-block;
}


</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>
<body>
	<jsp:include page="header.jsp" flush="true" />

<sql:query var="label" dataSource="jdbc/N3CConceptSets">
	select alias from enclave_concept.concept_set where codeset_id = ?::int
	<sql:param>${param.id}</sql:param>
</sql:query>
<c:forEach items="${label.rows}" var="labelrow" varStatus="labelrowCounter">
	<c:set var="alias" scope="session">${labelrow.alias}</c:set>
</c:forEach>

	<div class="container-fluid" style="padding-left: 5%; padding-right: 5%;">
	<h3>N3C Concept Set Browser</h3>
		<ul class="nav nav-tabs" style="font-size: 16px;">
			<li class="active"><a data-toggle="tab" href="#overview">Overview</a></li>
			<li><a data-toggle="tab" href="#logical">Logic Hierarchy</a></li>
			<li><a data-toggle="tab" href="#included">Included Concepts</a></li>
			<li><a data-toggle="tab" href="#json">JSON</a></li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade in active" id="overview">
				<jsp:include page="overview.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="logical">
				<jsp:include page="logical.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="included">
				<jsp:include page="included.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="json">
				<jsp:include page="json.jsp" flush="true" />
			</div>
		</div>
		<div style="width: 100%; float: left">
			<jsp:include page="footer.jsp" flush="true" />
		</div>
	</div>
</body>

</html>
