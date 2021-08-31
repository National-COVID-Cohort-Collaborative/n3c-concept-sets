<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row comor">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Concept Set Logic Hierarchy: ${alias}</div>
			<div class="panel-body">
				<div id="logic-div"></div>
				<jsp:include page="tables/logical.jsp"/>
			</div>
		</div>
	</div>
</div>
