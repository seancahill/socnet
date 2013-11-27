
<%@ page import="socnet.DemoUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'demoUser.label', default: 'DemoUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'demoUser.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="bio" title="${message(code: 'demoUser.bio.label', default: 'Bio')}" />
                        
                            <g:sortableColumn property="country" title="${message(code: 'demoUser.country.label', default: 'Country')}" />
                        
                            <g:sortableColumn property="likes" title="${message(code: 'demoUser.likes.label', default: 'Likes')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'demoUser.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="needs" title="${message(code: 'demoUser.needs.label', default: 'Needs')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${demoUserInstanceList}" status="i" var="demoUserInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${demoUserInstance.id}">${fieldValue(bean: demoUserInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: demoUserInstance, field: "bio")}</td>
                        
                            <td>${fieldValue(bean: demoUserInstance, field: "country")}</td>
                        
                            <td>${fieldValue(bean: demoUserInstance, field: "likes")}</td>
                        
                            <td>${fieldValue(bean: demoUserInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: demoUserInstance, field: "needs")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${demoUserInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
