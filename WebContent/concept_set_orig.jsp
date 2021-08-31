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
<style type="text/css" media="all">
@import "resources/layout.css";
</style>

<body>
	<jsp:include page="header.jsp" flush="true" />

	<div class="container-fluid" style="padding-left: 5%; padding-right: 5%;">
		<br /> <br />
		<div class="col-sm-9" style="float: left">
			<sql:query var="concept" dataSource="jdbc/N3CConceptSets">
				select
					codeset_id,
					alias,
					intention,
					version,
					is_most_recent_version,
					update_message,
					provisional_approval_date,
					release_name,
					created_by,
					limitations,
					issues,
					provenance,
					json
				from enclave_concept.concept_set
				where codeset_id = ?::int
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
						<th>Code Set Name</th>
						<td>${row.alias}</td>
					</tr>
					<tr>
						<th>Intention</th>
						<td>${row.intension}</td>
					</tr>
					<tr>
						<th>Version</th>
						<td>${row.version}</td>
					</tr>
					<tr>
						<th>Flag for most recent</th>
						<td>${row.is_most_recent_version}</td>
					</tr>
					<tr>
						<th>Update Note</th>
						<td>${row.update_message}</td>
					</tr>
					<tr>
						<th>Provisional Approval Date</th>
						<td>${row.provisional_approval_date}</td>
					</tr>
					<tr>
						<th>Release Name</th>
						<td>${row.release_name}</td>
					</tr>
					<tr>
						<th>Author</th>
						<td>${row.created_by}</td>
					</tr>
					<tr>
						<th>Project Names</th>
						<td>
							<sql:query var="project" dataSource="jdbc/N3CConceptSets">
								select research_project_id,title from enclave_concept.concept_set_project where codeset_id = ?::int
								<sql:param>${param.id}</sql:param>
							</sql:query>
							<ul>
							<c:forEach items="${project.rows}" var="prow" varStatus="prowCounter">
								<li><b>${prow.research_project_id}</b> ${prow.title}
							</c:forEach>
							</ul>
						</td>
					</tr>
					<tr>
						<th>Description</th>
						<td>${row.limitiations}</td>
					</tr>
					<tr>
						<th>Issues</th>
						<td>${row.issues}</td>
					</tr>
					<tr>
						<th>Provenance</th>
						<td>${row.provenance}</td>
					</tr>
					<tr>
						<th>JSON Definition</th>
						<td><pre>${row.json}</pre></td>
					</tr>
				</table>
			</c:forEach>
		</div>
		<div class="col-sm-3" style="float: left">
			<h3>Similar Concept Sets</h3>
			<sql:query var="concept" dataSource="jdbc/N3CConceptSets">
				select concept_set.codeset_id, alias,count
				from
					enclave_concept.concept_set
				natural join
					(select foo.codeset_id,count(*)
					from enclave_concept.concept_set_members as foo, enclave_concept.concept_set_members as bar
					where bar.codeset_id = ?::int
					  and foo.concept_id = bar.concept_id
					  and foo.codeset_id <> bar.codeset_id
					group by 1) as counter
				-- where is_most_recent_version and status is not null
				order by 3 desc, 2;
				<sql:param>${param.id}</sql:param>
			</sql:query>
			<table class="table table-striped">
				<tr>
					<th>Concept Set Name</th>
					<th>Match Count</th>
				</tr>
				<c:forEach items="${concept.rows}" var="row" varStatus="rowCounter">
					<tr>
						<td><a href="concept_set.jsp?id=${row.codeset_id}">${row.alias}</a></td>
						<td>${row.count}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div style="width: 100%; float: left">
			<jsp:include page="footer.jsp" flush="true" />
		</div>
	</div>
</body>

</html>
