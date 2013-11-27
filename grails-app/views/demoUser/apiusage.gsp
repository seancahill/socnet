<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

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
  <div style="margin-left: 20em; width: 50%" class="fleft">
    <h1>API Usage </h1><br/><br/>
    <div style="margin-left: 5em;" class="fleft">
      <h2>Profile a User</h2>
      <p class="paddy">The application is intended for use by social networks. The application takes a user profile and
        indexes the profile data based on the keywords within the profile data.</p>
      <h2>Retrieve a Users Matches</h2>
      <p class="paddy">Most social networks don't allow users to search for other users based on profile
        matching. Our application will allow users to find other users with similar profiles. This could be
        based on their biography, their needs and wants or their interests and hobbies.</p>
      <h2>Compare two Users</h2>
      <p class="paddy">You need to register for an API key to use the application. You use this API key with
         any api calls you make.</p>
      <h2>I'm worried about the security of my users data</h2>
      <p class="paddy">We don't hold any private data on our databases. We only require the profile text and a unique
         identifier to distinguish between users. This needs to be provided by the client and can
         be encrypted if desired.</p>
      <h2>I am seeing terms indexed that I don't require</h2>
      <p class="paddy">We use a system of stop words e.g 'I','am' etc. that will be removed from the profile text.
        Once signed up clients can add to these stop words to improve the indexing process.</p>

    </div>
  </div>


  <div class="shifto">
    <g:render template="/shared/sidebar"/>
  </div>
  <div class="clear"></div>
</body>

</html>

