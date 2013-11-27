
<%@ page import="socnet.LoginUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'loginUser.label', default: 'LoginUser')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'loginUser.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="login" title="${message(code: 'loginUser.login.label', default: 'Login')}" />
                        
                            <g:sortableColumn property="password" title="${message(code: 'loginUser.password.label', default: 'Password')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${loginUserInstanceList}" status="i" var="loginUserInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${loginUserInstance.id}">${fieldValue(bean: loginUserInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: loginUserInstance, field: "login")}</td>
                        
                            <td>${fieldValue(bean: loginUserInstance, field: "password")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${loginUserInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
