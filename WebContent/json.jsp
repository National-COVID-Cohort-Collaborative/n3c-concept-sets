<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row comor top_panel">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Concept Set JSON: ${alias}</div>
			<div class="panel-body">
			<sql:query var="concept" dataSource="jdbc/N3CConceptSets">
				select json from enclave_concept.concept_set
				where codeset_id = ?::int;
				<sql:param>${param.id}</sql:param>
			</sql:query>			
			<c:forEach items="${concept.rows}" var="row" varStatus="rowCounter">
				<pre>${row.json}</pre>
			</c:forEach>
			</div>
		</div>
	</div>
</div>
