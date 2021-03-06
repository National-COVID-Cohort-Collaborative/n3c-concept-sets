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

<body class="home page-template-default page page-id-6 CD2H">
	<jsp:include page="header.jsp" flush="true" />

	<div class="container-fluid" style="padding-left:5%; padding-right:5%;">
		<br/> <br/> 
		<div class="col">
			<h2><i style="color:#7bbac6;"class="fas fa-search"></i> Concept Set Search</h2>
			<div id=form>
				<form method='POST' action='<util:applicationRoot/>/index.jsp'>
					<fieldset>
						<input class='search-box' name="query" value="${param.query}" size=50> 
						<input type=submit name=submitButton value=Go!>
						<c:if test="${not empty param.query}">
							<a class="search-reset" href="index.jsp" title="Reset Search"><i class="far fa-times-circle"></i></a>
						</c:if>
					</fieldset>
				</form>
			</div>
			<br/>
			<c:choose>
			<c:when test="${not empty param.query}">
				<p/>
				<c:set var="host"><util:requestingHost /></c:set>
				<util:Log line="" message="requesting host: ${host}" page="ctsaSearch" level="INFO"></util:Log>
				<util:Log line="" message="query: ${param.query}"	page="ctsaSearch" level="INFO"></util:Log>
				
				<h3><c:out value="${displayString}" /></h3>
                <div style="width: 100%; float: left">
				<lucene:taxonomy taxonomyPath="/usr/local/CD2H/lucene/concept_sets_tax">
					<lucene:countFacetRequest categoryPath="N3C Status" depth="3" />
					<lucene:countFacetRequest categoryPath="OMOP Domain" depth="3" />
					<lucene:countFacetRequest categoryPath="OMOP Class" depth="2" />
					<lucene:countFacetRequest categoryPath="Author" depth="2" />
					
					<c:set var="drillDownList"><lucene:drillDownProcessor categoryPaths="${param.drillDown}" drillUpCategory="${param.drillUp}" drillOutCategory="${param.drillOut}" /></c:set>

					<lucene:search lucenePath="/usr/local/CD2H/lucene/concept_sets" label="content" queryParserName="biomedical" queryString="${param.query}" useConjunctionByDefault="true">
						<div style="with: 100%">
							<div id ="facet-box" style="width: 40%; padding: 0px 80px 0px 0px; float: left">
								<h5>Facets:</h5>
								<div class='card' style="with: 100%">
								<div class="card-body" style="padding-right:30px">
								<ol class="facetList" id='top'>
									<lucene:facetIterator>
										<c:set var="facet1"><lucene:facet label="content" /></c:set>
                                        <c:set var="facetCount"><lucene:facet label="count" /></c:set>
                                        <c:if test="${facetCount > 0 }">
                                        <div class = 'facet-top-content-box'>
                                        	<c:set var="chevrontop"> 
													<c:choose>
														<c:when test="${fn:contains(drillDownList, facet1)}">
															fas fa-chevron-down 
														</c:when>
														<c:otherwise>
															fas fa-chevron-right
														</c:otherwise>
													</c:choose>
											</c:set>
											<li>
												<div class = 'facet-list-dropdown'>
													<button class="btn btn-facet" type="button" data-toggle="collapse" data-target='${"#facet-med-content-box"}${fn:replace(facet1," ", "")}' aria-expanded="false" aria-controls='${"facet-med-content-box"}${fn:replace(facet1," ", "")}'>
														<span class="fas-li"><i class="${chevrontop}"></i></span>
													</button>
												</div>
												<div class = 'facet-list-item'>
													<lucene:facet label="content"> (<lucene:facet label="count" />)
												</div>
												
												<!-- Toggles Collapse based on which facets are hot  -->
												<c:set var="position_med"> 
													<c:choose>
														<c:when test="${fn:contains(drillDownList, facet1)}">
															'collapse show' 
														</c:when>
														<c:otherwise>
															'collapse'
														</c:otherwise>
													</c:choose>
												</c:set>
												
												<div class=${position_med} id ='${"facet-med-content-box"}${fn:replace(facet1," ", "")}'>
	                                            <ol class="facetList">
														<lucene:facetIterator>
															<c:set var="facet2path">${facet1}/<lucene:facet	label="content"/></c:set>
															<c:set var="facet2"><lucene:facet label="content" /></c:set>
															<lucene:facet label="none">
															
															<c:set var="count_children">0</c:set>
															<lucene:facetIterator>
																<c:set var="count_children">${count_children + 1}</c:set>
															</lucene:facetIterator>
															
																<c:choose>
																	<c:when test="${count_children == 0 and not fn:contains(drillDownList, facet2path.concat('|')) and not fn:contains(drillDownList, facet2path)}">
																		<li>
 																			<div class = 'facet-list-dropdown'> 
 																				<button class="btn btn-facet" type="button">
																					<span class="fas-li"><i class="fas fa-minus"></i></span>
																				</button>
																			</div>
																			<div class = 'facet-list-item'>
																				<a href="index.jsp?query=${param.query}&drillDown=${drillDownList}${facet2path}">${facet2}</a> (<lucene:facet label="count" />)
																			</div>
																	</c:when>
																	<c:when	test="${fn:contains(drillDownList, facet2path.concat('|')) and count_children ==0}">
																		<li>
 																			<div class = 'facet-list-dropdown'> 
 																				<button class="btn btn-facet" type="button">
																					<span class="fas-li"><i class="fas fa-minus"></i></span>
																				</button>
																			</div>
																			<div class = 'facet-list-item'>
																				<lucene:facet label="content" /> <a	class="facet-move" href="index.jsp?query=${param.query}&drillDown=${drillDownList}&drillUp=${facet2path}" title="Remove Filter"><i class="far fa-times-circle"></i></a>
																			</div>
																	</c:when>
																	<c:when test="${fn:contains(drillDownList, facet2path) and count_children ==0}">
																		<li>
																			<div class = 'facet-list-dropdown'>
																				<button class="btn btn-facet" type="button">
																					<span class="fas-li"><i class="fas fa-minus"></i></span>
																				</button>
																			</div>
																			<div class = 'facet-list-item'>
																				<lucene:facet label="content" />
																			</div>
																	</c:when>
																	<c:when	test="${fn:contains(drillDownList, facet2path.concat('|'))}">
																		<li>
 																			<div class = 'facet-list-dropdown'> 
 																				<button class="btn btn-facet" type="button" data-toggle="collapse" data-target='${"#facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}' aria-expanded="false" aria-controls='${"facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}'>
																					<span class="fas-li"><i class="fas fa-chevron-down"></i></span>
																				</button>
																			</div>
																			<div class = 'facet-list-item'>
																				<lucene:facet label="content" /> <a	class="facet-move" href="index.jsp?query=${param.query}&drillDown=${drillDownList}&drillUp=${facet2path}" title="Remove Filter"><i class="far fa-times-circle"></i></a>
																			</div>
																	</c:when>
																	<c:when test="${fn:contains(drillDownList, facet2path)}">
																		<li>
																			<div class = 'facet-list-dropdown'>
																				<button class="btn btn-facet" type="button" data-toggle="collapse" data-target='${"#facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}' aria-expanded="false" aria-controls='${"facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}'>
																					<span class="fas-li"><i class="fas fa-chevron-down"></i></span>
																				</button>
																			</div>
																			<div class = 'facet-list-item'>
																				<lucene:facet label="content" />
																			</div>
																	</c:when>
																	<c:otherwise>
																		<li>
																			<div class = 'facet-list-dropdown'>
																				<button class="btn btn-facet" type="button" data-toggle="collapse" data-target='${"#facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}' aria-expanded="false" aria-controls='${"facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}'>
																					<span class="fas-li"><i class="fas fa-chevron-right"></i></span>
																				</button>
																			</div>
																			<div class = 'facet-list-item'> 
																				<a href="index.jsp?query=${param.query}&drillDown=${drillDownList}${facet2path}">${facet2}</a> (<lucene:facet label="count" />)
																			</div>
																	</c:otherwise>
																</c:choose>
															
															
																<!-- Toggles Collapse based on which facets are hot  -->
																	<c:set var="position_low"> 
																		<c:choose>
																			<c:when test="${fn:contains(drillDownList, facet2)}">
																				'collapse show' 
																			</c:when>
																			<c:otherwise>
																				'collapse'
																			</c:otherwise>
																		</c:choose>
																	</c:set>
																	<div class=${position_low} id ='${"facet-low-content-box"}${facet2.replaceAll("[\\W]+", "")}'>
																	<ul class="innerFacetList">
																		<lucene:facetIterator>
																			<c:set var="facet3path">${facet2path}/<lucene:facet	label="content" /></c:set>
																			<c:set var="facet3"><lucene:facet label="content" /></c:set>
																			<lucene:facet label="none">
																				<c:choose>
																					<c:when	test="${fn:contains(drillDownList, facet3path.concat('|'))}">
																						<li><lucene:facet label="content" />
																						<a	class='facet-move' href="index.jsp?query=${param.query}&drillDown=${drillDownList}&drillOut=${facet3path}" title="Remove This Filter"><i class="far fa-arrow-alt-circle-left"></i></a>
				                                                                      	<a  class='facet-move' href="index.jsp?query=${param.query}&drillDown=${drillDownList}&drillUp=${facet3path}" title="Remove All Filters in Category"><i class="far fa-times-circle"></i></a>
		        																	</c:when>
																					<c:when	test="${fn:contains(drillDownList, facet3path)}">
																						<li><lucene:facet label="content" />
																					</c:when>
																					<c:otherwise>
																						<li><a	href="index.jsp?query=${param.query}&drillDown=${drillDownList}${facet3path}">${facet3}</a> (<lucene:facet label="count" />)
																					</c:otherwise>
																				</c:choose></li>
												                              </lucene:facet>
											                           </lucene:facetIterator>
										                            </ul>
										                            </div>
									                            </li>
									                        </lucene:facet>
									                    </lucene:facetIterator>
									                </ol>
									                </div>
									                    </lucene:facet>
									                </li>
									    </div>
                                        </c:if>
								        </lucene:facetIterator>
								</ol>
								</div>
								</div>
							</div>
							<div id="results-box">
								<div id="results-header-box">
									<h3 id="results-header">Search Results:</h3>
									<p>Result Count: <lucene:count /></p>
								</div>
								<div id="results-table" onscroll="scrollFunction()">
									<table style="width:100%">
	  									<tr>
	    									<th>Concept Set</th>
	  									</tr>
										<lucene:searchIterator>
											<tr>
												<td><a href="concept_set.jsp?id=<lucene:hit label="id" />"><lucene:hit label="label" /></a></td>
											<tr>
										</lucene:searchIterator>
									</table>
								</div>
								<div id="results-scroll" style="text-align:right;">
									<button id="backtop" title="Back to Top"><i class="fas fa-chevron-up"></i></button>
								</div>
							</div>
						</div>
					</lucene:search>
				</lucene:taxonomy>
                </div>
			</c:when>
			<c:otherwise>
				<div class='desc-text' style="width:80%;">
				<p>This proof-of-concept explores multi-faceted search across N3C concept sets.
				<b>Comments and questions are welcome!</b> We are particularly interested in feedback regarding the nature and organization of the facets used to filter search results. The facet taxonomy is readily
				restructured as we index data.</p>
				</div>
		</div>
	</div>
				
			
			</c:otherwise>
			</c:choose>
            <div style="width: 100%; float: left">
                <jsp:include page="footer.jsp" flush="true" />
            </div>
		</div>
	</div>

