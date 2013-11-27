

<%@ page import="socnet.DemoUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'demoUser.label', default: 'DemoUser')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${demoUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${demoUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bio"><g:message code="demoUser.bio.label" default="Bio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'bio', 'errors')}">
                                    <g:textField name="bio" value="${demoUserInstance?.bio}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><g:message code="demoUser.country.label" default="Country" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'country', 'errors')}">
                                    <g:textField name="country" value="${demoUserInstance?.country}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="likes"><g:message code="demoUser.likes.label" default="Likes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'likes', 'errors')}">
                                    <g:textField name="likes" value="${demoUserInstance?.likes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="demoUser.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${demoUserInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="needs"><g:message code="demoUser.needs.label" default="Needs" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'needs', 'errors')}">
                                    <g:textField name="needs" value="${demoUserInstance?.needs}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="demoUser.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'state', 'errors')}">
                                    <g:textField name="state" value="${demoUserInstance?.state}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="town"><g:message code="demoUser.town.label" default="Town" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: demoUserInstance, field: 'town', 'errors')}">
                                    <g:textField name="town" value="${demoUserInstance?.town}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
