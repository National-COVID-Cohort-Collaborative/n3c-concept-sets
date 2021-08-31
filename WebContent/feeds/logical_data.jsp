<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CConceptSets">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select concept_id,concept_code,concept_name,domain_id as domain,standard_concept,is_excluded as exclude,include_descendants as descendants,include_mapped as mapped from enclave_concept.code_set_concept where codeset_id = ?::int) AS foo;
	<sql:param>${param.id}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"concept_id", "label":"Concept ID"},
        {"value":"concept_code", "label":"Concept Code"},
        {"value":"concept_name", "label":"Concept Name"},
        {"value":"domain", "label":"Domain"},
        {"value":"standard_concept", "label":"Standard Concept"},
        {"value":"excluded", "label":"Excluded"},
        {"value":"descendants", "label":"Descendants"},
        {"value":"mapped", "label":"Mapped"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