<script>
$('#backtop').on('click', function() {
	$('#results-table').scrollTop(0);
});


function scrollFunction() {
	  if ($('#results-table').scrollTop() < 1000) {
	    document.getElementById("backtop").style.opacity = 0;
	  } else {
	    document.getElementById("backtop").style.opacity = 0.8;
	  }
};


$('.collapse').on('show.bs.collapse', function(e) {
    $(e.target).siblings('.facet-list-dropdown').find('i').removeClass().addClass('fas fa-chevron-down');
});

$('.collapse').on('hide.bs.collapse', function(e) {
    $(e.target).siblings('.facet-list-dropdown').find('i').removeClass().addClass('fas fa-chevron-right');
});

$('.collapse').on('shown.bs.collapse', function(e) {
    $(e.target).siblings('.facet-list-dropdown').find('i').removeClass().addClass('fas fa-chevron-down');
    if ($("#facet-box").height() > $(window).width()*.3){
    	$("#results-table").css({'height':($("#facet-box").height()-$("#results-header-box").height()+'px')});
    } else {
    	$("#results-table").css({'height':($(window).width()*.3+'px')});
    };
    
});

$('.collapse').on('hidden.bs.collapse', function(e) {
    $(e.target).siblings('.facet-list-dropdown').find('i').removeClass().addClass('fas fa-chevron-right');
    if ($("#facet-box").height() > $(window).width()*.3){
    	$("#results-table").css({'height':($("#facet-box").height()-$("#results-header-box").height()+'px')});
    } else {
    	$("#results-table").css({'height':($(window).width()*.3+'px')});
    };
});


if ($("#facet-box").height() > $(window).width()*.3){
	$("#results-table").css({'height':($("#facet-box").height()-$("#results-header-box").height()+'px')});
} else {
	$("#results-table").css({'height':($(window).width()*.3+'px')});
};

</script>
</body>

</html>
