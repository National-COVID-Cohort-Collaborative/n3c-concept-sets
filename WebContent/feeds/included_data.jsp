<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CConceptSets">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select concept_id,concept_name from enclave_concept.concept_set_members where codeset_id = ?::int) AS foo;
	<sql:param>${param.id}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"concept_id", "label":"Concept ID"},
        {"value":"concept_name", "label":"Concept Name"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
