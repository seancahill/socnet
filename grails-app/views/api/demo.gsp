
<%@ page import="socnet.Application" %>
<html>
  <head>
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'api.label', default: 'API')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>

  
</head>
<body>
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span id="loginHeader"> <g:loginControl /></span>
  </div>
  <div class="body">
    <div id="demomaindiv" class="fleft">
      <h1>Demo of Profiler Functionality</h1>
      <div class="smalldiv fleft">
      
      <p class ="smallpara"> We have a number of options to view how the application works. Please select from
          the list opposite to get a better understanding of how our application can work for your
          social network</p>
      </div>
      <div class="fleft">
        <ul class="listcss">
          <li>
            <a href="${createLink(uri: '/demoUser/makeContact')}" >Profile Matching </a>
          </li>
          <li>
            <a href="${createLink(uri: '/demoUser/stemText')}" >Parse Text to Keywords</a>
          </li>
          <li>
            <a href="${createLink(uri: '/demoUser/viewIndex')}" >View Index Example</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
<g:render template="/shared/sidebar"/>
</body>

</html>
