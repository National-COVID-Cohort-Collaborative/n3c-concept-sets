<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="logo-span">
<a href="https://ctsa.ncats.nih.gov/cd2h/"><img width="500" height="500"
   src="https://ctsa.ncats.nih.gov/cd2h/wp-content/uploads/sites/7/2018/10/site_logo-768x229.png"
   class="image wp-image-15  attachment-full size-full" alt=""
   style="max-width: 10%; height: auto;"/></a>
   
<a href="https://ctsa.ncats.nih.gov/"><img width="500"
						height="500"
						src="https://ctsa.ncats.nih.gov/cd2h/wp-content/uploads/sites/7/2018/10/ctsa-g-logo.png"
						class="image wp-image-15  attachment-full size-full" alt=""
						style="max-width: 15%; height: auto;" /></a>
   
<a href="https://ncats.nih.gov/"><img width="500"
						height="500"
						src="https://ctsa.ncats.nih.gov/cd2h/wp-content/uploads/sites/7/2018/10/NIHlogo-300x69.png"
						class="image wp-image-15  attachment-full size-full" alt=""
						style="max-width: 15%; height: auto;"/></a>

</div>
                        
                        

<nav class="navbar navbar-expand-lg navbar-dark bg-dark pt-0 pb-1">
  <a id="labs_image" onmouseover="animateScript()" onmouseout="stopanimate()" class="navbar-brand" href="http://labs.cd2h.org" title="Labs Home"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="<util:applicationRoot/>/">Home</a>
			</li>
    </ul>
  </div>
</nav>

<script>
$(document).on('click', '.dropdown-menu .nav-card', function (e) {
	  e.stopPropagation();
	});
	
var tID; 

function stopanimate() {
	document.getElementById("labs_image").style.backgroundPosition = "-" + 330 + "px 0px"; 
	clearInterval(tID);} 

function animateScript() {
	var    position = 110; 
	const  interval = 370; 
	const  diff = 110;     
	tID = setInterval ( () => {
		document.getElementById("labs_image").style.backgroundPosition = "-" + position + "px 0px"; 
		console.log("-" + position + "px 0px");
		if (position < 330)
			{ position = position + diff;}
		else
			{ position = 0; }
	}, interval ); 
} 

</script>