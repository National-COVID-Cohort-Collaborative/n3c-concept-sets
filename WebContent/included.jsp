<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row comor">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Included Concepts: ${alias}</div>
			<div class="panel-body">
				<div id="included-div"></div>
				<jsp:include page="tables/included.jsp"/>
			</div>
		</div>
	</div>
</div>
