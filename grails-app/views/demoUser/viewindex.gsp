<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page import="socnet.DemoUser" %>
<html>
  <head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'demoUser.label', default: 'DemoUser')}" />
    <g:javascript library="hosturl" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>

  <script type="text/JavaScript">

  </script>
</head>
<body>
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" controller="api" action="demo"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span id="loginHeader"> <g:loginControl /></span>
  </div>
    
    <div id ="viewuserlist" class="fleft">
      <h2 id="showhead" >How Profiles are Indexed</h2>
      <ul>

        <g:each in="${demoUserInstanceList}" status="i" var="demoUserInstance">
          <li  id="${demoUserInstance.identity}" class="fleft">
            <img width="32px" height="32px" style="padding-right: 1em;" class="fleft" src="../images/${i+1}.jpg" alt="${message(code:'spinner.alt',default:'Loading...')}" />
            <p>${demoUserInstance.name}</p>
            <p>${demoUserInstance.country}, ${demoUserInstance.state}, ${demoUserInstance.town}</p>
            <span class="heading">  Profile for id: ${demoUserInstance.identity} </span>
            <div id="show${demoUserInstance.identity}" class="view">
              <g:message code="demoUser.bio.label" default="Bio" />
              <p  id="highlight${demoUserInstance.identity}">${demoUserInstance.bio}</p>

              <g:message code="demoUser.likes.label" default="Likes" />
              <p id="highlightlikes${demoUserInstance.identity}"">${demoUserInstance.likes}</p>

              <g:message code="demoUser.needs.label" default="Needs" />
              <p id="highlightneeds${demoUserInstance.identity}">${demoUserInstance.needs}</p>
               </div>
          </li>
        </g:each>

      </ul>

    </div>
    <div class="shifto">
    <g:render template="/shared/sidebar"/>
    </div>
    <div class="clear"></div>
    <div>
      <img src="${resource(dir:'images',file:'index.PNG')}" alt="index image"/>
    </div>
    <p style="padding: 1em;">n.b. the above diagram is not complete but shows a subset of how these users would be indexed.</p>
</body>

</html>
