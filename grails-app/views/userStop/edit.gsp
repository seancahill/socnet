

<%@ page import="socnet.UserStop" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userStop.label', default: 'UserStop')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list">List Stop Words </g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Stop Word </g:link></span>
            <span id="loginHeader"><g:loginControl /></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userStopInstance}">
            <div class="errors">
                <g:renderErrors bean="${userStopInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${userStopInstance?.id}" />
                <g:hiddenField name="version" value="${userStopInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop hidden">
                                <td valign="top" class="name">
                                  <label for="apiKey"><g:message code="userStop.apiKey.label" default="Api Key" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userStopInstance, field: 'apiKey', 'errors')}">
                                    <g:textField name="apiKey" value="${userStopInstance?.apiKey}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="word"><g:message code="userStop.word.label" default="Word" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userStopInstance, field: 'word', 'errors')}">
                                    <g:textField name="word" value="${userStopInstance?.word}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
