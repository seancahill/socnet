
<%@ page import="socnet.UserStop" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userStop.label', default: 'UserStop')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">List Stop Words</g:link></span>
            <span id="loginHeader"><g:loginControl /></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'userStop.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="word" title="${message(code: 'userStop.word.label', default: 'Word')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userStopInstanceList}" status="i" var="userStopInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">                       
                            <td>${fieldValue(bean: userStopInstance, field: "word")}</td>                       
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userStopInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
