<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->
<div id="secondarydiv" class ="fright">
  <div class="content fright">
     <img src="${resource(dir:'images',file:'bucket.jpg')}" alt="Register for an API Key | Try our Demo | Read our FAQ" border="0" usemap="#bucket" />
     <map name="bucket">
        <area shape="poly" coords="0,0,148,0,19,140,0,140" href="${createLink(uri: '/user/create')}" alt="Register for an API Key" title="Register for an API Key" />
        <area shape="poly" coords="149,0,255,0,125,140,20,140" href="${createLink(uri: '/api/demo')}" alt="Try our Demo" title="Try our Demo" />
        <area shape="poly" coords="256,0,266,0,266,140,126,140" href="${createLink(uri: '/demoUser/faq')}" alt="Read our FAQ" title="Read our FAQ" />
     </map>
  </div>
</div>
 