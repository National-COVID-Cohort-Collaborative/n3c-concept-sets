<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row comor top_panel">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Concept Set Overview: ${alias}</div>
			<div class="panel-body">
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
					coalesce(name, first_name||' '||last_name) as author,
					limitations,
					issues,
					provenance
				from enclave_concept.concept_set_display
				where codeset_id = ?::int
				<sql:param>${param.id}</sql:param>
			</sql:query>
			<c:forEach items="${concept.rows}" var="row" varStatus="rowCounter">
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
						<td>${row.author}</td>
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
				</table>
			</c:forEach>
			</div>
		</div>
	</div>
</div>
