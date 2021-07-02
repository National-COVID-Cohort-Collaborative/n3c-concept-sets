<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="head.jsp" flush="true">
	<jsp:param name="title" value="CTSAsearch" />
</jsp:include>
<style type="text/css" media="all">
@import "resources/layout.css";

ol {
	padding-inline-start: 10px;
	maring-left: 0;
	padding-left: 15px;
}

ul {
	padding-inline-start: 10px;
	maring-left: 0;
	padding-left: 25px;
}

input {
	padding-left: 7px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.desc-list {width =45%;display =inline-block;
	
}
</style>

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="header.jsp" flush="true" />

	<div class="container-fluid"
		style="padding-left: 5%; padding-right: 5%;">
		<br /> <br />
		<div class="col">
			<sql:query var="concept" dataSource="jdbc/N3CConceptSets">
			select codeset_id,concept_set_name,jsonb_pretty(atlas_json::jsonb) as json from enclave_concept.code_sets where codeset_id = ?::int
			<sql:param>${param.id}</sql:param>
			</sql:query>
			<c:forEach items="${concept.rows}" var="row" varStatus="rowCounter">
				<h2>Concept Set: ${row.concept_set_name}</h2>
				<table class="table table-striped">
					<tr>
						<th>Code Set ID</th>
						<td>${row.codeset_id}</td>
					</tr>
					<tr>
						<th>Concept Set Name</th>
						<td>${row.concept_set_name}</td>
					</tr>
					<tr>
						<th>JSON Definition</th>
						<td><pre>${row.json}</pre></td>
					</tr>
				</table>
			</c:forEach>
			<div style="width: 100%; float: left">
				<jsp:include page="footer.jsp" flush="true" />
			</div>
		</div>
	</div>

</body>

</html>
